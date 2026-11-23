-- TextYankPost runs after a yank, so the copied region can be highlighted briefly.
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("user_highlight_yank", { clear = true }),
	desc = "Highlight yanked text",
	callback = function()
		vim.hl.on_yank({ timeout = 150 })
	end,
})

-- Keep search highlights for search/repeat keys; clear them after other Normal-mode keys.
local keep = { ["/"] = true, ["?"] = true, n = true, N = true, ["*"] = true, ["#"] = true }

vim.on_key(function(key)
	if vim.v.hlsearch == 0 or vim.fn.mode() ~= "n" or keep[vim.fn.keytrans(key)] then
		return
	end
	-- Defer clearing until the key's normal-mode action has completed.
	vim.schedule(function()
		if vim.v.hlsearch == 1 then
			vim.cmd.nohlsearch()
		end
	end)
end, vim.api.nvim_create_namespace("user_auto_nohlsearch"))
