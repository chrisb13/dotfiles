if true then return end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- From charles-turner-1
-- https://github.com/charles-turner-1/dotfiles/blob/main/nvim/lua/polish.lua
vim.keymap.del("n", "\\")

vim.keymap.set("n", "<C-k>", ":resize -5<CR>", { desc = "Resize window up" })
vim.keymap.set("n", "<C-j>", ":resize +5<CR>", { desc = "Resize window down" })
vim.keymap.set("n", "<C-h>", ":vertical resize -5<CR>", { desc = "Resize window left" })
vim.keymap.set("n", "<C-l>", ":vertical resize +5<CR>", { desc = "Resize window right" })

-- -- buffers
-- vim.keymap.set("n", "<leader>x", ":bd<cr>", { desc = "Delete buffer" })
--
-- -- yank to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
--
--
-- -- black python formatting
-- vim.keymap.set("n", "<leader>fmp", ":silent !black %<cr>")
--
vim.keymap.set("n", "<leader>cd", ":cd %:p:h<cr>:pwd<cr>")
--
-- -- Increment & Decrement numbers
vim.keymap.set("n", "++", "<c-a>", { desc = "Increment number" })
vim.keymap.set("n", "--", "<c-x>", { desc = "Decrement number" })
--
-- -- window management
-- vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
-- vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
-- vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
--
-- vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
-- vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
-- vim.keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
-- vim.keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
-- vim.keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab
-- -- telescope
-- --
-- vim.keymap.set("n", "<leader>ff", ":Telescope find_files<cr>", { desc = "Fuzzy find files" })
-- vim.keymap.set("n", "<leader>fp", ":Telescope git_files<cr>", { desc = "Fuzzy find git files" })
-- vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<cr>", { desc = "Live grep" })
-- vim.keymap.set("n", "<leader>fo", ":Telescope oldfiles<cr>", { desc = "Find old files" })
-- vim.keymap.set("n", "<leader>fh", ":Telescope help_tags<cr>", { desc = "Fuzzy find help" })
-- vim.keymap.set("n", "<leader>fb", ":Telescope buffers<cr>", { desc = "Fuzzy buffer search" })
--
-- -- tree
-- vim.keymap.set("n", "<leader>e", ":NvimTreeFindFileToggle<cr>", { desc = "Toggle explorer" })
--
-- -- format code using LSP
-- vim.keymap.set("n", "<leader>fmd", vim.lsp.buf.format)
--
-- nvim-comment
vim.keymap.set({ "n", "v" }, "<C-/>", "gcc", { desc = "Comment/ uncomment line" })
--
-- Copilot chat
vim.keymap.set({ "n", "v" }, "<leader>cc", ":CopilotChat<cr>", { desc = "Open Copilot chat" })

local ls = require("luasnip")

vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-J>", function() ls.jump(-1) end, {silent = true})

vim.keymap.set({"i", "s"}, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, {silent = true})
