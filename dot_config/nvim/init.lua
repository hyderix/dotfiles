-- Set <space> as leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- I have a nerd font
vim.g.have_nerd_font = true

-- Termguicolors
vim.opt.termguicolors = true

-- Enable relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse mode
vim.opt.mouse = 'a'

-- Don't show editing mode, as it is already displayed in status
vim.opt.showmode = false

-- Do not sync OS and Nvim clipboard by default
-- vim.opt.clipboard = 'unnamedplus'

-- Enable breakindent
vim.opt.breakindent = true

-- Visual bell
vim.opt.visualbell = true

-- Save undo history
vim.opt.undofile = true

-- Case insensitive smart search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Incremental search
vim.opt.incsearch = true

-- Decrease update time
vim.opt.updatetime = 250

-- Display which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure splitting
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Preview substitutions as I type
vim.opt.inccommand = 'split'

-- Show which line the cursor is on
vim.opt.cursorline = true

-- Scrolloff, how many lines above/below cursor must be present
vim.opt.scrolloff = 8

-- Do not hilight search results
vim.opt.hlsearch = false

-- vim.opt.textwidth = 100
-- vim.opt.showbreak = "+++"
vim.opt.linebreak = false

-- Indentation using spaces
vim.opt.autoindent = true
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.softtabstop = 4

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode'})

-- Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!"<CR>')

-- Use Control and hjkl to move focus
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Bootstrap lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- Set up lazy with some plugins :D
require('lazy').setup({
    -- Set up tabbing
    'tpope/vim-sleuth',

    -- Commenting
    {
	'numToStr/Comment.nvim',
	config = function()
	    require('Comment').setup()
	end,
    },

    -- Git signs
    { 
	'lewis6991/gitsigns.nvim',
	config = function()
	    require('gitsigns').setup()
	end,
    },

    -- Fuzzy finder
    {
	'nvim-telescope/telescope.nvim',
	event = 'VimEnter',
	tag = '0.1.8',
	dependencies = {
	    'nvim-lua/plenary.nvim',
	},

	config = function()
	    require('telescope').setup()
	    local builtin = require('telescope.builtin')
	    vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
	    vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
	    vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
	    vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
	end,
    },
    {
	'nvim-treesitter/nvim-treesitter',
	build = ':TSUpdate',
	opts = {
	    ensure_installed = {'bash', 'c', 'diff', 'rust', 'lua', 'markdown', 'vim', 'vimdoc', 'luadoc', 'python', 'nix', 'go'},
	    auto_install = true,
	    highlight = {
		enable = true,
	    },
	    indent = { enable = true },
	},
	config = function(_, opts)
	    require('nvim-treesitter.install').prefer_git = true
	    ---@diagnostic disable-next-line: missing-fields
	    require('nvim-treesitter.configs').setup(opts)
	end,
    },

    -- Nice color scheme
    'doums/darcula',

    -- LSP
    {
	'neovim/nvim-lspconfig',
	config = function()
	    local servers = {'rust_analyzer', 'gopls', 'nil', 'pyright'}
	    for _, server in ipairs(servers) do
		if vim.fn.executable(server) == 1 then
		    require('lspconfig')[server].setup{}
		end
	    end
	end,
    },
})

vim.cmd("colorscheme darcula")
