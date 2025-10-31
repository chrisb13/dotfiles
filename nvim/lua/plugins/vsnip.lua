return {
  {
    "hrsh7th/vim-vsnip",
    config = function()
      -- Only use VS Code–style snippet sources
      vim.g.vsnip_snippet_dir = vim.fn.stdpath("config") .. "/vscode_snippets"

      -- Optionally disable builtin vsnip snippets
      vim.g.vsnip_filetypes = {}
    end,
  },
  { "hrsh7th/cmp-vsnip" },
}

