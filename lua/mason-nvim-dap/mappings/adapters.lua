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

local NODEDEBUG_DIR = require('mason-registry').get_package('node-debug2-adapter'):get_install_path() ..
		'/out/src/nodeDebug.js'
M.node2 = {
	type = 'executable',
	command = 'node',
	args = { NODEDEBUG_DIR }
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

M = vim.tbl_deep_extend('force', M, settings.current.automatic_setup.adapters or {})

return M
