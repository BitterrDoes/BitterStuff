SMODS.current_mod.calculate = function(self, context) -- will take over the old one
    if context.setting_blind then
        G.GAME.playing = true
		if G.GAME.round_bonus.dollars then
			G.GAME.dollars = G.GAME.dollars + G.GAME.round_bonus.dollars
		end
	elseif context.end_of_round and context.main_eval then
		G.GAME.playing = false
-- Suikalatro things
    elseif context.joker_main then
        if SuikaLatro then
            for _, ball in pairs(SuikaLatro.balls) do
                SMODS.calculate_context({ Bitters_suika_individual = true, other_card = ball})
            end
        end
    end
end