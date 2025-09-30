# Proposed Maintenance Tasks

## Fix Typo
- Correct the description "Descreas height" to "Decrease height" in the `<m-j>` keymap within the which-key plugin configuration so the tooltip reads properly. (File: `lua/niia/plugins/which_key.lua`)

## Fix Bug
- Update the rust-analyzer LSP settings to use the correct `procMacro` key so procedural macros are actually enabled during Rust development. (File: `lua/niia/plugins/lsp/servers/rust_analyzer.lua`)

## Fix Documentation Discrepancy
- Adjust the which-key descriptions for the `<m-,>` mappings to mention inserting a comma instead of a semicolon so the documentation matches the action performed. (File: `lua/niia/plugins/which_key.lua`)

## Improve Test
- Add a shell-based regression test (for example with Bats) that exercises `scripts/init.sh`'s `apt_install` helper to ensure it handles mixtures of installed and missing packages without issuing `apt upgrade/install` calls with empty arguments.
