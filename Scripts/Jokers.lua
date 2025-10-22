print('ra')

-- |
-- |        people from balatro and smods server
-- |

-- Jambatro
SMODS.Joker {
    key = "Jambatro",

    loc_txt = {
        name = "Jambatro",
        text = {"{X:mult,C:white}x#1#{} Mult{} if hand score is divisible by #2#."}
    },

    blueprint_compat = true,
	config = { extra = {mult = 3, divide = 3} },
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.mult, card.ability.extra.divide}}
	end,
    
	atlas = 'ModdedVanilla',
	pos = { x = 4, y = 0 },

	rarity = 1,
	cost = 3, -- for now tickets = money / 2

    calculate = function(self, card, context)
        if context.joker_main then
            -- main if statement
            if G.GAME.chips / card.ability.extra.divide == math.floor(G.GAME.chips / card.ability.extra.divide) then
                print(G.GAME.chips / card.ability.extra.divide == math.floor(G.GAME.chips / card.ability.extra.divide), G.GAME.chips / card.ability.extra.divide, G.GAME.chips)
                return {
                    mult = card.ability.extra.mult
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
        text = {"If played hand has a scoring spade, randomize suit of all unscored cards."}
    },

    blueprint_compat = true,
	config = { extra = {} },
	loc_vars = function(self, info_queue, card)
		return { vars = {}}
	end,
    
	atlas = 'JokeJokersAtlas', -- made by daynan77
	pos = { x = 0, y = 0 },

	rarity = 2,
	cost = 4, -- for now tickets = money / 2

    calculate = function(self, card, context)
        if context.joker_main then
            local scoring_spade = false

            -- check if any scoring card is a spade
            for _, c in ipairs(context.scoring_hand) do
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
        text = {"STILL BEING MADE SELL ME!!"}
    },

    blueprint_compat = true,
	config = { extra = {requirement = 2, count = 0} },
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.requirement, card.ability.extra.count}}
	end,
    
	atlas = 'JokeJokersAtlas', 
	pos = { x = 0, y = 1 },

	rarity = 3,
	cost = 15, -- for now tickets = money / 2

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

-- |
-- |        funny controversial developers
-- |

-- piratesoftware
SMODS.Joker {
    key = "piratesoftware",
    
    loc_txt = {
        name = "Pirate Software",
        text = {"{C:green}#1# іn 2{} Chance of crashing your game.", "Otherwise {X:mult,C:white}+#2#{} Mult{}"}
    },

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
                        while true do print(":3") end -- :3
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
        text = {"if a joker's effect doesn't activate, trigger a random effect instead", "{C:inactive,s:0.6}can randomize entire deck's rank or suit!{}"}
    },

    blueprint_compat = true,
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
                else
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