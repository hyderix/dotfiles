
-- Lualine setup
local lualine = require("lualine")
lualine.setup {
    options = {
	theme = "dracula",
	component_separators = { left = '', right = ''},
	section_separators = { left = '', right = ''}
    }
}



-- Colorscheme
vim.cmd("colorscheme dracula")



-- nvim-treesitter
require'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all"
    ensure_installed = { "c", "lua", "rust", "latex", "python", "markdown", "toml" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = false,

    -- List of parsers to ignore installing (for "all")
    ignore_install = { "javascript" },

    highlight = {
	-- `false` will disable the whole extension
	enable = true,

	-- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
	-- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
	-- the name of the parser)
	-- list of language that will be disabled
	disable = {  },
	-- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files

	-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
	-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
	-- Using this option may slow down your editor, and you may see some duplicate highlights.
	-- Instead of true it can also be a list of languages
	additional_vim_regex_highlighting = false,
    },
}

-- Setup lsp-zero
local lsp = require('lsp-zero')
lsp.preset('recommended')

lsp.ensure_installed({
    'clangd',
    'rust_analyzer',
    'texlab',
})

lsp.nvim_workspace()

lsp.setup()

vim.g.vimtex_view_general_viewer = 'zathura'
vim.g.vimtex_compiler_latexmk_engines = {
    _ = '-lualatex'
}
