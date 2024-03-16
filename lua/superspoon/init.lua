local M = {}

local Util = require("superspoon.util")

Statusline = {}

Statusline.active = function()
	return table.concat({
		"%#Statusline#",
		Util.mode(),
		Util.file_info(),
		Util.lsp(),
		"%#Statusline#%=",
		Util.line_info(),
	})
end

Statusline.inactive = function()
	return ""
end

M.setup = function()
	vim.opt.showmode = false

	local spoon = vim.api.nvim_create_augroup("spoon", {
		clear = true,
	})

	vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
		command = "setlocal statusline=%!v:lua.Statusline.active()",
		group = spoon,
	})

	vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
		command = "setlocal statusline=%!v:lua.Statusline.inactive()",
		group = spoon,
	})
end

return M
