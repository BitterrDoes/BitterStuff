--[[
template
SMODS.Joker {
    key = "temp",

    loc_txt = {
        name = "Template",
        text = {"{X:mult,C:white}x#1#{} Mult{}"}
    },

    blueprint_compat = true,
	config = { extra = {mult = 2} },
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.mult}}
	end,
    
	atlas = 'JokeJokersAtlas',
	pos = { x = 0, y = 0 },

	rarity = 1,
	cost = 1,
    pools = {["Bitter"] = true},

    set_badges = function(self, card, badges) -- delete if not a balala member
 		badges[#badges+1] = create_badge("Reflection", G.C.SECONDARY_SET.Planet, G.C.WHITE, 1)
 	end,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.mult
            }  
        end
    end
}

--]]
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
	cost = 3,
    pools = {["Bitter"] = true},

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
	cost = 4,
    pools = {["Bitter"] = true},

    set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge("Reflection", G.C.SECONDARY_SET.Planet, G.C.WHITE, 1)
 	end,

    calculate = function(self, card, context)
        if context.joker_main then
                    local scoring_spade = false
                    local scored = {}

                    -- check if any scoring card is a spade
                    for _, c in pairs(context.scoring_hand) do
                        if c:is_suit("Spades") then
                            scoring_spade = true
                            scored[c] = true
                        end
                    end

                    return { -- so other jokers wait
                        func = function()
                            if scoring_spade then
                                -- randomize suit of all unscored cards
                                for _, other_card in pairs(G.play.cards) do
                                    if not scored[other_card] and SMODS.Suits then
                                        local new_suit = pseudorandom_element(SMODS.Suits, pseudoseed("spade_randomizer")).key
                                        G.E_MANAGER:add_event(Event({
                                            func = function()
                                                other_card:change_suit(new_suit)
                                                other_card:juice_up(0.5, 0.5) -- funni shake
                                                return true
                                            end
                                        }))
                                    end
                                end
                                card_eval_status_text(card, 'extra', nil, nil, nil, { message = "Randomized!" })
                            end
                        end
                    }
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

	rarity = 2,
	cost = 6,
    pools = {["Bitter"] = true},

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
	config = {extra = {mods = BitterTestingtuff.ModsUsing, times = 1}},
	loc_vars = function(self, info_queue, card)
		return { vars = {BitterTestingtuff.ModsUsing, card.ability.extra.times}}
	end,
    
	atlas = 'JokeJokersAtlas', 
	pos = { x = 4, y = 5 },

	rarity = 3,
	cost = 12,
    pools = {["Bitter"] = true},

    set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge("Reflection", G.C.SECONDARY_SET.Planet, G.C.WHITE, 1)
 	end,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xchips = BitterTestingtuff.ModsUsing * card.ability.extra.times
            }
        end
    end
}
-- glitchkat
SMODS.Joker {
    key = "glitchkat",

    loc_txt = {
        name = "GlitchKat10",
        text = {"Create #1# random {C:enhanced,T:e_polychrome}Polychrome{} consumeables at end of round", "(Must have room)"}
    },

    blueprint_compat = true,
	config = { extra = {cards = 2, Chance = 3} },
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.cards, card.ability.extra.Chance}}
	end,
    
	atlas = 'JokeJokersAtlas',
	pos = { x = 2, y = 2 },

	rarity = 3,
	cost = 13,
    pools = {["Bitter"] = true},

    set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge("Reflection", G.C.SECONDARY_SET.Planet, G.C.WHITE, 1)
 	end,

    calculate = function(self, card, context)
        if context.end_of_round then
            -- main if statement
            for _=1, card.ability.extra.cards  do
                -- card will look like {card = key, negative = boolean}
                if #G.consumeables.cards + G.GAME.consumeable_buffer >= G.consumeables.config.card_limit then
                    -- check for space
                    goto continue
                end

                
                local other_card = SMODS.create_card({ key = pseudorandom_element(G.P_CENTER_POOLS[""], "glitchkatcard").key, area = G.consumeables })
                other_card:set_edition("e_polychrome")

                -- so we can skip the card incase
                ::continue::
            end
        end
    end
}
-- im breeding
SMODS.Joker {
    key = "breeder",

    loc_txt = {
        name = "Nxkoo",
        text = {"Spawns #1# random {E:2,f:BitterTesting_ComicSans}bitter's stuff{} objects after beating blind"}
    },
    pronouns = "were_was",

    blueprint_compat = true,
	config = { extra = {cards = 1} },
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.cards}}
	end,
    
	atlas = 'JokeJokersAtlas',
	pos = { x = 4, y = 2 },

	rarity = 1,
	cost = 1,
    pools = {["Bitter"] = true},

    set_badges = function(self, card, badges) -- delete if not a balala member
 		badges[#badges+1] = create_badge("Reflection", G.C.SECONDARY_SET.Planet, G.C.WHITE, 1)
 	end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
            local jokers_to_create = math.min(card.ability.extra.cards, G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
            G.GAME.joker_buffer = G.GAME.joker_buffer + jokers_to_create
            G.E_MANAGER:add_event(Event({
                func = function()
                    for _ = 1, jokers_to_create do
                        SMODS.add_card {
                            set = "BitterTesting_Bitter",
                            key_append = 'NxkooBreeder' -- Optional, useful for manipulating the random seed and checking the source of the creation in `in_pool`.
                        }
                        local card = create_card("Cat", G.Jokers, nil, nil, nil, nil, nil, 'cardboardbox')
                        card:add_to_deck()
                        G.jokers:emplace(card)
                        G.GAME.joker_buffer = 0
                    end
                    return true
                end
            }))
            return {
                message = "Im breeding"
            }  
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
    pronouns = "he_him",

    blueprint_compat = true,
	config = { extra = {operation = 0, hip = 1.25, description = "X1.25", Chance = 4} },
	loc_vars = function(self, info_queue, card)
		return { vars = {G.GAME.probabilities.normal, card.ability.extra.description, card.ability.extra.Chance}}
	end,
    
	atlas = 'JokeJokersAtlas',
	pos = { x = 2, y = 1 },
    pools = {["Bitter"] = true},

	rarity = 4,
	cost = 16,

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
-- Arcadiseudf
SMODS.Joker {
    key = "arcjoker",
    loc_txt = {
        name = "{f:BitterTesting_papyrus, C:edition}arc",
        text = {
            "Gains {X:mult,C:white}X#2#{} Mult per card played.",
            "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)"
        }
    },
    pronouns = "he_him",
    blueprint_compat = true,
    config = { 
        extra = {
            mult = 1,
            mult_gain = 2
        } 
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.mult, card.ability.extra.mult_gain}}
    end,
    atlas = 'JokeJokersAtlas',
	pos = { x = 3, y = 3 },
	soul_pos = { x = 4, y = 3 },
    rarity = "BitterTesting_autism",
    cost = 26,
    pools = {["Bitter"] = true},

    set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge("Reflection", G.C.SECONDARY_SET.Planet, G.C.WHITE, 1)
    end,

    calculate = function(self, card, context)

        if context.joker_main then
            return { 
                xmult = card.ability.extra.mult
            }
        end

        if context.individual and context.cardarea == G.play and not context.blueprint then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
            return {
                message = "+X1 Mult!",
                card = card
            }
        end
    end
}
-- Bitter (THATS ME!!!)
SMODS.Joker {
    key = "bitterjoker",

    loc_txt = {
        name = "{f:BitterTesting_ComicSans, C:edition}BitterDoes",
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
    pools = {["Bitter"] = true},

	rarity = "BitterTesting_gay",
	cost = 27,

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

	rarity = "BitterTesting_baddev",
    cost = 6,
    pools = {["Bitter"] = true},

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

	atlas = 'JokeJokersAtlas',
	pos = { x = 4, y = 0 },

	rarity = "BitterTesting_baddev",
	cost = 6,
    pools = {["Bitter"] = true},

    calculate = function(self, card, context)
        if context.joker_main then
            card.ability.extra.jokersUsed = 0
        elseif context.other_joker then
            card.ability.extra.jokersUsed = (card.ability.extra.jokersUsed) + 1
        elseif context.post_joker then
            local effect = pseudorandom_element({ "n_mult", "n_xmult", "n_chips", "n_xchips", "n_dollars", "n_xdollars", "randSuits", "randRank", "speed", "restart"}, pseudoseed("yandevRand"))
            print(string.sub(effect, 0, 2), string.sub(effect, 2, 3), string.sub(effect, 2, -1))
            if string.sub(effect, 0, 2) == "n_" then
                local number = math.floor(pseudorandom("yandevNumber") * 100 / string.sub(effect, 3, 3)  == "x" and 5 or 1)
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
	cost = 3,
    pools = {["Bitter"] = true},

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }    
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
        text = {"{C:mult}+#1#{} Mult", "{C:inactive,s:0.6}Suggested by FirstTry.{}"}
    },
    pronouns = "she_her",

    blueprint_compat = true,
    config = { extra = {mult = 6000} },
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.mult}}
	end,

    rarity = 3,
    cost = 5,
    pools = {["Bitter"] = true},

	atlas = 'JokeJokersAtlas',
	pos = { x = 2, y = 0 },

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.xmult
            }
        end
    end
}

