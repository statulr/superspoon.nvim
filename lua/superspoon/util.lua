local M = {}

M.mode = function()
	local modes = {
		["n"] = "NORMAL",
		["no"] = "NORMAL",
		["v"] = "VISUAL",
		["V"] = "VISUAL LINE",
		[""] = "VISUAL BLOCK",
		["s"] = "SELECT",
		["S"] = "SELECT LINE",
		[""] = "SELECT BLOCK",
		["i"] = "INSERT",
		["ic"] = "INSERT",
		["R"] = "REPLACE",
		["Rv"] = "VISUAL REPLACE",
		["c"] = "COMMAND",
		["cv"] = "VIM EX",
		["ce"] = "EX",
		["r"] = "PROMPT",
		["rm"] = "MOAR",
		["r?"] = "CONFIRM",
		["!"] = "SHELL",
		["t"] = "TERMINAL",
	}

	local current_mode = vim.api.nvim_get_mode().mode

	return table.concat({ " %s ", modes[current_mode]}):upper()
end

M.file_info = function()
	return " %t "
end

M.line_info = function()
	if vim.bo.filetype == "alpha" then
		return ""
	end

	return " %l:%c [%P] "
end

M.lsp = function()
	local set_hl = vim.api.nvim_set_hl

	set_hl(0, "SpoonDiagnosticError", { fg = "#F94B4B", bg = "#282433", default = true })
	set_hl(0, "SpoonDiagnosticWarn", { fg = "#CDE24E", bg = "#282433", default = true })
	set_hl(0, "SpoonDiagnosticInfo", { fg = "#5CA2DF", bg = "#282433", default = true })
	set_hl(0, "SpoonDiagnosticHint", { fg = "#60CCC9", bg = "#282433", default = true })

	local count = {}
	local dtype = {
		errors = "Error",
		warnings = "Warn",
		info = "Info",
		hints = "Hint",
	}

	for k, level in pairs(dtype) do
		count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
	end

	local errors = ""
	local warnings = ""
	local hints = ""
	local info = ""

	if count["errors"] ~= 0 then
		errors = table.concat({ "%#SpoonDiagnosticError#  ", count["errors"], "%#SpoonDiagnosticError# " })
	end
	if count["warnings"] ~= 0 then
		warnings = table.concat({ "%#SpoonDiagnosticWarn#  ", count["warnings"], "%#SpoonDiagnosticWarn# " })
	end
	if count["hints"] ~= 0 then
		hints = table.concat({ "%#SpoonDiagnosticHint#  ", count["hints"], "%#SpoonDiagnosticHint# " })
	end
	if count["info"] ~= 0 then
		info = table.concat({ "%#SpoonDiagnosticInfo#  ", count["info"], "%#SpoonDiagnosticInfo# " })
	end

	return table.concat({
		errors,
		warnings,
		hints,
		info,
		"%#Normal#",
	})
end

return M
