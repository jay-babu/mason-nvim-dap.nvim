local settings = require('mason-nvim-dap.settings')

local M = {}

M.bash = {
	type = 'executable',
	command = 'bash-debug-adapter',
}

-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#go-using-delve-directly
M.delve = {
	type = 'server',
	port = '${port}',
	executable = {
		command = 'dlv',
		args = { 'dap', '-l', '127.0.0.1:${port}' },
	},
}

M.python = {
	type = 'executable',
	command = 'debugpy-adapter',
}

M.node2 = {
	type = 'executable',
	command = 'node-debug2-adapter',
}

M.chrome = {
	type = 'executable',
	command = 'chrome-debug-adapter',
}

M.firefox = {
	type = 'executable',
	command = 'firefox-debug-adapter',
}

M.php = {
	type = 'executable',
	command = 'php-debug-adapter',
}

M.coreclr = {
	type = 'executable',
	command = 'netcoredbg',
	args = { '--interpreter=vscode' },
}

M.cppdbg = {
	id = 'cppdbg',
	type = 'executable',
	command = 'OpenDebugAD7',
}
if vim.fn.has('win32') == 1 then
	M.cppdbg.options = {
		detached = false,
	}
end

M.codelldb = {
	type = 'server',
	port = '${port}',
	executable = {
		command = 'codelldb',
		args = { '--port', '${port}' },
	},
}
if vim.fn.has('win32') == 1 then
	M.codelldb.executable.detached = false
end
M.mix_task = {
	type = 'executable',
	command = 'elixir-ls-debugger', -- https://github.com/williamboman/mason.nvim/blob/d97579ccd5689f9c6c365e841ea99c27954112ec/lua/mason-registry/elixir-ls/init.lua#L26
	args = {},
}

M = vim.tbl_deep_extend('force', M, settings.current.automatic_setup.adapters or {})

return M