-- |~~
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
    pools = {["Bitter"] = true},

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

local function bear5check(card) -- taken from joker forge dont @ me
    if (function()
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].config.center.key == "j_tngt_dingaling" then
                    print(G.jokers.cards[i])
                    G.jokers.cards[i]:remove()
                    print("Found Dingaling")
                    return true
                end
            end
        return false
    end)() then
        -- print(self)
            card:remove()
        G.E_MANAGER:add_event(Event({
            func = function()
                SMODS.add_card({key = "j_BitterTesting_BEAR5"})
                return true
            end
        }))
    end
end


SMODS.Joker { -- shamelessly stolenw
    key = "goldding",

    loc_txt = {
        name = "when they touchse yo {C:attention}golden{} {C:gold}dingaling{}",
        text = {
            "{X:blue,C:white}X#1#{} Chips and {X:mult,C:white}X#2#{} Mult",
            "if you touched their {C:attention}#3#{}",
            "{C:inactive}({C:attention}dingaling suit{} {C:inactive}changes every round.)"
        }
    },
    pronouns = "its_me",

    blueprint_compat = true,
	config = { extra = {xchips = 1.5, xmult = 1.2} },
	loc_vars = function(self, info_queue, card)
        local picked_card = G.GAME.current_round.card_picker_selection or { rank = 'Ace', suit = 'Spades' }
		return { vars = {card.ability.extra.xchips, card.ability.extra.xmult, localize(picked_card.suit, 'suits_plural'),
            colours = { HEX('0000FF') }
        }
    }
	end,
    
	atlas = 'JokeJokersAtlas',
	pos = { x = 0, y = 3 },

	rarity = 3,
	cost = 6,
    discovered = true,
    unlocked = true,
    eternal_compat = true,

    add_to_deck = function(self, card, from_debuff)
        bear5check(card)
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and G.GAME.current_round.card_picker_selection then
            if context.other_card:is_suit(G.GAME.current_round.card_picker_selection.suit) then
                return {
                    xmult = card.ability.extra.xmult,
                    xchips = card.ability.extra.xchips
                }
            end
        elseif context.card_added and context.cardarea == G.jokers then
            bear5check(card)
        end
    end
}

