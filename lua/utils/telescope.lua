local lsp_layout = {
	horizontal = {
		preview_cutoff = 150,
		preview_width = 80,
		height = 0.9,
		width = 180,
	},
}

local small_cursor = {
	cursor = {
		preview_cutoff = 0,
		height = 10,
		width = 30,
		preview_width = 1,
	},
}

local center = {
	width = 120,
	height = 20,
	mirror = false,
	preview_cutoff = 0,
}

local cursor = {
	height = 40,
	width = 100,
	preview_cutoff = 0,
}

local horizontal = {
	preview_cutoff = 120,
	preview_width = 0.55,
	height = 24,
	-- width = 240,
}

local vertical = {
	height = 0.8,
	width = 120,
	preview_cutoff = 30,
	preview_height = 0.7,
	mirror = false,
}

local flex = {
	flip_columns = 240,
}

local root_patterns = { ".git", "lua" }
-- returns the root directory based on:
-- * lsp workspace folders
-- * lsp root_dir
-- * root pattern of filename of the current buffer
-- * root pattern of cwd
---@return string
local function get_root()
	---@type string?
	local path = vim.api.nvim_buf_get_name(0)
	path = path ~= "" and vim.loop.fs_realpath(path) or nil
	---@type string[]
	local roots = {}
	if path then
		for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
			local workspace = client.config.workspace_folders
			local paths = workspace
					and vim.tbl_map(function(ws)
						return vim.uri_to_fname(ws.uri)
					end, workspace)
				or client.config.root_dir and { client.config.root_dir }
				or {}
			for _, p in ipairs(paths) do
				local r = vim.loop.fs_realpath(p)
				if path:find(r, 1, true) then
					roots[#roots + 1] = r
				end
			end
		end
	end
	table.sort(roots, function(a, b)
		return #a > #b
	end)
	---@type string?
	local root = roots[1]
	if not root then
		path = path and vim.fs.dirname(path) or vim.loop.cwd()
		---@type string?
		root = vim.fs.find(root_patterns, { path = path, upward = true })[1]
		root = root and vim.fs.dirname(root) or vim.loop.cwd()
	end
	---@cast root string
	return root
end

-- this will return a function that calls telescope.
-- cwd will default to lazyvim.util.get_root
-- for `files`, git_files or find_files will be chosen depending on .git
local function call_telescope(builtin, opts)
	local params = { builtin = builtin, opts = opts }
	return function()
		builtin = params.builtin
		opts = params.opts
		opts = vim.tbl_deep_extend("force", { cwd = get_root() }, opts or {})
		if builtin == "files" then
			builtin = "find_files"
		end
		if builtin == "git_files" then
			opts.show_untracked = true
		end
		if opts.cwd and opts.cwd ~= vim.loop.cwd() then
			opts.attach_mappings = function(_, map)
				map("i", "<a-c>", function()
					local action_state = require("telescope.actions.state")
					local line = action_state.get_current_line()
					callTelescope(
						params.builtin,
						vim.tbl_deep_extend(
							"force",
							{},
							params.opts or {},
							{ cwd = false, default_text = line }
						)
					)()
				end)
				return true
			end
		end

		require("telescope.builtin")[builtin](opts)
	end
end

return {
	layouts = {
		lsp = lsp_layout,
		small_cursor = small_cursor,
		center = center,
		cursor = cursor,
		horizontal = horizontal,
		vertical = vertical,
		flex = flex,
	},
	get_root = get_root,
	call_telescope = call_telescope,
	--	{ "─", "│", "─", "│", "┌", "┐", "┘", "└" }, Standard
	borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
}
