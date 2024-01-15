local on_attach = function(_, bufnr)
	local bufmap = function(keys, func)
		vim.keymap.set('n', keys, func, { buffer = bufnr })
    end

	bufmap('<leader>pf', require('telescope.builtin').find_files)
	bufmap('<leader>fg', require('telescope.builtin').live_grep)
end


require('telescope').setup({
	on_attach = on_attach,
	extensions = {
    	fzf = {
      		fuzzy = true,                    -- false will only do exact matching
      		override_generic_sorter = true,  -- override the generic sorter
      		override_file_sorter = true,     -- override the file sorter
      		case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
    	}
  	}
})
