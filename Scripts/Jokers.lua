-- |
-- |        people from balatro and smods server
-- |

-- Jambatro
SMODS.Joker {
    key = "Jambatro",

    loc_txt = {
        name = "Jambatro",
        text = {"{X:mult,C:white}x#1#{} Mult{} if score isn't divisible by #2#."}
    },

    blueprint_compat = true,
	config = { extra = {mult = 4, divide = 2} },
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.mult, card.ability.extra.divide}}
	end,
    
	atlas = 'JokeJokersAtlas',
	pos = { x = 0, y = 1 },

	rarity = 1,
	cost = 3, -- for now tickets = money / 2

    set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge("Reflection", G.C.SECONDARY_SET.Planet, G.C.WHITE, 1)
 	end,

    calculate = function(self, card, context)
        if context.post_joker then
            -- main if statement
            if G.GAME.chips * G.GAME.current_round.current_hand.mult % card.ability.extra.divide ~= 0 then
                return {
                    xmult = card.ability.extra.mult
                }    
            else
                return {
                    message = "Flip, Grin"
                }
            end
        end
    end
}
-- astro
SMODS.Joker {
    key = "Astro", -- i dont wanna get it mixed with the other 15 astros

    loc_txt = {
        name = "Astro",
        text = {"If played hand has a scoring spade", "randomize suit of all unscored cards."}
    },
    pronouns = "guy_guy",

    blueprint_compat = false,
	config = { extra = {} },
	loc_vars = function(self, info_queue, card)
		return { vars = {}}
	end,
    
	atlas = 'JokeJokersAtlas', -- made by daynan77
	pos = { x = 0, y = 0 },

	rarity = 2,
	cost = 4, -- for now tickets = money / 2

    set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge("Reflection", G.C.SECONDARY_SET.Planet, G.C.WHITE, 1)
 	end,

    calculate = function(self, card, context)
        if context.joker_main then
            local scoring_spade = false

            -- check if any scoring card is a spade
            for _, c in pairs(context.scoring_hand) do
                if c:is_suit("Spades") then
                    scoring_spade = true
                    break
                end
            end

            if scoring_spade then
                -- randomize suit of all unscored cards
                
                for _, other_card in pairs(G.play.cards) do
                    if not SMODS.is_in_scoring(other_card) then
                        local suits = { "Spades", "Hearts", "Clubs", "Diamonds" }
                        local new_suit = pseudorandom_element(suits, pseudoseed("spade_randomizer"))
                        other_card:change_suit(new_suit)
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                other_card:juice_up(0.5, 0.5)
                                return true
                            end
                        }))
                    end
                end
                return {
                    message = "Randomized!",
                }
            end
        end
    end
}
-- ekko
SMODS.Joker {
    key = "Ekko", -- i rly need to get a real suffix for the joke jokers

    loc_txt = {
        name = "Ekko",
        text = {"Creates the last used Tarot or Planet card every #1# blinds", "{C:inactive}[#2#/#1#]{}", "{C:inactive,s:0.6} 'it says gullible on the ceiling' {}"}
    },

    blueprint_compat = true,
	config = { extra = {requirement = 2, count = 0} },
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.requirement, card.ability.extra.count}}
	end,
    
	atlas = 'JokeJokersAtlas', -- made by LuckyAF on displate
	pos = { x = 3, y = 0 },

	rarity = 3,
	cost = 6, -- for now tickets = money / 2

    set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge("Reflection", G.C.SECONDARY_SET.Planet, G.C.WHITE, 1)
 	end,

    calculate = function(self, card, context)
        if context.setting_blind then
            card.ability.extra.count = card.ability.extra.count + 1
            if card.ability.extra.count == card.ability.extra.requirement then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        if G.consumeables.config.card_limit > #G.consumeables.cards then
                            local spawn = G.GAME.last_tarot_planet or "c_fool"
                            SMODS.add_card({key = spawn})
                            card:juice_up(0.3, 0.5)
                        end
                        return true
                    end
                }))
                card.ability.extra.count = 0
            end
        end
    end
}
-- astra
SMODS.Joker {
    key = "Astra",

    loc_txt = {
        name = "Astra",
        text = {"+#2# xchips per mod in use", "{C:inactive}(Currently {X:chips,C:white}X#1#{}){}"}
    },

    blueprint_compat = true,
	config = {extra = {mods = Bitterstuff.ModsUsing, times = 1}},
	loc_vars = function(self, info_queue, card)
		return { vars = {Bitterstuff.ModsUsing, card.ability.extra.times}}
	end,
    
	atlas = 'JokeJokersAtlas', 
	pos = { x = 4, y = 2 },

	rarity = 3,
	cost = 12, -- for now tickets = money / 2

    set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge("Reflection", G.C.SECONDARY_SET.Planet, G.C.WHITE, 1)
 	end,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xchips = Bitterstuff.ModsUsing * card.ability.extra.times
            }
        end
    end
}
-- glitchkat
SMODS.Joker {
    key = "glitchkat",

    loc_txt = {
        name = "GlitchKat10",
        text = {"Create #1# random Polychrome consumeables at end of round", "(Must have room)"}
    },

    blueprint_compat = true,
	config = { extra = {cards = 2, Chance = 3} },
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.cards, card.ability.extra.Chance}}
	end,
    
	atlas = 'JokeJokersAtlas',
	pos = { x = 2, y = 2 },

	rarity = 3,
	cost = 13, -- for now tickets = money / 2

    set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge("Reflection", G.C.SECONDARY_SET.Planet, G.C.WHITE, 1)
 	end,

    calculate = function(self, card, context)
        if context.end_of_round then
            -- main if statement
            for i=1, card.ability.extra.cards  do
                -- card will look like {card = key, negative = boolean}
                if #G.consumeables.cards + G.GAME.consumeable_buffer >= G.consumeables.config.card_limit then
                    -- check for space
                    goto continue
                end
                
                local other_card = SMODS.create_card({ key = pseudorandom_element(G.P_CENTER_POOLS.Consumable, "glitchkatcard").key, area = G.consumeables })
                other_card:set_edition("e_polychrome")

                -- so we can skip the card incase
                ::continue::
            end
        end
    end
}
-- Jamirror
SMODS.Joker {
    key = "jamirror",

    loc_txt = {
        name = "Jamirror",
        text = {"{C:green}#1# in #3#{} to add 1 operation (^) to mult after beating boss blind", "{C:inactive}(Currently {X:mult,C:white}#2#{}){}"}
    },

    blueprint_compat = true,
	config = { extra = {operation = 0, hip = 1.25, description = "X1.25", Chance = 4} },
	loc_vars = function(self, info_queue, card)
		return { vars = {G.GAME.probabilities.normal, card.ability.extra.description, card.ability.extra.Chance}}
	end,
    
	atlas = 'JokeJokersAtlas',
	pos = { x = 2, y = 1 },

	rarity = 4,
	cost = 16, -- for now tickets = money / 2

    set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge("Reflection", G.C.SECONDARY_SET.Planet, G.C.WHITE, 1)
 	end,

    calculate = function(self, card, context)
        if context.joker_main then
            if card.ability.extra.operation == 0 then
                return {
                    xmult = card.ability.extra.hip
                }
            else
                return {
                    hypermult = {
                        card.ability.extra.operation,
                        card.ability.extra.hip
                    }
                }
            end
        elseif context.end_of_round and G.GAME.blind.boss and context.cardarea == G.jokers and not context.blueprint then
            if SMODS.pseudorandom_probability(card, 'jamirrorchance', G.GAME.probabilities.normal, card.ability.extra.Chance, 'identifier')  then
                card.ability.extra.operation = card.ability.extra.operation + 1
                if card.ability.extra.operation > 5 then
                   card.ability.extra.operation = 5 
                end
                local number = ""
                for i=1, card.ability.extra.operation do
                    number = number.. "^"
                end
                card.ability.extra.description = tostring(number.. card.ability.extra.hip)
            end
        end
    end
}
-- Bitter (THATS ME!!!)
SMODS.Joker {
    key = "bitterjoker",

    loc_txt = {
        name = "BitterDoes",
        text = {"Copies abilities of all {C:attention}jokers{}"}
    },
    pronouns = "he_him",

    blueprint_compat = true,
	config = { extra = {requirement = 2, count = 0} },
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.requirement, card.ability.extra.count}}
	end,
    
	atlas = 'JokeJokersAtlas',
	pos = { x = 3, y = 1 },
	soul_pos = { x = 4, y = 1 },

	rarity = 4,
	cost = 27, -- for now tickets = money / 2

    set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge("Reflection", G.C.SECONDARY_SET.Planet, G.C.WHITE, 1)
 	end,

    calculate = function(self, card, context)
        local results = {}

        for i, other_joker in pairs(G.jokers.cards) do
            if other_joker ~= card then
                local ret = SMODS.blueprint_effect(card, other_joker, context)
                if ret then
                    table.insert(results, ret)
                end
            end
        end

        return SMODS.merge_effects(results)
    end

}

