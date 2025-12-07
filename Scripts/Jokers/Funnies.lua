
-- Common Jokers

-- Spinel (first try)
SMODS.Joker {
    key = "FirstTry",
    name = "Spinel",
    pronouns = "she_her",

    blueprint_compat = true,
    config = { extra = {chips = 60} },
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.chips}}
	end,

    rarity = 1,
    cost = 5,
    pools = {["BitterPool"] = true},

	atlas = 'MiscJokers',
	pos = { x = 2, y = 0 },

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}

-- Shield
SMODS.Joker {
    key = "shield",
    name = "Shield",
    pronouns = "any_all",

    blueprint_compat = true,
    config = { extra = {mult = 5, gain = 5, lose = 10} },
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.mult, card.ability.extra.gain, card.ability.extra.lose}}
	end,

    rarity = 1,
    cost = 8,
    pools = {["BitterPool"] = true},

	atlas = 'MiscJokers',
	pos = { x = 1, y = 2 },

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        elseif context.end_of_round and context.main_eval then
            if G.GAME.current_round.hands_played == 1 then
                card.ability.extra.mult = card.ability.extra.mult + 5
                return {
                    message = "Upgrade!"
                }
            else
                card.ability.extra.mult = card.ability.extra.mult - 10
                return {
                    message = "Degrade..",
                    colour = G.C.RED
                }
            end
        end
    end
}

-- joker idea
SMODS.Joker {
    key = "jidea",
    name = "Joker idea",
    pronouns = "any_all",

	-- atlas = 'MiscJokers',
	-- pos = { x = 2, y = 0 },
    config = { extra = {creates = 2} },
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.creates}}
	end,

    blueprint_compat = true,
    rarity = 1,
    cost = 5,
    pools = {["BitterPool"] = true},

    remove_from_deck = function(self, card, from_debuff)
        if from_debuff then return end
        
        local jokers_to_create = math.min(card.ability.extra.creates,
            G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
        G.E_MANAGER:add_event(Event({
            func = function()
                for _ = 1, jokers_to_create do
                    if G.GAME.joker_buffer + #G.jokers.cards >= G.jokers.config.card_limit then return end

                    G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                    local joker = SMODS.add_card {
                        set = 'Joker',
                        key_append = 'Bitters_jidea',
                    }
                    joker:set_perishable()
                    G.GAME.joker_buffer = 0
                end
                return true
            end
        }))
    end
}

-- Normie
SMODS.Joker {
    key = "normie",
    name = "Normie",
    pronouns = "it_its",

    blueprint_compat = true,
	config = { extra = {mult = 20} },
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.mult}}
	end,
    
	atlas = 'MiscJokers',
	pos = { x = 3, y = 0 },

	rarity = 1,
	cost = 3,
    pools = {["BitterPool"] = true},

    calculate = function(self, card, context)
        if context.joker_main and context.scoring_name == Bitterstuff.Highesthand() then
            return {
                mult = card.ability.extra.mult
            }    
        end
    end
}


-- Uncommon Jokers

-- piratesoftware
SMODS.Joker { -- fixed
    key = "piratesoftware",
    
    loc_txt = {
        name = "Pirate Software",
        text = {"{C:green}#1# in 2{} Chance of 'crashing' your game", "Otherwise {X:mult,C:white}X#2#{} Mult{}"}
    },
    pronouns = "he_him",

    blueprint_compat = true,
	config = { extra = {xmult = 5} },
	loc_vars = function(self, info_queue, card)
		return { vars = {G.GAME.probabilities.normal, card.ability.extra.xmult}}
	end,

	atlas = 'MiscJokers',
	pos = { x = 1, y = 0 },

	rarity = 2,
    cost = 6,
    pools = {["BitterPool"] = true},

    set_badges = function(self, card, badges)
 		badges[1] = create_badge("Bad Dev", HEX("ff2222"), G.C.WHITE, 1)
 	end,

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
            else
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
    end
}

