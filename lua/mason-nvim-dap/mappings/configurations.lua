local settings = require('mason-nvim-dap.settings')

local M = {}

-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#go-using-delve-directly
M.delve = {
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

local BASHDB_DIR = require('mason-registry').get_package('bash-debug-adapter'):get_install_path()
	.. '/extension/bashdb_dir'
M.bash = {
	{
		type = 'bash',
		request = 'launch',
		name = 'Launch file',
		program = '${file}',
		cwd = '${fileDirname}',
		pathBashdb = BASHDB_DIR .. '/bashdb',
		pathBashdbLib = BASHDB_DIR,
		pathBash = 'bash',
		pathCat = 'cat',
		pathMkfifo = 'mkfifo',
		pathPkill = 'pkill',
		env = {},
		args = {},
	},
}

M.python = {
	{
		-- The first three options are required by nvim-dap
		type = 'python', -- the type here established the link to the adapter definition: `dap.adapters.python`
		request = 'launch',
		name = 'Launch file',
		program = '${file}', -- This configuration will launch the current file if used.
	},
}

M.codelldb = {
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

M.node2 = {
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

M.chrome = {
	{
		name = 'Debug with Chrome',
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

M.firefox = {
	{
		name = 'Debug with Firefox',
		type = 'firefox',
		request = 'launch',

		reAttach = true,
		url = 'http://localhost:3000',
		webRoot = '${workspaceFolder}',
		firefoxExecutable = '/usr/bin/firefox',
	},
}

M.php = {
	{
		type = 'php',
		request = 'launch',
		name = 'Listen for Xdebug',
		port = 9000,
	},
}

M.coreclr = {
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
