`mason-nvim-dap` bridges `mason.nvim` with the `nvim-dap` plugin - making it easier to use both plugins together.


# Introduction

`mason-nvim-dap.nvim` closes some gaps that exist between `mason.nvim` and `nvim-dap`. Its main responsibilities are:

-   provide extra convenience APIs such as the `:DapInstall` command
-   allow you to (i) automatically install, and (ii) automatically set up a predefined list of adapters
-   translate between `dap` adapter names and `mason.nvim` package names (e.g. `python` <-> `debugpy`)

It is recommended to use this extension if you use `mason.nvim` and `nvim-dap`. (This plugin won't really work without them)

**Note: this plugin uses the `dap` adapter names in the APIs it exposes - not `mason.nvim` package names.


# Requirements

-   neovim `>= 0.7.0`
-   [`mason.nvim`](https://github.com/williamboman/mason.nvim)
-   [`nvim-dap`](https://github.com/mfussenegger/nvim-dap)


# Installation

## [Packer](https://github.com/wbthomason/packer.nvim)

```lua
use {
    "williamboman/mason.nvim",
    "mfussenegger/nvim-dap",
    "jay-babu/mason-nvim-dap.nvim",
}
```

## vim-plug

```vim
Plug 'williamboman/mason.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'jay-babu/mason-nvim-dap.nvim'
```


# Setup

It's important that you set up the plugins in the following order:

1. `mason.nvim`
3. `mason-nvim-dap.nvim`

Pay extra attention to this if you're using a plugin manager to load plugins for you, as there are no guarantees it'll
load plugins in the correct order unless explicitly instructed to.

```lua
require("mason").setup()
require("mason-nvim-dap").setup()
```

Refer to the [Configuration](#configuration) section for information about which settings are available.


# Commands

-   `:DapInstall [<adapter>...]` - installs the provided adapter
-   `:DapUninstall <adapter> ...` - uninstalls the provided adapter


# Configuration

You may optionally configure certain behavior of `mason-nvim-dap.nvim` when calling the `.setup()` function. Refer to
the [default configuration](#default-configuration) for a list of all available settings.

Example:

```lua
require("mason-nvim-dap").setup({
    ensure_installed = { "python", "delve" }
})
```

## Default configuration

```lua
local DEFAULT_SETTINGS = {
    -- A list of adapters to install if they're not already installed.
    -- This setting has no relation with the `automatic_installation` setting.
    ensure_installed = {},

	-- NOTE: this is left here for future porting in case needed
	-- Whether adapters that are set up (via dap) should be automatically installed if they're not already installed.
	-- This setting has no relation with the `ensure_installed` setting.
	-- Can either be:
	--   - false: Daps are not automatically installed.
	--   - true: All adapters set up via dap are automatically installed.
	--   - { exclude: string[] }: All adapters set up via mason-nvim-dap, except the ones provided in the list, are automatically installed.
	--       Example: automatic_installation = { exclude = { "python", "delve" } }
    automatic_installation = false,

	-- Whether adapters that are installed in mason should be automatically set up in dap.
	-- Removes the need to set up dap manually.
	-- See mappings.adapters and mappings.configurations for settings.
	-- Must invoke when set to true: `require 'mason-nvim-dap'.setup_handlers()`
	-- Can either be:
	-- 	- false: Dap is not automatically configured.
	-- 	- true: Dap is automatically configured.
	-- 	- {adapters: {ADAPTER: {}, }, configurations: {configuration: {}, }, filetypes: {filetype: {}, }}. Allows overriding default configuration.
	-- 	- {adapters: function(default), configurations: function(default), filetypes: function(default), }. Allows modifying the default configuration passed in via function.
	automatic_setup = false,
}
```

# Automatic Setup Usage

Automatic Setup is a need feature that removes the need to configure `dap` for supported adapters.
Adapters found installed in `mason` will automatically be setup for dap.

## Example Config

```lua
require("mason").setup()
require("mason-nvim-dap").setup({
    automatic_setup = true,
})
require 'mason-nvim-dap'.setup_handlers {}
```

### Overriding Default Settings

```lua
require("mason").setup()
require("mason-nvim-dap").setup({
    automatic_setup = {
        -- modifies the default configurations table
        -- pass in a function or a list to override with
        -- the same can be done for adapters and filetypes
        configurations = function(default)
            default.php[1].port = 9003

            return default
        end,
   }
})
require 'mason-nvim-dap'.setup_handlers {}
```

See the Default Configuration section to understand how the default dap configs can be overriden.

# Setup handlers usage

The `setup_handlers()` function provides a dynamic way of setting up sources and any other needed logic, It can also do that during runtime.

**NOTE:** When setting `automatic_setup = true`, the handler function needs to be called at a minimum like:
`require 'mason-nvim-dap'.setup_handlers()`. When passing in a custom handler function for the the default or a source,
then the automatic_setup function one won't be invoked. See below to keep original functionality inside the custom handler.

```lua
local dap = require("dap")

require ('mason-nvim-dap').setup({
    ensure_installed = {'stylua', 'jq'}
})

require 'mason-nvim-dap'.setup_handlers {
    function(source_name)
      -- all sources with no handler get passed here


      -- Keep original functionality of `automatic_setup = true`
      require('mason-nvim-dap.automatic_setup')(source_name)
    end,
    python = function(source_name)
        dap.adapters.python = {
	        type = "executable",
	        command = "/usr/bin/python3",
	        args = {
		        "-m",
		        "debugpy.adapter",
	        },
        }

        dap.configurations.python = {
	        {
		        type = "python",
		        request = "launch",
		        name = "Launch file",
		        program = "${file}", -- This configuration will launch the current file if used.
	        },
        }
    end,
}
```

# Available Dap Adapters

See https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/source.lua
