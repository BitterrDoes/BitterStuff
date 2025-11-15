-- |
-- |        people from balatro and smods server
-- |

-- Jambatro
SMODS.Joker {
    key = "Jambatro",

    loc_txt = {
        name = "Jambatro",
        text = {"{X:mult,C:white}x#1#{} Mult{} if base score is divisible by #2#."}
    },
    pronouns = "she_her",

    blueprint_compat = true,
	config = { extra = {mult = 4, divide = 2} },
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.mult, card.ability.extra.divide}}
	end,
    
	atlas = 'JokeJokersAtlas',
	pos = { x = 0, y = 1 },

	rarity = 1,
	cost = 3,
    pools = {["BitterPool"] = true},

    set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge("Reflection", G.C.SECONDARY_SET.Planet, G.C.WHITE, 1)
 	end,

    calculate = function(self, card, context)
        if context.joker_main then
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
    pools = {["BitterPool"] = true},

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
        text = {"Creates the last used Tarot or Planet card after skipping a blind", "{C:inactive}(Must have room)", "{C:inactive,s:0.6} 'it says gullible on the ceiling' {}"}
    },

    blueprint_compat = true,
	config = { extra = {} },
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.requirement, card.ability.extra.count}}
	end,
    
	atlas = 'JokeJokersAtlas', -- made by LuckyAF on displate
	pos = { x = 3, y = 0 },

	rarity = 3,
	cost = 6,
    pools = {["BitterPool"] = true},

    set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge("Reflection", G.C.SECONDARY_SET.Planet, G.C.WHITE, 1)
 	end,

    calculate = function(self, card, context)
        if context.skip_blind then
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
        end
    end
}
-- astra
SMODS.Joker {
    key = "Astra",

    loc_txt = {
        name = "Astra",
        text = {"+#2# xchips per mod installed", "{C:inactive}(Currently {X:chips,C:white}X#1#{}){}"}
    },

    blueprint_compat = true,
	config = {extra = {mods = Bitterstuff.ModsUsing, times = 1}},
	loc_vars = function(self, info_queue, card)
		return { vars = {Bitterstuff.ModsUsing, card.ability.extra.times}}
	end,
    
	atlas = 'JokeJokersAtlas', 
	pos = { x = 4, y = 5 },

	rarity = 3,
	cost = 12,
    pools = {["BitterPool"] = true},

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
        text = {"Create #1# random {C:enhanced,T:e_polychrome}Polychrome{} consumeables at end of round", "{C:inactive}(Must have room)"}
    },

    blueprint_compat = true,
	config = { extra = {cards = 2} },
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.cards}}
	end,
    
	atlas = 'JokeJokersAtlas',
	pos = { x = 2, y = 2 },

	rarity = 3,
	cost = 13,
    pools = {["BitterPool"] = true},

    set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge("Reflection", G.C.SECONDARY_SET.Planet, G.C.WHITE, 1)
 	end,

    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval then
            -- main if statement
            
            for _=1, card.ability.extra.cards  do
                -- card will look like {card = key, negative = boolean}
                if #G.consumeables.cards + G.GAME.consumeable_buffer + 1 > G.consumeables.config.card_limit then
                    goto continue
                end
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1

                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local other_card = SMODS.add_card({ set = "Consumeables", area = G.consumeables })
                            other_card:set_edition("e_polychrome")
                            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
                            return true
                        end
                    }))
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
        text = {"Spawns #1# random {E:2,f:Bitters_ComicSans}bitter's stuff{} objects after beating blind"}
    },
    pronouns = "were_was",

    blueprint_compat = true,
	config = { extra = {cards = 1} },
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.cards}}
	end,
    
	atlas = 'JokeJokersAtlas',
	pos = { x = 4, y = 2 },

	rarity = 3,
	cost = 7,
    pools = {["BitterPool"] = true},

    set_badges = function(self, card, badges) -- delete if not a balala member
 		badges[#badges+1] = create_badge("Reflection", G.C.SECONDARY_SET.Planet, G.C.WHITE, 1)
 	end,

    calculate = function(self, card, context)
       if context.end_of_round and context.main_eval then
            -- main if statement
            
            for _=1, card.ability.extra.cards  do
                -- card will look like {card = key, negative = boolean}
                if #G.jokers.cards + G.GAME.joker_buffer + 1 > G.jokers.config.card_limit then
                    goto continue
                end
                G.GAME.joker_buffer = G.GAME.joker_buffer + 1

                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card({ set = "BitterPool" })
                            G.GAME.joker_buffer = G.GAME.joker_buffer - 1
                            return true
                        end
                    }))
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
    pronouns = "he_him",

    blueprint_compat = true,
	config = { extra = {operation = 0, hip = 1.25, description = "X1.25", Chance = 4} },
	loc_vars = function(self, info_queue, card)
		return { vars = {G.GAME.probabilities.normal, card.ability.extra.description, card.ability.extra.Chance}}
	end,
    
	atlas = 'JokeJokersAtlas',
	pos = { x = 2, y = 1 },
    pools = {["BitterPool"] = true},

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
        name = "{f:Bitters_papyrus, C:edition}arc",
        text = {
            "Mult is multiplied by πΠ per card played.",
            "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)"
        }
    },
    pronouns = "zi_zem",
    blueprint_compat = true,
    config = { 
        extra = {
            mult = 1,
        } 
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.mult, card.ability.extra.mult_gain}}
    end,
    atlas = 'JokeJokersAtlas',
	pos = { x = 3, y = 3 },
	soul_pos = { x = 4, y = 3 },
    rarity = "Bitters_autism",
    cost = 26,
    pools = {["BitterPool"] = true},

    set_badges = function(self, card, badges)
        badges[1] = create_badge("Autism", SMODS.Gradients["ExoticGrad"], G.C.WHITE, 1)
        badges[#badges+1] = create_badge("Reflection", G.C.SECONDARY_SET.Planet, G.C.WHITE, 1)
    end,

    calculate = function(self, card, context)

        if context.joker_main then
            return { 
                xmult = card.ability.extra.mult
            }
        end

        if context.individual and context.cardarea == G.play and not context.blueprint then
            card.ability.extra.mult = card.ability.extra.mult* math.pi
        end
    end
}
-- Bitter (THATS ME!!!)
SMODS.Joker {
    key = "bitterjoker",

    loc_txt = {
        name = "{f:Bitters_ComicSans, C:edition}BitterDoes",
        text = {"Copies abilities of all {C:attention}jokers{}"}
    },
    pronouns = "he_him",

    blueprint_compat = true,
	config = { extra = {} },
	loc_vars = function(self, info_queue, card)
		return { vars = {}}
	end,
    
	atlas = 'JokeJokersAtlas',
	pos = { x = 3, y = 1 },
	soul_pos = { x = 4, y = 1 },
    pools = {["BitterPool"] = true},

	rarity = "Bitters_gay",
	cost = 27,

    set_badges = function(self, card, badges)
        badges[1] = create_badge("Gay", SMODS.Gradients["ExoticGrad"], G.C.WHITE, 1)
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
-- swag, temporarially scrapped since idea is too hard to implement
-- SMODS.Joker {
--     key = "swagless",
--     loc_txt = {
--         name = "{f:Bitters_Jokerman, C:edition}Swagless",
--         text = {
--             "{E:1}{C:attention}Joker{} to the left of this one", "now activates per card scored.",
--         }
--     },
--     pronouns = "he_him",
--     blueprint_compat = false,
--     config = { 
--         extra = {
--             tick = 6,
--             joker = nil,
--         } 
--     },
--     loc_vars = function(self, info_queue, card)
--         return { vars = {}}
--     end,
--     atlas = 'JokeJokersAtlas',
-- 	pos = { x = 3, y = 3 },
-- 	soul_pos = { x = 4, y = 3 },
--     rarity = "Bitters_exotic",
--     cost = 14,
--     pools = {["BitterPool"] = true},

--     set_badges = function(self, card, badges)
--         badges[1] = create_badge("Bitchless", SMODS.Gradients["ExoticGrad"], G.C.WHITE, 1)
--         badges[#badges+1] = create_badge("Reflection", G.C.SECONDARY_SET.Planet, G.C.WHITE, 1)
--     end,
--     calculate = function(self, card, context)
--         if context.individual and context.cardarea == G.play then
--            
--         end
-- 	end,
-- }