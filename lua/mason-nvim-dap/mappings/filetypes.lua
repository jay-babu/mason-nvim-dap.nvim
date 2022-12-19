local _ = require('mason-core.functional')
local settings = require('mason-nvim-dap.settings')

local M = {
	['bash'] = { 'sh' },
	['chrome'] = { 'javascriptreact', 'typescriptreact', 'typescript', 'javascript' },
	['coreclr'] = { 'cs' },
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

M = vim.tbl_deep_extend('force', M, settings.current.automatic_setup.filetypes or {})

return M
