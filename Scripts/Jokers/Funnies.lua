

-- Common Jokers

-- Spinel (first try)
SMODS.Joker {
    key = "FirstTry",
    name = "Spinel",
    pronouns = "she_her",

    blueprint_compat = true,
    config = { extra = {chips = 60} },
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.mult}}
	end,

    rarity = 1,
    cost = 5,
    pools = {["BitterPool"] = true},

	atlas = 'JokeJokersAtlas',
	pos = { x = 2, y = 0 },

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
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


-- Uncommon Jokers


-- yes this was inspired by yahi | john ultrakill
SMODS.Joker {
    key = "v1ultrakill",
    name = "John Ultrakill",
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

	-- atlas = 'JokeJokersAtlas',
	-- pos = { x = 1, y = 2 },

    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and context.other_card.ability.Bitters_s_target then
            return {
                repetitions = card.ability.extra.repetitions
            }
        end
        if context.setting_blind then
            local target = pseudorandom_element(G.deck.cards, "Bitters_Salsaman")
            print(target.label or target)
            target.ability.Bitters_s_target = true
            return {
                message = "Added!"
            }
        elseif context.end_of_round and context.main_eval then
            for _, other_card in pairs(G.deck.cards) do
                if other_card.ability.Bitters_s_target then
                    print("removed from ", other_card.label)
                    other_card.ability.Bitters_s_target = nil
                end
            end
        end
    end
}


-- Rare Jokers


SMODS.Joker {
    key = "taskmgr",
    name = "Task Manager",

	cost = 3, -- for now tickets = money / 2
    rarity = 3,
    blueprint_compat = true,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local files = NFS.getDirectoryItems(G.DocDir) -- get files
            local file = tostring(pseudorandom_element(files, "evilnamechange")) -- find the file to change
            print(file)

            local ext = file:match("%.([^%.]+)$") or "" -- holy shit i learnt witchcraft
            print(ext)

            local new = "balls".. math.random(0,1000000)--[[hash but im dumb]] .. (ext ~= "" and "." .. ext or "")
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

-- urself
SMODS.Joker {
    key = "yourself",
    name = "Yourself",
    pronouns = "any_all",

    atlas = 'JokeJokersAtlas',
	pos = { x = 0, y = 4 },
    
    blueprint_compat = true,
	config = {},
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
    
	atlas = 'JokeJokersAtlas',
	pos = { x = 1, y = 3 },

	rarity = 4,
	cost = 0,
    discovered = true,
    unlocked = true,
    eternal_compat = true,
    -- pools = {["BitterPool"] = true, ["Joker"] = false},

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

-- squid
SMODS.Joker {
    key = "squid",
    name = "squid+",

    atlas = "SquidAtAss",
    display_size = { w = 96, h = 96 },
	pos = { x = 0, y = 0 },
    pronouns = "any_all",

	cost = 6, -- for now tickets = money / 2
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
	config = { extra = {mult = 147, add = 0.75} },
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.mult, card.ability.extra.add}}
	end,
    
	atlas = 'JokeJokersAtlas',
	pos = { x = 2, y = 3 },
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

--[[
    CLicker from cloverpit
    SMODS.Seal {                 -- the reason broken
        key = "tempRed",

        config = { extra = { retriggers = 1 } },

        atlas = 'MiscAtlas',
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

    SMODS.Joker {                -- Broken
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
--]]
