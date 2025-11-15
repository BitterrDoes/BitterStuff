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
    pools = {["BitterPool"] = true},

	atlas = 'JokeJokersAtlas',
	pos = { x = 2, y = 0 },

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

-- |
-- |        other funnies
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
	cost = 3,
    pools = {["BitterPool"] = true},

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }    
        end
    end
}

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
    pools = {["BitterPool"] = true},

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


-- dingaling
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
    pools = {["BitterPool"] = true},

    add_to_deck = function(self, card, from_debuff)
        Bitterstuff.bear5check(card)
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
            Bitterstuff.bear5check(card)
        end
    end
}
-- bear 5
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
                card.ability.extra.xchips, card.ability.extra.xmult, localize(picked_card.suit, 'suits_plural'), localize(picked_card.rank, 'ranks'),
            colours = { HEX("0000FF"), HEX("2424b3") }
        }
    }
	end,
    
	atlas = 'JokeJokersAtlas',
	pos = { x = 1, y = 3 },

	rarity = 2,
	cost = 0,
    discovered = true,
    unlocked = true,
    eternal_compat = true,
    pools = {["BitterPool"] = true, ["Joker"] = false},

    set_badges = function(self, card, badges)
        badges[1] = create_badge("BEAR5", HEX("0000FF"), G.C.WHITE, 1)
 	end,

    add_to_deck = function()
        -- check for j_tgnt_dingaling
        play_sound("Bitters_bear5scream", 1, 0.3) -- too louhd!
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
                    xmult = card.ability.extra.xmult,
                    xchips = card.ability.extra.xchips
                }
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
    pools = {["BitterPool"] = true},

	rarity = 3,
	cost = 5,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.mult
            }
        end
    end
}
-- urself
SMODS.Joker {
    key = "yourself",

    loc_txt = {
        name = "Yourself",
        text = {"+1 {X:mult,C:white}xmult{} for every file in your {C:Blue, E:1}downloads{}", "{C:inactive}(Currently {X:mult,C:white}x#1#{})"}
    },
    pronouns = "any_all",

    atlas = 'JokeJokersAtlas',
	pos = { x = 0, y = 4 },
    
    blueprint_compat = true,
	config = { extra = {mult = 15} },
	loc_vars = function(self, info_queue, card)
		return { vars = {Bitterstuff.Downloads}}
	end,
    
    pools = {["BitterPool"] = true},
	rarity = 3,
    cost = 5,

    
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = Bitterstuff.Downloads
            }
        end
    end
}
-- CLicker from cloverpit
SMODS.Seal {
    key = "tempRed",

    config = { extra = { retriggers = 1 } },

    atlas = 'tempsealAtlas',
    pos = { x = 0, y = 0 },
    loc_txt = {
        name = "Temporary Red Seal",
        text = {
            "Retrigger this",
            "card {C:attention}#1#{} time",
        },
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.retriggers } }
    end,
    set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge("Red Seal?", G.C.RED)
 	end,

    calculate = function(self, card, context)
        if context.repetition then
            return {
                repetitions = card.ability.seal.extra.retriggers,
            }
        elseif context.playing_card_post_joker then
            print("a")
            return {
                message = "Melted!",
                func = function()
                    G.E_MANAGER:add_event(Event({
                        trigger = "after",
                        delay = 1,
                        func = function()
                            card.seal = nil
                        end
                    }))
                end
            }
        end
    end,
}

SMODS.Joker {
    key = 'clicker',
	loc_txt = {
		name = 'Clicker',
		text = {
			".+#1# in 5 chance for drawn playing cards to have a temporary red seal.",
		}
	},
    blueprint_compat = false,
	config = { extra = {Chance = 15} },
	rarity = 2,
	atlas = 'JokeJokersAtlas',
	pos = { x = 4, y = 0 },
	cost = 6, -- for now tickets = money / 2
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.Numerator, card.ability.extra.Denominator}}
	end,

    calculate = function(self, card, context)
        if context.hand_drawn and context.hand_drawn then
            print("drawing cards")
            for i, other_card in pairs(context.hand_drawn) do
                if SMODS.pseudorandom_probability(card, 'clicker', card.ability.extra.Chance, 100, 'identifier') then
                    other_card:set_seal(card.ability.extra.Seal,nil,true)
                    print("adding seal")
                end
            end

            
        end
    end
}

SMODS.Joker {
    key = "taskmgr",
    loc_txt = {
        name = "Task Manager",
        text = {
            "{C:white,X:mult}X3{} mult per card",
            "{E:1, C:mult}Will rename a random file ", "{E:1, C:mult}in your videos folder to 'Balls'",
        }
    },

	cost = 3, -- for now tickets = money / 2
    blueprint_compat = true,

    -- add_to_deck = function()
    --     open_WIP_popup()
    -- end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local files = NFS.getDirectoryItems(G.DocDir) -- get files
            local file = tostring(pseudorandom_element(files, "evilnamechange")) -- find the file to change
            print(file)

            local ext = file:match("%.([^%.]+)$") or "" -- holy shit i learnt witchcraft
            print(ext)

            local new = "balls".. math.random(0,1000000)--[[hash if but im dumb af]] .. (ext ~= "" and "." .. ext or "")
            print(new)

            local ok, err = os.rename(G.DocDir.. "/".. file, G.DocDir.. "/".. new)
            if not ok then
                print("rename failed:", err)
            else
                print("renamed to:", G.DocDir.. "/".. new)
            end

            return {
                message = "fuck ".. file,
                xmult = 3,
                remove_default_message = true,
            }
        end
    end
}