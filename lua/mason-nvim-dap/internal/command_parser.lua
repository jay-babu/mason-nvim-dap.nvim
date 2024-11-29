--- Shell command line parser module
-- @module command_parser
-- This module provides functionality to parse shell command lines into argument arrays,
-- including support for quoted strings and environment variables.
local M = {}

--- Parse a shell command line string into an array of arguments.
-- @param input string The command line to parse
-- @return table Array of parsed arguments
-- @usage local parser = require("command_parser")
-- local args = parser.parse("echo 'Hello World'")
-- -- returns: {"echo", "Hello World"}
function M.parse(input)
	local function evaluateVariables(str)
		str = str:gsub('%$([%w_]+)', os.getenv)
		str = str:gsub('%${([%w_]+)}', os.getenv)
		return str
	end

	input = evaluateVariables(input)

	local args = {}
	local current = ''
	local inQuotes = false
	local escapeNext = false
	local quoteChar = nil

	for i = 1, #input do
		local char = input:sub(i, i)

		if escapeNext then
			current = current .. char
			escapeNext = false
		elseif char == '\\' then
			escapeNext = true
		elseif char == '"' or char == "'" then
			if inQuotes and char == quoteChar then
				if #current == 0 then
					table.insert(args, '')
				end
				inQuotes = false
				quoteChar = nil
			elseif not inQuotes then
				inQuotes = true
				quoteChar = char
			else
				current = current .. char
			end
		elseif char == ' ' and not inQuotes then
			if #current > 0 then
				table.insert(args, current)
				current = ''
			end
		else
			current = current .. char
		end
	end

	if #current > 0 then
		table.insert(args, current)
	end

	return args
end

--- Run test suite for the parser
-- @return boolean True if all tests pass, false otherwise
function M.test()
	local tests = {
		{
			input = 'ls -l /home',
			expected = { 'ls', '-l', '/home' },
		},
		{
			input = "echo 'hello world'",
			expected = { 'echo', 'hello world' },
		},
		{
			input = 'git commit -m "fix: bug #123"',
			expected = { 'git', 'commit', '-m', 'fix: bug #123' },
		},
		{
			input = 'grep -r "hello there" .',
			expected = { 'grep', '-r', 'hello there', '.' },
		},
		{
			input = 'echo "it\'s working"',
			expected = { 'echo', "it's working" },
		},
		{
			input = 'echo \'quotes "inside" single\'',
			expected = { 'echo', 'quotes "inside" single' },
		},
		{
			input = 'command with\\ space',
			expected = { 'command', 'with space' },
		},
		{
			input = 'echo     multiple   spaces',
			expected = { 'echo', 'multiple', 'spaces' },
		},
		{
			input = "echo ''",
			expected = { 'echo', '' },
		},
		{
			input = 'single_command',
			expected = { 'single_command' },
		},
		{
			input = 'echo $HOME',
			expected = { 'echo', os.getenv('HOME') or '' },
		},
		{
			input = 'echo ${PATH}',
			expected = { 'echo', os.getenv('PATH') or '' },
		},
	}

	local function areTablesEqual(t1, t2)
		if #t1 ~= #t2 then
			return false
		end
		for i = 1, #t1 do
			if t1[i] ~= t2[i] then
				return false
			end
		end
		return true
	end

	local failCount = 0
	for i, test in ipairs(tests) do
		local result = M.parse(test.input)
		local success = areTablesEqual(result, test.expected)
		if not success then
			print(string.format('Test %d failed!', i))
			print('Input: ' .. test.input)
			print('Expected: ' .. table.concat(test.expected, ', '))
			print('Got: ' .. table.concat(result, ', '))
			print('---')
			failCount = failCount + 1
		end
	end

	if failCount == 0 then
		print('All tests passed!')
		return true
	else
		print(string.format('%d tests failed!', failCount))
		return false
	end
end

return M
