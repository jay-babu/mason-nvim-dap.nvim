local _ = require('mason-core.functional')

local M = {}

M.adapter_to_configs = {
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

return M
