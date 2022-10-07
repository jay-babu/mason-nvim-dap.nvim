local settings = require('mason-nvim-dap.settings')

local M = {}

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
	command = vim.fn.exepath('python3'),
	args = { '-m', 'debugpy.adapter' },
}

M.node2 = {
	type = 'executable',
	command = 'node',
	args = { vim.fn.stdpath('data') .. '/mason/packages/node-debug2-adapter/out/src/nodeDebug.js' },
}

M.chrome = {
	type = 'executable',
	command = 'node',
	args = {
		vim.fn.stdpath('data') .. '/mason/packages/chrome-debug-adapter/out/src/chromeDebug.js',
	},
}

M.firefox = {
	type = 'executable',
	command = 'node',
	args = { vim.fn.stdpath('data') .. '/mason/packages/firefox-debug-adapter/dist/adapter.bundle.js' },
}

M.php = {
	type = 'executable',
	command = 'node',
	args = {
		vim.fn.stdpath('data') .. '/mason/packages/php-debug-adapter/extension/out/phpDebug.js',
	},
}

M.coreclr = {
	type = 'executable',
	command = vim.fn.stdpath('data') .. '/mason/packages/netcoredbg/netcoredbg',
	args = { '--interpreter=vscode' },
}

M = vim.tbl_deep_extend('force', M, settings.current.automatic_setup.adapters or {})

return M
