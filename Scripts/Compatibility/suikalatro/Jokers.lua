local broken = {
    "j_Bitters_saleman", -- All individual context jokers are broken
    "j_Bitters_english", -- qte's are broken
    "j_Bitters_v1ultrakill", -- ^^
    "j_Bitters_taskmgr",
    -- "j_Bitters_goldding",
    -- "j_Bitters_BEAR5",
    "j_Bitters_Astro",
    "j_Bitters_arcjoker",
    "j_Bitters_swagless",
}

for _, key in pairs(broken) do
    SMODS.Joker:take_ownership(key, {
        in_pool = function() return false end,
        no_collection = true
    }, true)
end

SMODS.Joker:take_ownership("j_Bitters_goldding",{
    calculate = function(self, card, context)
        if context.Bitters_suika_individual and G.GAME.current_round.card_picker_selection then
            if context.other_card.suit == G.GAME.current_round.card_picker_selection.suit then
                return {
                    xmult = card.ability.extra.xmult,
                    xchips = card.ability.extra.xchips
                }
            end
        elseif context.card_added and context.cardarea == G.jokers then
            Bitterstuff.bear5check(card)
        end
    end
})

SMODS.Joker:take_ownership("j_Bitters_BEAR5",{
    calculate = function(self, card, context)
        if context.Bitters_suika_individual and G.GAME.current_round.card_picker_selection then
            if context.other_card.suit == G.GAME.current_round.card_picker_selection.suit or context.other_card.id == G.GAME.current_round.card_picker_selection.id then
                return {
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                play_sound("Bitters_bear5scream", math.random(90,110) / 100, 0.3)
                                card:juice_up(3.5, 3.5) -- oh god what do these values do
                                return true
                            end
                        })) 
                    end,
                    xmult = card.ability.extra.xmult,
                    xchips = card.ability.extra.xchips
                }
            end
        end
    end
})