local M = {}

-- Namespace para o texto virtual
local ns_id = vim.api.nvim_create_namespace("eolnumbers")

-- Função auxiliar para obter letra e highlight baseado na severidade
local function get_diag_info(severity)
	if severity == 1 then
		return "E", "DiagnosticSignError" -- Erro
	elseif severity == 2 then
		return "W", "DiagnosticSignWarn" -- Warning
	elseif severity == 3 then
		return "I", "DiagnosticSignInfo" -- Info
	elseif severity == 4 then
		return "H", "DiagnosticSignHint" -- Hint
	else
		return "", "LineNr" -- Padrão
	end
end

-- Função para atualizar os números e diagnósticos no final das linhas
local function update_eol_numbers()
	-- Limpa o texto virtual anterior
	vim.api.nvim_buf_clear_namespace(0, ns_id, 0, -1)

	-- Pega o número total de linhas
	local line_count = vim.api.nvim_buf_line_count(0)

	-- Pega a linha atual (base 1)
	local current_line = vim.api.nvim_win_get_cursor(0)[1]

	-- Pega os diagnósticos do LSP para o buffer atual
	local diagnostics = vim.diagnostic.get(0)

	-- Cria um mapa de diagnósticos por linha
	local diag_map = {}
	for _, diag in ipairs(diagnostics) do
		local lnum = diag.lnum + 1 -- Linha (base 1 para corresponder ao número)
		diag_map[lnum] = diag_map[lnum] or {}
		local letter, hl_group = get_diag_info(diag.severity)
		table.insert(diag_map[lnum], { letter, hl_group })
	end

	-- Define o width dinamicamente com base no número de linhas
	local number_width = -math.max(3, #tostring(line_count))

	-- Adiciona os diagnósticos e número à direita da janela
	for i = 1, line_count do
		local virt_text = { { " ", "" } } -- Espaço inicial para alinhamento
		if diag_map[i] then
			for _, diag in ipairs(diag_map[i]) do
				table.insert(virt_text, { diag[1] .. " ", diag[2] }) -- Letra com highlight
			end
		end
		-- Formata o número com preenchimento à esquerda
		local padded_number = string.format("%" .. number_width .. "d ", i)
		-- Usa CursorLineNr para a linha atual, LineNr para as demais
		local number_hl = i == current_line and "CursorLineNr" or "LineNr"
		table.insert(virt_text, { padded_number, number_hl }) -- Número com highlight
		vim.api.nvim_buf_set_extmark(0, ns_id, i - 1, 0, {
			virt_text = virt_text, -- Diagnósticos à esquerda do número
			virt_text_pos = "right_align", -- Alinha à direita da janela
		})
	end
end

-- Função de setup
function M.setup()
	-- Desativa os sinais de diagnóstico padrão à esquerda
	vim.diagnostic.config({
		signs = false, -- Remove os sinais da margem esquerda
	})

	-- Atualiza ao abrir um buffer, mudar o texto, atualizar diagnósticos ou mover o cursor
	vim.api.nvim_create_autocmd(
		{ "BufEnter", "TextChanged", "TextChangedI", "DiagnosticChanged", "CursorMoved", "CursorMovedI" },
		{
			callback = update_eol_numbers,
		}
	)

	-- Executa uma vez ao carregar
	update_eol_numbers()
end

return M
