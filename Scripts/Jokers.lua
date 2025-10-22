-- |
-- |        people from balatro and smods server
-- |

-- Jambatro
SMODS.Joker {
    key = "joke_Jambatro",

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
    key = "balapit_Astro", -- i dont wanna get it mixed with the other 15 astros

    loc_txt = {
        name = "Jambatro",
        text = {"If played hand has a scoring spade, randomize suit of all unscored cards."}
    },

    blueprint_compat = true,
	config = { extra = {mult = 3, divide = 3} },
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.mult, card.ability.extra.divide}}
	end,
    
	atlas = 'JokeJokersAtlas', -- made by daynan77
	pos = { x = 0, y = 0 },

	rarity = 3,
	cost = 6, -- for now tickets = money / 2

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
    key = "joke_Ekko", -- i rly need to get a real suffix for the joke jokers

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
    key = "joke_Astra",

    loc_txt = {
        name = "Ekko",
        text = {"Creates the last used Tarot or Planet card every #1# blinds", "{C:inactive}[#2#/#1#]{}", "{C:inactive,s:0.6} 'it says gullible on the ceiling' {}"}
    },

    blueprint_compat = true,
	config = { extra = {requirement = 2, count = 0} },
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.requirement, card.ability.extra.count}}
	end,
    
	atlas = 'JokeJokersAtlas', 
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

-- |
-- |        funny controversial developers
-- |

-- piratesoftware
SMODS.Joker {
    key = "balapit_piratesoftware",
    
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
    key = "balapit_yandev",
    
    loc_txt = {
        name = "yandev",
        text = {"if a joker's effect doesn't activate, trigger a random effect instead"}
    },

    blueprint_compat = true,
	config = { extra = {chance = 1, mult = 1337} },
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.chance, card.ability.extra.mult}}
	end,

	atlas = 'JokeJokersAtlas', -- made by daynan77
	pos = { x = 1, y = 0 },

	rarity = 2,
	cost = 6.7, -- for now tickets = money / 2

    calculate = function(self, card, context)
        if context.joker_main then
        end
    end
}

-- |
-- |        joker suggestions
-- |

-- Spinel (first try)
SMODS.Joker {
    key = "balapit_FirstTry",
    
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