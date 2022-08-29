local config = {

	-- Configure AstroNvim updates
	updater = {
		remote = "origin", -- remote to use
		channel = "stable", -- "stable" or "nightly"
		version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
		branch = "main", -- branch name (NIGHTLY ONLY)
		commit = nil, -- commit hash (NIGHTLY ONLY)
		pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
		skip_prompts = false, -- skip prompts about breaking changes
		show_changelog = true, -- show the changelog after performing an update
		-- remotes = { -- easily add new remotes to track
		--   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
		--   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
		--   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
		-- },
	},

	-- Set colorscheme
	colorscheme = "catppuccin",

	-- Override highlight groups in any theme
	highlights = {
		-- duskfox = { -- a table of overrides
		--   Normal = { bg = "#000000" },
		-- },
		default_theme = function(highlights) -- or a function that returns one
			local C = require("default_theme.colors")

			highlights.Normal = { fg = C.fg, bg = C.bg }
			return highlights
		end,
	},

	-- set vim options here (vim.<first_key>.<second_key> =  value)
	options = {
		opt = {
			relativenumber = false, -- sets vim.opt.relativenumber
			guifont = { "JetbrainsMono Nerd Font", ":h16" },
			-- Tabs
			expandtab = false,
			softtabstop = 4,
			shiftwidth = 4,
			tabstop = 4,
			listchars = "tab: ,trail:·,extends:◣,precedes:◢,nbsp:○,eol:↵",
			list = true,
		},
		g = {
			mapleader = " ", -- sets vim.g.mapleader
			neovide_cursor_vfx_mode = "railgun",
			neovide_cursor_trail_length = 0.8,
			catppuccin_flavour = "mocha",
		},
	},

	-- Default theme configuration
	default_theme = {
		diagnostics_style = { italic = true },
		-- Modify the color table
		colors = { fg = "#abb2bf" },
		plugins = { -- enable or disable extra plugin highlighting
			aerial = true,
			beacon = false,
			bufferline = true,
			dashboard = true,
			highlighturl = true,
			hop = false,
			indent_blankline = false,
			lightspeed = false,
			["neo-tree"] = true,
			notify = true,
			["nvim-tree"] = false,
			["nvim-web-devicons"] = true,
			rainbow = true,
			symbols_outline = false,
			telescope = true,
			vimwiki = false,
			["which-key"] = true,
		},
	},

	-- Disable AstroNvim ui features
	ui = { nui_input = true, telescope_select = true },

	-- LuaSnip Options
	luasnip = {
		-- Add paths for including more VS Code style snippets in luasnip
		vscode_snippet_paths = {},
		-- Extend filetypes
		filetype_extend = { javascript = { "javascriptreact" } },
	},

	-- Modify which-key registration
	["which-key"] = {
		-- Add bindings
		register_mappings = {
			-- first key is the mode, n == normal mode
			n = {
				-- second key is the prefix, <leader> prefixes
				["<leader>"] = {
					-- which-key registration table for normal mode, leader prefix
					-- ["N"] = { "<cmd>tabnew<cr>", "New Buffer" },
				},
			},
		},
	},

	-- CMP Source Priorities
	-- modify here the priorities of default cmp sources
	-- higher value == higher priority
	-- The value can also be set to a boolean for disabling default sources:
	-- false == disabled
	-- true == 1000
	cmp = {
		source_priority = {
			nvim_lsp = 1000,
			luasnip = 750,
			buffer = 500,
			path = 250,
		},
	},

	-- Extend LSP configuration
	lsp = {
		skip_setup = {
			"tsserver",
			"dartls",
			"rust_analyzer",
		},
		-- enable servers that you already have installed without lsp-installer
		servers = {
			-- "pyright"
		},
		-- easily add or disable built in mappings added during LSP attaching
		mappings = {
			n = {
				-- ["<leader>lf"] = false -- disable formatting keymap
			},
		},
	},
	diagnostics = {
		virtual_text = false,
		underline = true,
		signs = true,
		update_in_insert = false,
	},
	mappings = {
		-- first key is the mode
		n = {
			-- second key is the lefthand side of the map
			["<C-s>"] = { ":w!<cr>", desc = "Save File" },
			-- DAP
			["<F5>"] = { ":lua require('dap').continue()<CR>", desc = "Debug Run" },
			["<F6>"] = { ":lua require('dap').step_over()<CR>", desc = " Debug Step Over" },
			["<F7>"] = { ":lua require('dap').step_into()<CR>", desc = " Debug Step Into" },
			["<F8>"] = { ":lua require('dap').step_out()<CR>", desc = " Debug Step Out" },
			["<leader>b"] = { ":lua require('dap').toggle_breakpoint()<CR>", desc = "Debug Toggle Breakpoint" },
			["<leader>B"] = {
				":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
				desc = "Debug Toggle Breakpoint Condition",
			},
			["<leader>lp"] = {
				":lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
			},
			["<leader>dr"] = {
				":lua require('dap').repl.open()<CR>",
			},
			["<leader>do"] = {
				":lua require('dapui').open()<CR>",
			},
			["<leader>dc"] = {
				":lua require('dapui').close()<CR>",
			},
			["<leader>dt"] = {
				":lua require('dap-go').debug_test()<CR>",
			},
		},
		i = {
			-- setting a mapping to false will disable it
			["<esc>"] = false,
		},
		t = {
			-- setting a mapping to false will disable it
			-- ["<esc>"] = false,
		},
	},

	-- This function is run last
	-- good place to configuring augroups/autocommands and custom filetypes
	polish = function()
		vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
		--
		-- Set key binding
		-- Set autocommands
		vim.api.nvim_create_augroup("packer_conf", { clear = true })
		vim.api.nvim_create_autocmd("BufWritePost", {
			desc = "Sync packer after modifying plugins.lua",
			group = "packer_conf",
			pattern = "plugins.lua",
			command = "source <afile> | PackerSync",
		})

		-- Set up custom filetypes
		-- vim.filetype.add {
		--   extension = {
		--     foo = "fooscript",
		--   },
		--   filename = {
		--     ["Foofile"] = "fooscript",
		--   },
		--   pattern = {
		--     ["~/%.config/foo/.*"] = "fooscript",
		--   },
		-- }
	end,
}

return config
