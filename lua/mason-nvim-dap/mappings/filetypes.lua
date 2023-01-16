local _ = require('mason-core.functional')
local settings = require('mason-nvim-dap.settings')

local M = {}

M.adapter_to_configs = {
	['bash'] = { 'sh' },
	['chrome'] = { 'javascriptreact', 'typescriptreact', 'typescript', 'javascript' },
	['coreclr'] = { 'cs', 'fsharp' },
	['delve'] = { 'go' },
	['firefox'] = { 'javascriptreact', 'typescriptreact', 'typescript', 'javascript' },
	['node2'] = { 'javascriptreact', 'typescriptreact', 'typescript', 'javascript' },
	['php'] = { 'php' },
	['python'] = { 'python' },
	['cppdbg'] = { 'c', 'cpp', 'rust' },
	['codelldb'] = { 'c', 'cpp', 'rust' },
	['mix_task'] = { 'elixir' },
	['kotlin'] = { 'kotlin' },
}

M.adapter_to_configs =
	vim.tbl_deep_extend('force', M.adapter_to_configs, settings.current.automatic_setup.filetypes or {})

return M
