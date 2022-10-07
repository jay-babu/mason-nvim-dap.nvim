local settings = require('mason-nvim-dap.settings')

local M = {}

-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#go-using-delve-directly
M.go = {
	{
		type = 'delve',
		name = 'Debug',
		request = 'launch',
		program = '${file}',
	},
	{
		type = 'delve',
		name = 'Debug test', -- configuration for debugging test files
		request = 'launch',
		mode = 'test',
		program = '${file}',
	},
	-- works with go.mod packages and sub packages
	{
		type = 'delve',
		name = 'Debug test (go.mod)',
		request = 'launch',
		mode = 'test',
		program = './${relativeFileDirname}',
	},
}

M.python = {
	{
		-- The first three options are required by nvim-dap
		type = 'python', -- the type here established the link to the adapter definition: `dap.adapters.python`
		request = 'launch',
		name = 'Launch file',

		-- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

		program = '${file}', -- This configuration will launch the current file if used.
		pythonPath = function()
			-- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
			-- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
			-- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
			local cwd = vim.fn.getcwd()
			if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
				return cwd .. '/venv/bin/python'
			elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
				return cwd .. '/.venv/bin/python'
			else
				return '/usr/bin/python'
			end
		end,
	},
}

M.cpp = {
	{
		name = 'Launch',
		type = 'lldb',
		request = 'launch',
		program = function()
			return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
		end,
		cwd = '${workspaceFolder}',
		stopOnEntry = false,
		args = {},
	},
}

M.c = vim.deepcopy(M.cpp)

M.rust = vim.deepcopy(M.cpp)

M.javascript = {
	{
		name = 'Launch',
		type = 'node2',
		request = 'launch',
		program = '${file}',
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = 'inspector',
		console = 'integratedTerminal',
	},
	{
		-- For this to work you need to make sure the node process is started with the `--inspect` flag.
		name = 'Attach to process',
		type = 'node2',
		request = 'attach',
		processId = require('dap.utils').pick_process,
	},
}

M.javascriptreact = {
	{
		type = 'chrome',
		request = 'attach',
		program = '${file}',
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = 'inspector',

		port = 9222,
		webRoot = '${workspaceFolder}',
	},
}

M.typescriptreact = { -- change to typescript if needed
	{
		type = 'chrome',
		request = 'attach',
		program = '${file}',
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = 'inspector',
		port = 9222,
		webRoot = '${workspaceFolder}',
	},
}

M.typescript = {
	name = 'Debug with Firefox',
	type = 'firefox',
	request = 'launch',
	reAttach = true,
	url = 'http://localhost:3000',
	webRoot = '${workspaceFolder}',
	firefoxExecutable = '/usr/bin/firefox',
}

M.php = {
	{
		type = 'php',
		request = 'launch',
		name = 'Listen for Xdebug',
		port = 9000,
	},
}

M.cs = {
	{
		type = 'coreclr',
		name = 'launch - netcoredbg',
		request = 'launch',
		program = function()
			return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
		end,
	},
}

M = vim.tbl_deep_extend('force', M, settings.current.automatic_setup.configurations or {})

return M
