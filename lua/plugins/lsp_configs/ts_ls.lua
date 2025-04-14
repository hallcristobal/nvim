local M = {}

M.setup = function(on_attach)
	return {
		settings = {
			javascript = {
				inlayHints = {
					includeInlayEnumMemberValueHints = true, -- boolean;
					includeInlayFunctionLikeReturnTypeHints = true, -- boolean;
					includeInlayFunctionParameterTypeHints = true, -- boolean;
					includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
					includeInlayParameterNameHintsWhenArgumentMatchesName = true, -- boolean;
					includeInlayPropertyDeclarationTypeHints = true, -- boolean;
					includeInlayVariableTypeHints = true, -- boolean;
					includeInlayVariableTypeHintsWhenTypeMatchesName = true, -- boolean;
				},
			},
			typescript = {
				inlayHints = {
					includeInlayEnumMemberValueHints = true, -- boolean;
					includeInlayFunctionLikeReturnTypeHints = true, -- boolean;
					includeInlayFunctionParameterTypeHints = true, -- boolean;
					includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
					includeInlayParameterNameHintsWhenArgumentMatchesName = true, -- boolean;
					includeInlayPropertyDeclarationTypeHints = true, -- boolean;
					includeInlayVariableTypeHints = true, -- boolean;
					includeInlayVariableTypeHintsWhenTypeMatchesName = true, -- boolean;
				},
			},
		},
		on_attach = on_attach,
	}
end

return M