-- |
-- |        funny controversial developers
-- |

-- Normie
SMODS.Joker {
    key = "normie",

    loc_txt = {
        name = "Normie",
        text = {"{X:mult,C:white}+#1#{} Mult{}"}
    },
    pronouns = "it_its",

    blueprint_compat = true,
	config = { extra = {mult = 20} },
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.mult}}
	end,
    
	atlas = 'JokeJokersAtlas',
	pos = { x = 1, y = 1 },

	rarity = 1,
	cost = 3, -- for now tickets = money / 2

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }    
        end
    end
}
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

	atlas = 'JokeJokersAtlas', -- made by daynan77
	pos = { x = 1, y = 0 },

	rarity = 2,
	cost = 6, -- for now tickets = money / 2

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
        text = {"if a joker's effect doesn't activate", "trigger a {E:1}random{} effect instead", "{C:inactive,s:0.6}can randomize entire deck's rank or suit{}"}
    },
    pronouns = "he_him",

    blueprint_compat = false,
	config = { extra = {chance = 1, mult = 1337, jokersUsed = 0} },
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.jokersUsed}}
	end,

	atlas = 'JokeJokersAtlas', -- made by daynan77
	pos = { x = 4, y = 0 },

	rarity = 2,
	cost = 6, -- for now tickets = money / 2

    calculate = function(self, card, context)
        if context.joker_main then
            card.ability.extra.jokersUsed = 0
        elseif context.other_joker then
            card.ability.extra.jokersUsed = (card.ability.extra.jokersUsed) + 1
        elseif context.post_joker then
            local effect = pseudorandom_element({ "n_mult", "n_xmult", "n_chips", "n_xchips", "n_dollars", "n_xdollars", "randSuits", "randRank", "speed", "restart"}, pseudoseed("yandevRand"))
            print(string.sub(effect, 0, 2), string.sub(effect, 2, 3), string.sub(effect, 2, -1))
            if string.sub(effect, 0, 2) == "n_" then
                local number = math.floor(pseudorandom("yandevNumber") * 100 / string.sub(effect, 3, 3) == "x" and 5 or 1)
                -- ahahahahaha
                local variable = string.sub(effect, 3, -1)
                if variable == "mult" then
                    return {
                        mult = number
                    }
                elseif variable == "xmult" then
                    return {
                        xmult = number
                    }
                elseif variable == "chips" then
                    return {
                        chips = number
                    }
                elseif variable == "xchips" then
                    return {
                        xchips = number
                    }
                elseif variable == "dollars" then
                    return {
                        dollars = number
                    }
                elseif variable == "xdollars" then
                    G.GAME.dollars = G.GAME.dollars * number
                    return {
                        message = "X".. number,
			            colour = G.C.MONEY
                    }
                end
            end
            -- yes i will do if then end, 5 times over without elseif
            if effect == "randSuits" then
                for _, other_card in pairs(G.playing_cards) do
                    local new_suit = pseudorandom_element({ "Spades", "Hearts", "Clubs", "Diamonds" }, pseudoseed("YandevSuit"))
                    other_card:change_suit(new_suit)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            other_card:juice_up(0.5, 0.5)
                            return true
                        end
                    }))
                end
            end
            if effect == "randRank" then
                for _, other_card in pairs(G.playing_cards) do
                    local new_rank = pseudorandom_element(SMODS.Ranks, pseudoseed("YandevSuit"))
                    SMODS.modify_rank(other_card, new_rank)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            other_card:juice_up(0.5, 0.5)
                            return true
                        end
                    }))
                end
            end
            if effect == "speed" then
                G.SETTINGS.GAMESPEED = 0.25
            end
            if effect == "restart" then
                SMODS.restart_game()
            end
        end
    end
}

