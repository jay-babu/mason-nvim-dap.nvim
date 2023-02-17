local _ = require('mason-core.functional')
local settings = require('mason-nvim-dap.settings')

local M = {}

M.adapter_to_configs = {
	['bash'] = { 'sh' },
	['chrome'] = { 'javascriptreact', 'typescriptreact', 'typescript', 'javascript' },
	['codelldb'] = { 'c', 'cpp', 'rust' },
	['coreclr'] = { 'cs', 'fsharp' },
	['cppdbg'] = { 'c', 'cpp', 'rust', 'asm' },
	['dart'] = { 'dart' },
	['delve'] = { 'go' },
	['firefox'] = { 'javascriptreact', 'typescriptreact', 'typescript', 'javascript' },
	['kotlin'] = { 'kotlin' },
	['mix_task'] = { 'elixir' },
	['node2'] = { 'javascriptreact', 'typescriptreact', 'typescript', 'javascript' },
	['php'] = { 'php' },
	['python'] = { 'python' },
}

M = require('mason-nvim-dap.internal.overrides.func_or_extend')(settings.current.automatic_setup.filetypes or {}, M)

return M
