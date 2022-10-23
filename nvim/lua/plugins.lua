-- LSP
-- from: https://alpha2phi.medium.com/neovim-for-beginners-lsp-part-1-b3a17ddbe611
use {
  "neovim/nvim-lspconfig",
  opt = true,
  event = "BufReadPre",
  wants = { "nvim-lsp-installer" },
  config = function()
    require("config.lsp").setup()
  end,
  requires = {
    "williamboman/nvim-lsp-installer.nvim",
  },
}