-- |
-- |        joker suggestions
-- |

-- Spinel (first try)
SMODS.Joker {
    key = "FirstTry",
    
    loc_txt = {
        name = "Spinel",
        text = {"{X:mult,C:white}X#1#{} Mult{}", "{C:inactive,s:0.6}Suggested by FirstTry.{}"}
    },
    pronouns = "she_her",

    blueprint_compat = true,
    config = { extra = {xmult = 6000} },
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.xmult}}
	end,

    rarity = 3,
    cost = 5,

	atlas = 'JokeJokersAtlas', -- made by daynan77
	pos = { x = 2, y = 0 },

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}

-- |
-- |        other funnies
-- |

-- yes this was inspired by yahi | john ultrakill
SMODS.Joker {
    key = "v1ultrakill",
    
    loc_txt = {
        name = "John Ultrakill",
        text = {
            "{X:chips,C:white}X#1#{} chips after parrying",
            "Add +X#2# per parry",
            "{C:inactive}(press f to parry)"
        },
    },
    pronouns = "it_its",

    config = { extra = {
        xmult = 2,
        xchips = 2,
        additional = 0.5,
        hit = false,
        pleasetrigger = false}
    },

	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.xchips, card.ability.extra.additional} }
	end,

    blueprint_compat = true,
    rarity = 2,
    cost = 9,

	atlas = 'JokeJokersAtlas',
	pos = { x = 1, y = 2 },

    calculate = function(self, card, context)
        if context.joker_main and card.ability.extra.pleasetrigger then
            return {
                x_chips = card.ability.extra.xchips
            }
        elseif context.post_joker and not context.blueprint then
            G.hasparrytriggered = nil
            G.hasparrybeenthrown = nil
            card.ability.extra.pleasetrigger = false
        end
    end,
}