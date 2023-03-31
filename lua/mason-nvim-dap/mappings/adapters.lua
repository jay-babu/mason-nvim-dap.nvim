local settings = require('mason-nvim-dap.settings')

local M = {}

M.bash = {
	type = 'executable',
	command = vim.fn.exepath('bash-debug-adapter'),
}

-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#go-using-delve-directly
M.delve = {
	type = 'server',
	port = '${port}',
	executable = {
		command = vim.fn.exepath('dlv'),
		args = { 'dap', '-l', '127.0.0.1:${port}' },
	},
}

M.python = {
	type = 'executable',
	command = vim.fn.exepath('debugpy-adapter'),
}

M.node2 = {
	type = 'executable',
	command = vim.fn.exepath('node-debug2-adapter'),
}

M.chrome = {
	type = 'executable',
	command = vim.fn.exepath('chrome-debug-adapter'),
}

M.firefox = {
	type = 'executable',
	command = vim.fn.exepath('firefox-debug-adapter'),
}

M.php = {
	type = 'executable',
	command = vim.fn.exepath('php-debug-adapter'),
}

M.coreclr = {
	type = 'executable',
	command = vim.fn.exepath('netcoredbg'),
	args = { '--interpreter=vscode' },
}

M.cppdbg = {
	id = 'cppdbg',
	type = 'executable',
	command = vim.fn.exepath('OpenDebugAD7'),
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
		command = vim.fn.exepath('codelldb'),
		args = { '--port', '${port}' },
	},
}
if vim.fn.has('win32') == 1 then
	M.codelldb.executable.detached = false
end

M.mix_task = {
	type = 'executable',
	command = vim.fn.exepath('elixir-ls-debugger'), -- https://github.com/williamboman/mason.nvim/blob/d97579ccd5689f9c6c365e841ea99c27954112ec/lua/mason-registry/elixir-ls/init.lua#L26
	args = {},
}

M.kotlin = {
	type = 'executable',
	command = vim.fn.exepath('kotlin-debug-adapter'),
	args = { '--interpreter=vscode' },
}

M.dart = {
	type = 'executable',
	command = vim.fn.exepath('dart-debug-adapter'),
	args = { 'flutter' },
}

M = require('mason-nvim-dap.internal.overrides.func_or_extend')(settings.current.automatic_setup.adapters or {}, M)

return M
