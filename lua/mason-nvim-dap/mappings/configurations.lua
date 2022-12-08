local settings = require('mason-nvim-dap.settings')

local M = {}

-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#go-using-delve-directly
M.delve = {
	{
		type = 'delve',
		name = 'Delve: Debug',
		request = 'launch',
		program = '${file}',
	},
	{
		type = 'delve',
		name = 'Delve: Debug test', -- configuration for debugging test files
		request = 'launch',
		mode = 'test',
		program = '${file}',
	},
	-- works with go.mod packages and sub packages
	{
		type = 'delve',
		name = 'Delve: Debug test (go.mod)',
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
		name = 'Bash: Launch file',
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
		name = 'Python: Launch file',
		program = '${file}', -- This configuration will launch the current file if used.
	},
}

M.codelldb = {
	{
		name = 'LLDB: Launch',
		type = 'codelldb',
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
		name = 'Node2: Launch',
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
		name = 'Node2: Attach to process',
		type = 'node2',
		request = 'attach',
		processId = require('dap.utils').pick_process,
	},
}

M.chrome = {
	{
		name = 'Chrome: Debug',
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
		name = 'Firefox: Debug',
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
		name = 'PHP: Listen for Xdebug',
		port = 9000,
	},
}

M.coreclr = {
	{
		type = 'coreclr',
		name = 'NetCoreDbg: Launch',
		request = 'launch',
		program = function()
			return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
		end,
	},
}

M.cppdbg = {
	{
		name = 'Launch file',
		type = 'cppdbg',
		request = 'launch',
		program = function()
			return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
		end,
		cwd = '${workspaceFolder}',
		stopAtEntry = true,
	},
	{
		name = 'Attach to gdbserver :1234',
		type = 'cppdbg',
		request = 'launch',
		MIMode = 'gdb',
		miDebuggerServerAddress = 'localhost:1234',
		miDebuggerPath = '/usr/bin/gdb',
		cwd = '${workspaceFolder}',
		program = function()
			return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
		end,
	},
}

M = vim.tbl_deep_extend('force', M, settings.current.automatic_setup.configurations or {})

return M
