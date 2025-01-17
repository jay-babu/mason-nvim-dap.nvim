local settings = require('mason-nvim-dap.settings')

local M = {}

-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#go-using-delve-directly
M.delve = {
	{
		type = 'delve',
		name = 'Delve: Debug',
		request = 'launch',
		program = '${workspaceFolder}',
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

local BASHDB_DIR = ''
if
	require('mason-registry').has_package('bash-debug-adapter')
	and require('mason-registry').get_package('bash-debug-adapter'):is_installed()
then
	BASHDB_DIR = require('mason-registry').get_package('bash-debug-adapter'):get_install_path()
		.. '/extension/bashdb_dir'
end

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

local venv_path = os.getenv('VIRTUAL_ENV') or os.getenv('CONDA_PREFIX')
M.python = {
	{
		-- The first three options are required by nvim-dap
		type = 'python', -- the type here established the link to the adapter definition: `dap.adapters.python`
		request = 'launch',
		name = 'Python: Launch file',
		program = '${file}', -- This configuration will launch the current file if used.
		-- venv on Windows uses Scripts instead of bin
		pythonPath = venv_path
				and ((vim.fn.has('win32') == 1 and venv_path .. '/Scripts/python') or venv_path .. '/bin/python')
			or nil,
		console = 'integratedTerminal',
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
		console = 'integratedTerminal',
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
		name = 'Chrome Debugger',
		type = 'chrome',
		request = 'launch',
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		url = 'http://localhost:3000',
		webRoot = '${workspaceFolder}',
	},
}

M.firefox = {
	{
		name = 'Firefox Debugger',
		type = 'firefox',
		request = 'launch',
		reAttach = true,
		url = 'http://localhost:3000',
		webRoot = '${workspaceFolder}',
		firefoxExecutable = vim.fn.exepath('firefox'),
	},
}

M.js = {
	{
		name = 'Launch Node',
		type = 'js',
		request = 'launch',
		program = '${ file }',
		cwd = '${workspaceFolder}',
		sourceMaps = true,
		rootPath = '${workspaceFolder}',
		skipFiles = { '<node_internals>/**' },
		protocol = 'inspector',
		console = 'integratedTerminal',
	},
	{
		name = 'Attach to Node Process',
		type = 'js',
		request = 'attach',
		processId = require('dap.utils').pick_process,
		cwd = '${workspaceFolder}',
		sourceMaps = true,
	},
	{
		name = 'Launch Current File (pwa-node with ts-node)',
		type = 'js',
		request = 'launch',
		cwd = vim.fn.getcwd(),
		runtimeArgs = { '--loader', 'ts-node/esm' },
		runtimeExecutable = 'node',
		args = { '${file}' },
		sourceMaps = true,
		protocol = 'inspector',
		skipFiles = { '<node_internals>/**', 'node_modules/**' },
		resolveSourceMapLocations = {
			'${workspaceFolder}/**',
			'!**/node_modules/**',
		},
	},
	{
		name = 'Launch Test Current File (pwa-node with vitest)',
		type = 'js',
		request = 'launch',
		cwd = vim.fn.getcwd(),
		program = '${workspaceFolder}/node_modules/vitest/vitest.mjs',
		args = { '--inspect-brk', '--threads', 'false', 'run', '${file}' },
		autoAttachChildProcesses = true,
		smartStep = true,
		console = 'integratedTerminal',
		skipFiles = { '<node_internals>/**', 'node_modules/**' },
	},
	{
		name = 'Launch Test Current File (pwa-node with deno)',
		type = 'js',
		request = 'launch',
		cwd = vim.fn.getcwd(),
		runtimeArgs = { 'test', '--inspect-brk', '--allow-all', '${file}' },
		runtimeExecutable = 'deno',
		attachSimplePort = 9229,
	},
	{
		name = 'Chrome: Launch && Debug Against localhost',
		type = 'js',
		request = 'launch',
		url = function()
			local co = coroutine.running()
			return coroutine.create(function()
				vim.ui.input({
					prompt = 'Enter URL: ',
					default = 'https://localhost:3000',
				}, function(url)
					if url == nil or url == '' then
						return
					else
						coroutine.resume(co, url)
					end
				end)
			end)
		end,
		webRoot = '${workspaceFolder}',
		skipFiles = { '<node_internals>/**/*.js' },
		protocol = 'inspector',
		sourceMaps = true,
		userDataDir = false,
	},
	{
		name = 'Edge: Launch && Debug Against localhost',
		type = 'js',
		request = 'launch',
		url = function()
			local co = coroutine.running()
			return coroutine.create(function()
				vim.ui.input({
					prompt = 'Enter URL: ',
					default = 'https://localhost:3000',
				}, function(url)
					if url == nil or url == '' then
						return
					else
						coroutine.resume(co, url)
					end
				end)
			end)
		end,
		webRoot = '${workspaceFolder}/src',
		useWebView = true,
		sourceMaps = true,
		userDataDir = false,
	},
	{
		name = 'Node: Terminal Debug',
		type = 'js',
		request = 'launch',
		cwd = '${workspaceFolder}',
		console = 'integratedTerminal',
		skipFiles = { '<node_internals>/**' },
		sourceMaps = true,
		outFiles = { '${workspaceFolder}/dist/**/*.js' },
	},
	{
		name = 'Extension Host: Debug',
		type = 'js',
		request = 'launch',
		args = { '--extensionDevelopmentPath=${workspaceFolder}' },
		cwd = '${workspaceFolder}',
		runtimeExecutable = vim.fn.exepath('code'),
		outFiles = { '${workspaceFolder}/out/**/*.js' },
		sourceMaps = true,
		protocol = 'inspector',
	},
	{
		name = 'Jest: Debug Tests',
		type = 'js',
		request = 'launch',
		-- trace = true, -- include debugger info
		runtimeExecutable = 'node',
		runtimeArgs = {
			'./node_modules/jest/bin/jest.js',
			'--runInBand',
		},
		rootPath = '${workspaceFolder}',
		cwd = '${workspaceFolder}',
		console = 'integratedTerminal',
		internalConsoleOptions = 'neverOpen',
	},
	{
		name = 'Jest: Debug Tests 2',
		type = 'js',
		request = 'launch',
		program = '${workspaceFolder}/node_modules/jest/bin/jest.js',
		arg = {
			'_verbose',
			'_runInBand',
			'_forceExit',
			'_config',
			'jest-unit.config.json',
			'${file}',
		},
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		restart = true,
		protocol = 'inspector',
		console = 'integratedTerminal',
	},
	{
		name = 'Mocha: Debug Tests',
		type = 'js',
		request = 'launch',
		-- trace = true, -- include debugger info
		runtimeExecutable = 'node',
		runtimeArgs = {
			'./node_modules/mocha/bin/mocha.js',
		},
		rootPath = '${workspaceFolder}',
		cwd = '${workspaceFolder}',
		console = 'integratedTerminal',
		internalConsoleOptions = 'neverOpen',
	},
	{
		name = 'Electron: Debug Main Process',
		type = 'js',
		request = 'launch',
		program = '${workspaceFolder}/node_modules/.bin/electron',
		args = {
			'${workspaceFolder}/dist/index.js',
		},
		outFiles = {
			'${workspaceFolder}/dist/*.js',
		},
		resolveSourceMapLocations = {
			'${workspaceFolder}/dist/**/*.js',
			'${workspaceFolder}/dist/*.js',
		},
		rootPath = '${workspaceFolder}',
		cwd = '${workspaceFolder}',
		sourceMaps = true,
		skipFiles = { '<node_internals>/**' },
		protocol = 'inspector',
		console = 'integratedTerminal',
	},
	{
		name = 'Electron: Compile & Debug Main Process',
		type = 'js',
		request = 'launch',
		preLaunchTask = 'npm run build-ts',
		program = '${workspaceFolder}/node_modules/.bin/electron',
		args = {
			'${workspaceFolder}/dist/index.js',
		},
		outFiles = {
			'${workspaceFolder}/dist/*.js',
		},
		resolveSourceMapLocations = {
			'${workspaceFolder}/dist/**/*.js',
			'${workspaceFolder}/dist/*.js',
		},
		rootPath = '${workspaceFolder}',
		cwd = '${workspaceFolder}',
		sourceMaps = true,
		skipFiles = { '<node_internals>/**' },
		protocol = 'inspector',
		console = 'integratedTerminal',
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

local function get_dll()
	return coroutine.create(function(dap_run_co)
		local items = vim.fn.globpath(vim.fn.getcwd(), '**/bin/Debug/**/*.dll', 0, 1)
		local opts = {
			format_item = function(path)
				return vim.fn.fnamemodify(path, ':t')
			end,
		}
		local function cont(choice)
			if choice == nil then
				return nil
			else
				coroutine.resume(dap_run_co, choice)
			end
		end

		vim.ui.select(items, opts, cont)
	end)
end

M.coreclr = {
	{
		type = 'coreclr',
		name = 'NetCoreDbg: Launch',
		request = 'launch',
		cwd = '${fileDirname}',
		program = get_dll,
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
		miDebuggerPath = vim.fn.exepath('gdb'),
		cwd = '${workspaceFolder}',
		program = function()
			return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
		end,
	},
}

M.elixir = {
	{
		type = 'mix_task',
		name = 'mix test',
		task = 'test',
		taskArgs = { '--trace' },
		request = 'launch',
		startApps = true, -- for Phoenix projects
		projectDir = '${workspaceFolder}',
		requireFiles = {
			'test/**/test_helper.exs',
			'test/**/*_test.exs',
		},
	},
}

M.kotlin = {
	{
		type = 'kotlin',
		name = 'launch - kotlin',
		request = 'launch',
		projectRoot = vim.fn.getcwd(),
		mainClass = function()
			-- return vim.fn.input("Path to main class > ", "myapp.sample.app.AppKt", "file")
			return vim.fn.input('Path to main class > ', '', 'file')
		end,
	},
}

local function flutter_path()
	return vim.loop.os_uname().sysname == 'Windows_NT' and 'C:\\src\\flutter' or os.getenv('HOME') .. '/flutter'
end

M.dart = {
	{
		type = 'dart',
		request = 'launch',
		name = 'Launch flutter',
		-- windows don't really have a standard install path
		-- best effort guess is the instructed install path from:
		-- https://docs.flutter.dev/get-started/install/windows
		dartSdkPath = flutter_path() .. '/bin/cache/dart-sdk/',
		flutterSdkPath = flutter_path(),
		program = '${workspaceFolder}/lib/main.dart',
		cwd = '${workspaceFolder}',
	},
}

M.haskell = {
	{
		type = 'haskell',
		request = 'launch',
		name = 'Debug',
		workspace = '${workspaceFolder}',
		startup = '${file}',
		stopOnEntry = true,
		logFile = vim.fn.stdpath('data') .. '/haskell-dap.log',
		logLevel = 'WARNING',
		ghciEnv = vim.empty_dict(),
		ghciPrompt = 'ghci>',
		-- Adjust the prompt to the prompt you see when you invoke the stack ghci command below
		ghciInitialPrompt = '>',
		ghciCmd = 'stack ghci --with-ghc='
			.. vim.fn.exepath('ghci-dap')
			.. ' --test --no-load --no-build --main-is TARGET --ghci-options -fprint-evld-with-show --ghci-options -ignore-dot-ghci',
	},
}

return M
