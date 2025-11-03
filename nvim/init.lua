-- This file simply bootstraps the installation of Lazy.nvim and then calls other files for execution
-- This file doesn't necessarily need to be touched, BE CAUTIOUS editing this file and proceed at your own risk.
vim.g.mapleader = ","

local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  local result = vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
  if vim.v.shell_error ~= 0 then
    -- stylua: ignore
    vim.api.nvim_echo({ { ("Error cloning lazy.nvim:\n%s\n"):format(result), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
    vim.fn.getchar()
    vim.cmd.quit()
  end
end

vim.opt.rtp:prepend(lazypath)

-- validate that lazy is available
if not pcall(require, "lazy") then
  -- stylua: ignore
  vim.api.nvim_echo({ { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
  vim.fn.getchar()
  vim.cmd.quit()
end

require "lazy_setup"
require "polish"

if vim.g.started_by_firenvim == true then
  vim.o.laststatus = 0

  -- will always take over an object
  vim.g.firenvim_config.localSettings['.*'] = { takeover = 'always' }

  -- will set file type to markdown for all GitHub buffers:
  vim.api.nvim_create_autocmd({'BufEnter'}, {
    pattern = "github.com_*.txt",
    command = "set filetype=markdown"
  })
else
  vim.o.laststatus = 2
end


-- In your Neovim configuration (e.g., init.lua)
local function open_gh_dash()
  require("toggleterm.terminal").Terminal:new({
    cmd = "gh dash",
    direction = "float",
    float_opts = {
      border = "single", -- or "rounded", "double"
      width = 120,       -- adjust as needed
      height = 30,       -- adjust as needed
    },
  }):toggle()
end

vim.keymap.set("n", "<leader>gd", open_gh_dash, { desc = "Open gh-dash" })
