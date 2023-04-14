`mason-nvim-dap` bridges `mason.nvim` with the `nvim-dap` plugin - making it easier to use both plugins together.


# Introduction

<p align="center">
    <a href="https://github.com/jay-babu/mason-nvim-dap.nvim/pulse">
      <img src="https://img.shields.io/github/last-commit/jay-babu/mason-nvim-dap.nvim?style=for-the-badge&logo=github&color=7dc4e4&logoColor=D9E0EE&labelColor=302D41"/>
    </a>
    <a href="https://github.com/jay-babu/mason-nvim-dap.nvim/releases/latest">
      <img src="https://img.shields.io/github/v/release/jay-babu/mason-nvim-dap.nvim?style=for-the-badge&logo=gitbook&color=8bd5ca&logoColor=D9E0EE&labelColor=302D41"/>
    </a>
    <a href="https://github.com/jay-babu/mason-nvim-dap.nvim/stargazers">
      <img src="https://img.shields.io/github/stars/jay-babu/mason-nvim-dap.nvim?style=for-the-badge&logo=apachespark&color=eed49f&logoColor=D9E0EE&labelColor=302D41"/>
    </a>
</p>

`mason-nvim-dap.nvim` closes some gaps that exist between `mason.nvim` and `nvim-dap`. Its main responsibilities are:

-   provide extra convenience APIs such as the `:DapInstall` command
-   allow you to (i) automatically install, and (ii) automatically set up a predefined list of adapters
-   translate between `dap` adapter names and `mason.nvim` package names (e.g. `python` <-> `debugpy`)

It is recommended to use this extension if you use `mason.nvim` and `nvim-dap`. (This plugin won't really work without them)

**Note: this plugin uses the `dap` adapter names in the APIs it exposes - not `mason.nvim` package names.

## Star History

[![Star History Chart](https://api.star-history.com/svg?repos=jay-babu/mason-null-ls.nvim,jay-babu/mason-nvim-dap.nvim&type=Date)](https://star-history.com/#jay-babu/mason-null-ls.nvim&jay-babu/mason-nvim-dap.nvim&Date)

# Requirements

-   neovim `>= 0.7.0`
-   [`mason.nvim`](https://github.com/williamboman/mason.nvim)
-   [`nvim-dap`](https://github.com/mfussenegger/nvim-dap)


# Installation

## [Lazy](https://github.com/folke/lazy.nvim)

```lua
{
    "williamboman/mason.nvim",
    "mfussenegger/nvim-dap",
    "jay-babu/mason-nvim-dap.nvim",
}
```

## [Packer](https://github.com/wbthomason/packer.nvim)

```lua
use {
    "williamboman/mason.nvim",
    "mfussenegger/nvim-dap",
    "jay-babu/mason-nvim-dap.nvim",
}
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

    -- See below on usage
    handlers = nil,
}
```

# Handlers usage (Automatic Setup)

The `handlers` table provides a dynamic way of setting up sources and any other logic needed; it can also do that during runtime.
To override the fallback handler put your custom one as first list element in the table.
To override any other handler pass your custom function to the respective key.
Handler functions take one argument - the default config table, which you customize to your liking:

```lua
local config = {
	name -- adapter name

	-- All the items below are looked up by the adapter name.
	adapters -- https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/adapters.lua
	configurations -- https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/configurations.lua
	filetypes -- https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/filetypes.lua
}
```

Note, especially **if you are migrating from setup_handlers()**, that you have to call `require('mason-nvim-dap').default_setup(config)` with your customized config table in all your handler overrides!

### Basic Customization

```lua
require ('mason-nvim-dap').setup({
    ensure_installed = {'stylua', 'jq'},
    handlers = {}, -- sets up dap in the predefined manner
})
```

### Advanced Customization

```lua
require ('mason-nvim-dap').setup({
    ensure_installed = {'stylua', 'jq'},
    handlers = {
        function(config)
          -- all sources with no handler get passed here

          -- Keep original functionality
          require('mason-nvim-dap').default_setup(config)
        end,
        python = function(config)
            config.adapters = {
	            type = "executable",
	            command = "/usr/bin/python3",
	            args = {
		            "-m",
		            "debugpy.adapter",
	            },
            }
            require('mason-nvim-dap').default_setup(config) -- don't forget this!
        end,
    },
})
```

# Available Dap Adapters

See https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/source.lua
