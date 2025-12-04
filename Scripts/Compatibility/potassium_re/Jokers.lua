-- Day 1
SMODS.Joker:take_ownership("j_Bitters_arcjoker", {
    atlas = "GlopJokers",

    config = { 
        extra = {
            glop = 1,
            xsfark = 1,
        } 
    },

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.glop, card.ability.extra.xsfark}, key = "j_Bitters_arc_glop"}
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            return { 
                glop = card.ability.extra.glop,
                xsfark = card.ability.extra.xsfark
            }
        elseif context.individual and context.cardarea == G.play and not context.blueprint then
            card.ability.extra.glop = card.ability.extra.glop * math.pi
            print("add glop", card.ability.extra.glop)
            if card.ability.extra.glop >= 1000000 --[[1 million]] then
                SMODS.set_scoring_calculation('kali_sfark')
                card.ability.extra.glop = 1
                print("take glop", card.ability.extra.glop)
                card.ability.extra.xsfark = card.ability.extra.xsfark + math.pi
                print("add sfark", card.ability.extra.xsfark)
            end
        end
    end
})

-- Day 2
SMODS.Joker:take_ownership("j_Bitters_swagless", {
    atlas = "GlopJokers",

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.xmult}, key = "j_Bitters_glopless"}
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if not next(SMODS.get_enhancements(context.other_card)) then
                return {
                    xglop = card.ability.extra.xmult
                }  
            elseif not context.blueprint then
                card.ability.extra.xmult = card.ability.extra.xmult + 0.25
                return {
                    message = "Glop!",
                    colour = G.C.GREEN
                }
            end
        end
	end,
})

-- Day 3
SMODS.Joker:take_ownership("j_Bitters_jamirror", {
    atlas = "GlopJokers",

	loc_vars = function(self, info_queue, card)
		return {key = "j_Bitters_glopmirror", vars = {card.ability.extra, card.ability.extra / 2}}
	end,

    calculate = function(self, card, context)
        if context.retrigger_joker_check and card.ability.extra > 0 then
            local target = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    target = G.jokers.cards[i - 1]
                end
            end
            
            if context.other_card == target then
                return { repetitions = 1 }
            end
        elseif context.joker_main then
            return {
                glop = card.ability.extra / 2
            }
        elseif context.blind_defeated and not context.blueprint then
            if card.ability.extra - 1 <= 0 then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = "Amazing",
                    colour = G.C.RED
                }
            else
                card.ability.extra = card.ability.extra - 1
                return {
                    message = card.ability.extra .. '',
                    colour = G.C.FILTER
                }
            end
        end
    end
})

-- Day 4
SMODS.Joker:take_ownership("j_Bitters_yourself", {
    atlas = "GlopJokers",

	loc_vars = function(self, info_queue, card)
		return {key = "j_Bitters_glopself", vars = {Bitterstuff.Downloads}}
	end,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xglop = Bitterstuff.Downloads
            }
        end
    end
})

-- Day 4
SMODS.Joker:take_ownership("j_Bitters_BEAR5", {
    atlas = "GlopJokers",

	loc_vars = function(self, info_queue, card)
        local picked_card = G.GAME.current_round.card_picker_selection or { rank = 'Ace', suit = 'Spades' }
		return { 
            vars = {
                card.ability.extra.xchips, card.ability.extra.xmult, localize(picked_card.suit, 'suits_plural'), localize(picked_card.rank, 'ranks'),
                colours = { HEX("00FFAA"), HEX("24b367") }
            }
        }
	end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and G.GAME.current_round.card_picker_selection then
            if context.other_card:is_suit(G.GAME.current_round.card_picker_selection.suit) or context.other_card:get_id() == G.GAME.current_round.card_picker_selection.id then
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
                    xmult = card.ability.extra.xchips,
                    xglop = card.ability.extra.xmult
                }
            end
        end
    end
})