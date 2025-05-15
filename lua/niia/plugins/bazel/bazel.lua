local bazel = require("bazel")

local M = {}

local function BufDir()
  local bufnr = vim.fn.bufnr()
  return vim.fn.expand(("#%d:p:h"):format(bufnr))
end

local function Split(s, delimiter)
  local result = {}
  for match in (s .. delimiter):gmatch("(.-)" .. delimiter) do
    table.insert(result, match)
  end
  return result
end

local function StartDebugger(type, program, args, cwd, env, workspace)
  require("dap").run({
    name = "Launch",
    type = type,
    request = "launch",
    program = function()
      return program
    end,
    env = env,
    args = args,
    cwd = cwd,
    runInTerminal = false,
    stopOnEntry = false,
    setupCommands = { { text = "-enable-pretty-printing", ignoreFailures = true } },
    sourceFileMap = { ["/proc/self/cwd"] = workspace },
  })
end

function M.YankLabel()
  local label = vim.fn.GetLabel()
  print("yanking " .. label .. ' to + and " register')
  vim.fn.setreg("+", label)
  vim.fn.setreg('"', label)
end

local function get_python_imports(bazel_info)
  local command = "grep 'python_imports =' " .. bazel_info.executable .. [[ | sed "s|.*'\(.*\)'|\1|"]]
  return vim.fn.trim(vim.fn.system(command))
end

local function get_python_executable(bazel_info)
  local command = [[grep -oP "rel_path = '.*'" ]]
    .. bazel_info.executable
    .. [[ | grep -o "'.*'" | tail -c +2 | head -c -2]]
  return bazel_info.runfiles .. "/" .. vim.fn.trim(vim.fn.system(command))
end

local function get_bazel_python_modules(bazel_info)
  local imports = Split(get_python_imports(bazel_info), ":")
  local extra_paths = { bazel_info.runfiles }
  for _, import in pairs(imports) do
    table.insert(extra_paths, bazel_info.runfiles .. "/" .. import)
  end
  return extra_paths
end

local function construct_python_path(extra_paths)
  local env = ""
  local sep = ""
  for _, extra_path in pairs(extra_paths) do
    env = env .. sep .. extra_path
    sep = ":"
  end
  return env
end

local function get_python_path(bazel_info)
  local extra_paths = get_bazel_python_modules(bazel_info)
  return construct_python_path(extra_paths)
end

local function save_pyright_config_json(extra_paths, include)
  local config = { typeCheckingMode = "off", extraPaths = extra_paths, include = include }
  local json = { vim.fn.json_encode(config) }
  vim.fn.writefile(json, "pyrightconfig.json")
  print("Created pyrightconfig.json")
end

local function get_keys(t)
  local keys = {}
  for key, _ in pairs(t) do
    table.insert(keys, key)
  end
  return keys
end

function M.create_pyright_config(target, include)
  local on_success = function(bazel_info)
    local Path = require("plenary.path")
    local extra_paths = {}
    local ws_name = bazel_info.workspace_name
    local workspace = bazel_info.workspace
    for _, line in pairs(bazel_info.stdout) do
      local depset = line:match("depset%(%[(.*)%]") or ""
      for extra_path in depset:gmatch('"(.-)"') do
        if extra_path:match("^" .. ws_name) then
          for _, pattern in pairs({ workspace, workspace .. "/bazel-bin" }) do
            local path = extra_path:gsub("^" .. ws_name, pattern)
            if Path:new(path):is_dir() then
              extra_paths[path] = true
            end
          end
        else
          extra_paths[workspace .. "/external/" .. extra_path] = true
        end
      end
    end
    save_pyright_config_json(get_keys(extra_paths), include)
  end
  bazel.cquery(
    vim.g.bazel_config
      .. " 'kind(py_.*,"
      .. target
      .. ")' --output starlark --starlark:expr 'providers(target)[\"PyInfo\"].imports'",
    { on_success = on_success }
  )
end

function M.DebugBazel(type, bazel_config, get_program, args, get_env)
  local start_debugger = function(bazel_info)
    local cwd = bazel_info.runfiles .. "/" .. bazel_info.workspace_name
    StartDebugger(type, get_program(bazel_info), args, cwd, get_env(bazel_info), bazel_info.workspace)
  end
  bazel.run_here("build", bazel_config, { on_success = start_debugger })
end

function M.DebugBazelPy(args)
  local get_env = function(bazel_info)
    return {
      PYTHONPATH = get_python_path(bazel_info),
      RUNFILES_DIR = bazel_info.runfiles,
    }
  end
  M.DebugBazel("python", vim.g.bazel_config, get_python_executable, args, get_env)
end

function M.DebugBazelPyRun()
  M.DebugBazelPy(vim.g.debug_args or {})
end

function M.DebugBazelPyTest()
  M.DebugBazelPy(require("bazel.pytest").get_test_filter_args())
end

local function default_program(bazel_info)
  return bazel_info.executable
end

local function default_env(_)
  return {}
end

function M.DebugGTest()
  local args = require("bazel.gtest").get_gtest_filter_args()
  M.DebugBazel("cppdbg", vim.g.bazel_config .. " --compilation_mode dbg --copt -O0", default_program, args, default_env)
end

function M.DebugTest()
  if vim.bo.filetype == "python" then
    M.DebugBazelPyTest()
  elseif vim.bo.filetype == "cpp" then
    M.DebugGTest()
  else
    print("Debugging not supported for this filetype")
  end
end

function M.DebugRun()
  if vim.bo.filetype == "python" then
    M.DebugBazelPyRun()
  else
    local args = vim.g.debug_args or {}
    M.DebugBazel(
      "cppdbg",
      vim.g.bazel_config .. " --compilation_mode dbg --copt=-O0",
      default_program,
      args,
      default_env
    )
  end
end

local function split_by_space(input)
  local chunks = {}
  for substring in input:gmatch("%S+") do
    table.insert(chunks, substring)
  end
  return chunks
end

function M.set_debug_args_from_input()
  local args = vim.fn.input("args for debugging with bazel: ")
  vim.g.debug_args = split_by_space(args)
end

return M
