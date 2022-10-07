local _ = require('mason-core.functional')

local M = {}

M = {
	['chrome'] = { 'javascriptreact', 'typescriptreact' },
	['coreclr'] = { 'cs' },
	['delve'] = { 'go' },
	['firefox'] = { 'typescript' },
	['node2'] = { 'javascript' },
	['php'] = { 'php' },
	['python'] = { 'python' },
}

return M