SMODS.Joker {
    key = "BEAR5",

    loc_txt = {
        name = "{B:1}BEAR5",
        text = {
            "{X:blue,C:white}X#1#{} {V:1}Chips and {X:mult,C:white}X#2#{} {V:1}Mult",
            "{V:1}if you touched their {C:attention}#3#{} {V:1}or any {C:attention}#4#{}",
            "{C:inactive}({C:attention}dingaling suit{} {V:2}changes every round.)"
        }
    },
    pronouns = "bear_5",

    blueprint_compat = true,
	config = { extra = {xchips = 3, xmult = 3} },
	loc_vars = function(self, info_queue, card)
        local picked_card = G.GAME.current_round.card_picker_selection or { rank = 'Ace', suit = 'Spades' }
		return { 
            vars = {
                card.ability.extra.xchips, card.ability.extra.xmult, localize(picked_card.suit, 'suits_plural', localize(picked_card.rank, 'ranks')),
            colours = { HEX("0000FF"), HEX("2424b3") }
        }
    }
	end,
    
	atlas = 'JokeJokersAtlas',
	pos = { x = 1, y = 3 },

	rarity = "BitterTesting_bear5rare",
	cost = 0,
    discovered = true,
    unlocked = true,
    eternal_compat = true,
    pools = {["Bitter"] = true},

    add_to_deck = function()
        -- check for j_tgnt_dingaling
        play_sound("BitterTesting_bear5scream", 1, 0.3) -- too louhd!
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and G.GAME.current_round.card_picker_selection then
            if context.other_card:is_suit(G.GAME.current_round.card_picker_selection.suit) or context.other_card:get_id() == G.GAME.current_round.card_picker_selection.id then
                return {
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                play_sound("BitterTesting_bear5scream", math.random(90,110) / 100, 0.3)
                                card:juice_up(3.5, 3.5) -- oh god what do these values do
                                return true
                            end
                        })) 
                    end,
                    xmult = card.ability.extra.xmult,
                    xchips = card.ability.extra.xchips
                }
            end
            Set_card_type_badge = function(self, card, badges)
 		        badges[#badges+1] = create_badge("Idiot", G.C.SECONDARY_SET.Planet, G.C.WHITE, 1)
            end
        end
    end
}
-- amerbijfgr smith
SMODS.Joker {
    key = "elliottsmith",

    loc_txt = {
        name = "Elliot Smith",
        text = {"{X:mult,C:white}x#2#{} Mult{} for each song on spotify by Elliot Smith", "{C:inactive}(Currently 196 for {X:mult,C:white}x#1#{} {C:inactive}Mult)", "{C:inactive,s:0.6}(Reacts in real time!)"}
    },

    blueprint_compat = true,
	config = { extra = {mult = 147, add = 0.75} },
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.mult, card.ability.extra.add}}
	end,
    pronouns = "he_him",
    
	atlas = 'JokeJokersAtlas',
	pos = { x = 2, y = 3 },
    pools = {["Bitter"] = true},

	rarity = 2,
	cost = 5,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.mult
            }
        end
    end
}

-- ideas rightt

-- tiktok water filter, that one that makes you look like you're drowning in liquid metal right, but gives crazy mult, oh also will randomly rise, (bucket to get rid of some??)
-- The family's fighting again, X15 mult if theres a king and queen of different suits
-- all ultrakill layers


-- crashes | nxkoo bad argument #1 in ipairs
