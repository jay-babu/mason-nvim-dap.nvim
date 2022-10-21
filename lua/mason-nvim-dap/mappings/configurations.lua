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

local BASHDB_DIR = require('mason-registry').get_package('bash-debug-adapter'):get_install_path()
	.. '/extension/bashdb_dir'
M.sh = {
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

local node2_launch = {
	name = 'Launch',
	type = 'node2',
	request = 'launch',
	program = '${file}',
	cwd = vim.fn.getcwd(),
	sourceMaps = true,
	protocol = 'inspector',
	console = 'integratedTerminal',
}
local node2_attach = {
	-- For this to work you need to make sure the node process is started with the `--inspect` flag.
	name = 'Attach to process',
	type = 'node2',
	request = 'attach',
	processId = require('dap.utils').pick_process,
}

local chrome_config = {
	name = 'Debug with Chrome',
	type = 'chrome',
	request = 'attach',

	program = '${file}',
	cwd = vim.fn.getcwd(),
	sourceMaps = true,
	protocol = 'inspector',
	port = 9222,
	webRoot = '${workspaceFolder}',
}

local firefox_config = {
	name = 'Debug with Firefox',
	type = 'firefox',
	request = 'launch',

	reAttach = true,
	url = 'http://localhost:3000',
	webRoot = '${workspaceFolder}',
	firefoxExecutable = '/usr/bin/firefox',
}

M.javascript = {}
table.insert(M.javascript, chrome_config)
table.insert(M.javascript, firefox_config)
table.insert(M.javascript, node2_launch)
table.insert(M.javascript, node2_attach)
M.javascript = vim.deepcopy(M.javascript)

M.javascriptreact = {}
table.insert(M.javascriptreact, chrome_config)
table.insert(M.javascriptreact, firefox_config)
table.insert(M.javascriptreact, node2_launch)
table.insert(M.javascriptreact, node2_attach)
M.javascriptreact = vim.deepcopy(M.javascriptreact)

M.typescriptreact = {}
table.insert(M.typescriptreact, chrome_config)
table.insert(M.typescriptreact, firefox_config)
table.insert(M.typescriptreact, node2_launch)
table.insert(M.typescriptreact, node2_attach)
M.typescriptreact = vim.deepcopy(M.typescriptreact)

M.typescript = {}
table.insert(M.typescript, chrome_config)
table.insert(M.typescript, firefox_config)
table.insert(M.typescript, node2_launch)
table.insert(M.typescript, node2_attach)
M.typescript = vim.deepcopy(M.typescript)

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
