
-- |
-- |        controversial developers
-- |

-- piratesoftware
SMODS.Joker {
    key = "piratesoftware",
    
    loc_txt = {
        name = "Pirate Software",
        text = {"{C:green}#1# in 2{} Chance of 'crashing' your game", "Otherwise {X:mult,C:white}+#2#{} Mult{}"}
    },
    pronouns = "he_him",

    blueprint_compat = true,
	config = { extra = {chance = 1, mult = 1337} },
	loc_vars = function(self, info_queue, card)
		return { vars = {G.GAME.probabilities.normal, card.ability.extra.mult}}
	end,

	atlas = 'JokeJokersAtlas',
	pos = { x = 1, y = 0 },

	rarity = "Bitters_baddev",
    cost = 6,
    pools = {["BitterPool"] = true},

    calculate = function(self, card, context)
        if context.joker_main then
            if SMODS.pseudorandom_probability(card, 'piratesoftware', G.GAME.probabilities.normal, 2, 'identifier') then
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 1,
                    func = function()
                        SMODS.restart_game()
                    end
                }))
                return {
                    message = "Oh no."
                }
            else
                return {
                    mult = card.ability.extra.mult
                }
            end
        end
    end
}
-- yandev
SMODS.Joker {
    key = "yandev",
    
    loc_txt = {
        name = "Yandare Dev",
        text = {"Added playing cards have everything {C:,E:1}randomized"}
    },
    pronouns = "he_him",

    blueprint_compat = false,
	config = { extra = {} },
	loc_vars = function(self, info_queue, card)
		return { vars = {}}
	end,

	atlas = 'JokeJokersAtlas',
	pos = { x = 4, y = 0 },

	rarity = "Bitters_baddev",
	cost = 6,
    pools = {["BitterPool"] = true},

    calculate = function(self, card, context)
        if context.playing_card_added and not context.blueprint then
            -- print(context.cards)
            for _, other_card in pairs(context.cards) do
                SMODS.change_base(other_card, pseudorandom_element(SMODS.Suits, 'yandev_suit').key, pseudorandom_element(SMODS.Ranks, 'yandev_rank').key)

                other_card:set_seal(pseudorandom_element(G.P_CENTER_POOLS.Seal, 'yandev_s').key)
                other_card:set_edition(pseudorandom_element(G.P_CENTER_POOLS.Edition, 'yandev_e').key)
                other_card:set_ability(pseudorandom_element(G.P_CENTER_POOLS.Enhanced, 'yandev_a').key)
            end
        end
    end
}