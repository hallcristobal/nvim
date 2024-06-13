return {
    -- Packer can manage itself
    -- 'wbthomason/packer.nvim',

    {
        'nvim-telescope/telescope.nvim',
        dependencies = { { 'nvim-lua/plenary.nvim' } },
    },
    {
        'rose-pine/neovim',
        as = 'rose-pine',
    },
    {
        'Mofiqul/vscode.nvim',
        as = 'vscode-color',
    },
    { 'catppuccin/nvim', as = 'catppuccin' },
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
    'nvim-treesitter/nvim-treesitter-context',
    'mbbill/undotree',
    'tpope/vim-fugitive',

    -- lsp-zero stuff
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        dependencies = {
            --- Uncomment the two plugins below if you want to manage the language servers from neovim
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'L3MON4D3/LuaSnip' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lua' },
            { 'rafamadriz/friendly-snippets' },
            { 'ray-x/lsp_signature.nvim' }
        },
    },
    {
        'stevearc/conform.nvim',
        config = function()
            require('conform').setup()
        end,
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
    },
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = function()
            require('nvim-autopairs').setup({})
        end,
    },
    'windwp/nvim-ts-autotag',
    'folke/tokyonight.nvim',
    -- {
    --     'nvim-tree/nvim-tree.lua',
    --     dependencies = {
    --         'nvim-tree/nvim-web-devicons', -- optional
    --     },
    -- },
    -- { 'akinsho/bufferline.nvim', dependencies = 'nvim-tree/nvim-web-devicons' },
    { 'numtostr/BufOnly.nvim' },
    { 'lukas-reineke/indent-blankline.nvim' },
    { 'SergioRibera/cmp-dotenv' },
    { 'rmagatti/goto-preview' },
    {
        'CosmicNvim/cosmic-ui',
        dependencies = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' }
    },
    {
        'christoomey/vim-tmux-navigator',
        lazy = false,
    },
}
