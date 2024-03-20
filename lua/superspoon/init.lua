local M = {}

local Util = require("superspoon.util")

Statusline = {}

Statusline.active = function()
	local parts = { "%#Statusline#" }

	local opts = {
		{ "spoon_mode", Util.mode() },
		{ "spoon_file_info", Util.file_info() },
		{ "spoon_filetype", Util.filetype() },
		{ "spoon_diagnostics", Util.diagnostics() },
		{ "spoon_line_info", Util.line_info() },
	}

	local right = {}

	for _, opt in ipairs(opts) do
		if vim.api.nvim_get_var(opt[1]) == true then
			if opt[1] == "spoon_line_info" then
				table.insert(right, opt[2])
			else
				table.insert(parts, opt[2])
			end
		end
	end

	table.insert(parts, "%#Statusline#%=")

	-- Concatenate the right_parts to the end of parts
	for _, part in ipairs(right) do
		table.insert(parts, part)
	end

	return table.concat(parts)
end

Statusline.inactive = function()
	return ""
end

M.setup = function(opts)
	local defaults = require("superspoon.lib.default_config")

	local merged_opts = vim.tbl_extend("keep", opts, defaults)

	vim.api.nvim_set_var("spoon_mode", merged_opts.mode)
	vim.api.nvim_set_var("spoon_file_info", merged_opts.file_info)
	vim.api.nvim_set_var("spoon_filetype", merged_opts.filetype)
	vim.api.nvim_set_var("spoon_diagnostics", merged_opts.diagnostics)
	vim.api.nvim_set_var("spoon_line_info", merged_opts.line_info)

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