-- yes this was inspired by yahi | john ultrakill
SMODS.Joker {
    key = "v1ultrakill",
    name = "John Ultrakill",
    pronouns = "it_its",

    config = { extra = {
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

	atlas = 'MiscJokers',
	pos = { x = 0, y = 1 },

    calculate = function(self, card, context)
        if context.joker_main and card.ability.extra.pleasetrigger then
            return {
                xchips = card.ability.extra.xchips
            }
        elseif context.post_joker and not context.blueprint then
            G.QTE_ResetVars("j_Bitters_v1ultrakill")
            card.ability.extra.pleasetrigger = false
        end
    end,
}

-- v2 goober
SMODS.Joker {
    key = "v2goober",
    pronouns = "it_its",

    rarity = 3,
    cost = 1,
    pools = {["BitterPool"] = true},

	atlas = 'MiscJokers',
	pos = { x = 2, y = 2 },

    add_to_deck = function(self, card, from_debuff)
        SMODS.create_card({key = "j_Bitters_v2goober"}) -- never adds to deck, just sits there :3
        SMODS.destroy_cards(card)
    end
}

-- salsaman
SMODS.Joker {
    key = "saleman",
    name = "Salesman",
    pronouns = "he/him",

    config = { extra = {
        repetitions = 3,
        target = nil
    }},

    loc_vars = function(_,_,card)
		return { vars = {card.ability.extra.retriggers} }
    end,

    blueprint_compat = true,
    rarity = 2,
    price = 7,
    pools = {["BitterPool"] = true},

	-- atlas = 'MiscJokers',
	-- pos = { x = 1, y = 2 },

    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and context.other_card.ability.Bitters_s_target then
            return {
                repetitions = card.ability.extra.repetitions
            }
        end
        if context.setting_blind then
            local target = pseudorandom_element(G.deck.cards, "Bitters_Salsaman")
            target.ability.Bitters_s_target = true
            return {
                message = "Added!"
            }
        elseif context.end_of_round and context.main_eval then
            for _, other_card in pairs(G.deck.cards) do
                if other_card.ability.Bitters_s_target then
                    other_card.ability.Bitters_s_target = nil
                end
            end
        end
    end
}

-- english major
SMODS.Joker {
    key = "english",
    name = "English Major",
    pronouns = "she_her",

    atlas = 'MiscJokers',
	pos = { x = 4, y = 0 },
    
    blueprint_compat = true,
    config = { extra = {
        mult = 2,
        additional = 1.5,
        hit = false,
        pleasetrigger = false
    }},
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.mult, card.ability.extra.additional}}
	end,
    
    pools = {["BitterPool"] = true},
	rarity = 2,
    cost = 7,
    
    calculate = function(self, card, context)
        if context.joker_main and card.ability.extra.pleasetrigger then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

-- Rare Jokers

-- taskmgr
SMODS.Joker {
    key = "taskmgr",
    name = "Task Manager",

	atlas = 'MiscJokers',
	pos = { x = 0, y = 2 },

	cost = 3,
    rarity = 3,
    blueprint_compat = true,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local files = NFS.getDirectoryItems(G.DocDir) -- get files
            local file = tostring(pseudorandom_element(files, "evilnamechange")) -- find the file to change

            local ext = file:match("%.([^%.]+)$") or "" -- holy shit i learnt witchcraft

            local new = "balls".. math.random(0,1000000)--[[hash but im dumb]] .. (ext ~= "" and "." .. ext or "")

            local ok, err = os.rename(G.DocDir.. "/".. file, G.DocDir.. "/".. new)
            if not ok then
                print("rename failed:", err)
            end

            return {
                message = file.."!",
                xmult = #file,
            }
        end
    end
}

-- yandev
SMODS.Joker { -- fixed
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

	atlas = 'MiscJokers',
	pos = { x = 0, y = 0 },

	rarity = 3,
	cost = 6,
    pools = {["BitterPool"] = true},

    set_badges = function(self, card, badges)
 		badges[1] = create_badge("Bad Dev", HEX("ff2222"), G.C.WHITE, 1)
 	end,

    calculate = function(self, card, context)
        if context.playing_card_added and not context.blueprint then
            for _, other_card in pairs(context.cards) do
                SMODS.change_base(other_card, pseudorandom_element(SMODS.Suits, 'yandev_suit').key, pseudorandom_element(SMODS.Ranks, 'yandev_rank').key)

                other_card:set_seal(pseudorandom_element(G.P_CENTER_POOLS.Seal, 'yandev_s').key)
                other_card:set_edition(pseudorandom_element(G.P_CENTER_POOLS.Edition, 'yandev_e').key)
                other_card:set_ability(pseudorandom_element(G.P_CENTER_POOLS.Enhanced, 'yandev_a').key)
            end
        end
    end
}

-- santa
SMODS.Joker {
    key = "santa",
    name = "Santa",
    pronouns = "she_her",

    -- atlas = 'MiscJokers',
	-- pos = { x = 0, y = 2 },
    
    blueprint_compat = true,
    pools = {["BitterPool"] = true},
	rarity = 2,
    cost = 7,
    
    calculate = function(self, card, context)
        if context.blind_defeated and context.main_eval then
            G.E_MANAGER:add_event(Event({
                func = function()
                    if G.GAME.consumeable_buffer + #G.consumeables.cards < G.consumeables.config.card_limit then
                        SMODS.add_card({key = "c_Bitters_present"})
                    end
                    return true
                end
            }))
        end
    end
}

-- urself
SMODS.Joker {
    key = "yourself",
    name = "Yourself",
    pronouns = "any_all",

    atlas = 'MiscJokers',
	pos = { x = 4, y = 1 },
    
    blueprint_compat = true,
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

-- dingaling
SMODS.Joker { -- shamelessly stolenw
    key = "goldding",
    name = "when they touchse yo {C:attention}golden{} {C:gold}dingaling{}",
    pronouns = "it_its", -- its_me

    blueprint_compat = true,
	config = { extra = {xchips = 1.5, xmult = 1.2} },
	loc_vars = function(self, info_queue, card)
        local picked_card = G.GAME.current_round.card_picker_selection or { rank = 'Ace', suit = 'Spades' }
		return { vars = {card.ability.extra.xchips, card.ability.extra.xmult, localize(picked_card.suit, 'suits_plural'),
            colours = { HEX('0000FF') }
        }
    }
	end,
    
	atlas = 'MiscJokers',
	pos = { x = 1, y = 1 },

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



-- Legendary Jokers


-- bear 5
SMODS.Joker {
    key = "BEAR5",
    name = "BEAR5",
    pronouns = "it_its",

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
    
	atlas = 'MiscJokers',
	pos = { x = 2, y = 1 },

	rarity = 4,
	cost = 15,
    discovered = true,
    unlocked = true,
    eternal_compat = true,
    -- pools = {["BitterPool"] = true, ["Joker"] = false},

    set_badges = function(self, card, badges)
        badges[1] = create_badge("BEAR5", HEX("0000FF"), G.C.WHITE, 1)
 	end,

    add_to_deck = function()
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

-- squid
SMODS.Joker {
    key = "squid",
    name = "squid+",

    atlas = "SquidAtAss",
    display_size = { w = 96, h = 96 },
	pos = { x = 0, y = 0 },
    pronouns = "any_all",

	cost = 6,
    rarity = 4,
    blueprint_compat = true,

	config = { extra = {frame = 1, secondthingidk = 0, target = nil, storage = {atlas = "Bitters_SquidAtAss", scale = {x=96, y=96}}} },

    update = function(self, card, dt) -- animated joker pog
        local config = card.ability.extra
        config.frame = config.frame + 1 * dt

        if config.frame >= 1.02 then
            config.frame = 1

            local other_joker = nil
            if G.jokers and G.jokers.cards then
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i] == card then 
                        other_joker = G.jokers.cards[i - 1] 
                    end
                end
            end
            
            card.ability.extra.target = other_joker
            -- Update sprite
            if G.GAME.playing and other_joker then
                local center = other_joker.children.center

                -- card.children.center = center
                card.children.center.atlas = G.ASSET_ATLAS[center.atlas.name]
                card.children.center:set_sprite_pos({ x=center.sprite_pos.x, y= center.sprite_pos.y })
                card.children.center.scale = {x=center.scale.x, y=center.scale.y}

            else
                -- my game crashed so hope this works

                -- reset
                card.children.center.atlas = G.ASSET_ATLAS[config.storage.atlas]
                card.children.center.scale = {x=config.storage.scale.x, y=config.storage.scale.y}

                -- set frame
                config.secondthingidk = config.secondthingidk + 1
                if config.secondthingidk == 17 then
                    config.secondthingidk = 0
                end

                -- set pos
                card.children.center:set_sprite_pos({ x=config.secondthingidk, y=0 })
            end
        end
    end,

    calculate = function(self, card, context)
        local other_joker = card.ability.extra.target
        return SMODS.merge_effects {SMODS.blueprint_effect(card, other_joker, context) or {}, SMODS.blueprint_effect(card, other_joker, context) or {}}
    end,
}

-- amerbijfgr smith
SMODS.Joker {
    key = "elliottsmith",
    name = "Elliot Smith",
    pronouns = "he_him",

    blueprint_compat = true,
	config = { extra = {mult = 147} },
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.mult, 0.75}}
	end,
    
	atlas = 'MiscJokers',
	pos = { x = 3, y = 1 },
    pools = {["BitterPool"] = true},

	rarity = 4,
	cost = 5,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.mult
            }
        end
    end
}