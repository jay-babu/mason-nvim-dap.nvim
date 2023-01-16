local _ = require('mason-core.functional')
local settings = require('mason-nvim-dap.settings')

local M = {}

M.adapter_to_configs = {
	['bash'] = { 'sh' },
	['chrome'] = { 'javascriptreact', 'typescriptreact', 'typescript', 'javascript' },
	['codelldb'] = { 'c', 'cpp', 'rust' },
	['coreclr'] = { 'cs', 'fsharp' },
	['cppdbg'] = { 'c', 'cpp', 'rust' },
	['dart'] = { 'dart' },
	['delve'] = { 'go' },
	['firefox'] = { 'javascriptreact', 'typescriptreact', 'typescript', 'javascript' },
	['kotlin'] = { 'kotlin' },
	['mix_task'] = { 'elixir' },
	['node2'] = { 'javascriptreact', 'typescriptreact', 'typescript', 'javascript' },
	['php'] = { 'php' },
	['python'] = { 'python' },
}

M.adapter_to_configs =
	vim.tbl_deep_extend('force', M.adapter_to_configs, settings.current.automatic_setup.filetypes or {})

return M
