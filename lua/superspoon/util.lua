local M = {}

M.lineinfo = function()
  if vim.bo.filetype == "alpha" then
    return ""
  end
  return " %l:%c [%P] "
end

M.lsp = function()
	local set_hl = vim.api.nvim_set_hl

	set_hl(0, "SpoonDiagnosticError", { fg = "#ff5555", default = true })
	set_hl(0, "SpoonDiagnosticWarn",  { fg = "#ffff55", default = true })
	set_hl(0, "SpoonDiagnosticInfo",  { fg = "#55afff", default = true })
	set_hl(0, "SpoonDiagnosticHint",  { fg = "#55ffaf", default = true })

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
		errors = " %#SpoonDiagnosticError# " .. count["errors"]
	end
	if count["warnings"] ~= 0 then
		warnings = " %#SpoonDiagnosticWarn# " .. count["warnings"]
	end
	if count["hints"] ~= 0 then
		hints = " %#SpoonDiagnosticHint# " .. count["hints"]
	end
	if count["info"] ~= 0 then
		info = " %#SpoonDiagnosticInfo# " .. count["info"]
	end

	return errors .. warnings .. hints .. info .. "%#Normal#"
end

return M
