-- |
-- |        people from balatro and smods server
-- |

-- Jambatro
SMODS.Joker { -- Broken?
    key = "Jambatro",
    name = "Jambatro",
    pronouns = "she_her",

    blueprint_compat = true,
	config = { extra = {xmult = 4} },
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.xmult}}
	end,
    
	atlas = 'ReflectJokers',
	pos = { x = 2, y = 0 },

	rarity = 1,
	cost = 3,
    pools = {["BitterPool"] = true},

    set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge("Reflection", G.C.SECONDARY_SET.Planet, G.C.WHITE, 1)
 	end,

    calculate = function(self, card, context)
        if context.joker_main then
            local hand = G.GAME.hands[context.scoring_name]
            if to_big(hand.chips)*to_big(hand.mult) % to_big(2) == to_big(1) then -- to big this, to big that, omg why does the total need to be big and not too big
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
    end
}
-- astro
SMODS.Joker {
    key = "Astro", -- i dont wanna get it mixed with the other 15 astros
    name = "Astro",
    pronouns = "guy_guy",

    blueprint_compat = false,
	config = { extra = {} },
	loc_vars = function(self, info_queue, card)
		return { vars = {}}
	end,
    
	atlas = 'ReflectJokers', -- made by daynan77
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

Bitterstuff.set_debuff = function(card)
    local tarots = 0
    for _, v in pairs(G.consumeables.cards) do
        if v.ability.set == 'Tarot' then
            tarots = tarots + 1
        end
    end
    if SMODS.find_card("j_Bitters_cass") and tarots == 1 and (card:is_rarity(2) or (card.base.id and card.base.id % 2 == 0)) then
        return 'prevent_debuff'
    end
end
-- cass
SMODS.Joker {
    key = "cass",
    name = "Cassknows",
    pronouns = "she_her",

    blueprint_compat = true,
	config = { extra = {round1 = 0, round2 = 0} },
	loc_vars = function(self, info_queue, card)
        if Bitterstuff.crossmodded["potassium_re"] then
            info_queue[#info_queue+1] = {
                set = "Other", 
                key = "Bitters_CassGlop", 
                vars = {
                    card.ability.extra.round2,
                    colours = { 
                        HEX("000000"),
                        HEX("FF0000"),
                        HEX("00FF00"),
                        HEX("0000FF")
                    }
                }
            }
        end
		return { 
            vars = {
                G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.tarot or 0, 
                G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.planet or 0, 
                card.ability.extra.round1, 
                card.ability.extra.round2,
                colours = { 
                    HEX("000000"),
                    HEX("FF0000"),
                    HEX("00FF00"),
                    HEX("0000FF")
                }
            },
        }
	end,
    
	atlas = 'ReflectJokers',
	pos = {x=3,y=2},

	rarity = 2,
	cost = 4,
    pools = {["BitterPool"] = true},

    set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge("Reflection", G.C.SECONDARY_SET.Planet, G.C.WHITE, 1)
 	end,

    add_to_deck = function(self, card, from_debuff)
        SMODS.add_card({
            key = "j_crafty", 
            stickers={"perishable"}, 
            force_stickers = true
        })
    end,

    calculate = function(self, card, context)
        if context.using_consumeable and context.consumeable.ability.set == "Tarot" and SMODS.pseudorandom_probability(card, "cassPlanet", G.GAME.consumeable_usage_total.tarot, G.GAME.consumeable_usage_total.planet) then
            SMODS.add_card({key = G.P_CENTER_POOLS.Planet[math.random(1,#G.P_CENTER_POOLS.Planet)]})
        elseif not context.selling_card and not context.discard and context.removed then
            for _, other_card in pairs(context.removed) do
                if other_card.ability.set == "Joker" and (not other_card.edition or other_card.edition.key ~= "e_negative") then
                    SMODS.add_card({set='Playing Card', no_edition=true, rank='3', suit='Spades'})
                end
            end
        elseif context.selling_card and context.card.ability.set == "Joker" and context.card:is_rarity(3) then
            if math.random() <= 0.07 then
                SMODS.add_card({
                    key = context.card.config.center_key,
                    stickers = {"rental"},
                    force_stickers = true,
                    edition = 'e_negative',
                })
            end
        elseif context.pre_joker and context.scoring_hand then
            local suits = {}
            for _, other_card in pairs(context.scoring_hand) do
                if not suits[other_card.base.suit] then
                    suits[other_card.base.suit] = true
                end
                print(other_card.base.suit, suits, #suits)
            end
            if --[[Im a sucker for python]] len(suits) >= 4 then
                print("Changing victim")
                local victim = G.deck.cards[math.random(1,#G.deck.cards)]

                victim:change_suit("Hearts")
                victim:set_ability('m_glass')
            end
        elseif context.joker_main then
            -- doing % 2 means if it is even it'll be 0 if not 1
            if to_big(hand_chips) % to_big(2) == to_big(0) then 
                return { xchips = 0.5 } -- single handedly makes this one of the worst jokers ever /j
            else 
                return { x_chips = 3, extra = { chips = -1 } }
            end
        elseif context.blind_defeated and context.main_eval then
            card.ability.extra.round1 = card.ability.extra.round1 + 1
            card.ability.extra.round2 = card.ability.extra.round2 + 1
            -- I need my +=
            if card.ability.extra.round1 >= 5 then
                SMODS:destroy_cards(card,true,true)
                SMODS.add_card({key = "j_Bitters_cass"})
            end
            if card.ability.extra.round1 >= 3 and Bitterstuff.crossmodded["potassium_re"] then
                SMODS.add_card({
                    key = "c_kali_glopur"
                })
            end
        end
    end
}

-- rice
SMODS.Joker {
    key = "Rice",
    name = "Rice Shower",

    blueprint_compat = true,
	config = { extra = {} },
	loc_vars = function(self, info_queue, card)
		return { vars = {G.GAME.probabilities.normal}}
	end,
    
	atlas = 'ReflectJokers', -- made by LuckyAF on displate
	pos = { x = 1, y = 0 },

	rarity = 3,
	cost = 6,
    pools = {["BitterPool"] = true},

    set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge("Reflection", G.C.SECONDARY_SET.Planet, G.C.WHITE, 1)
 	end,

    calculate = function(self, card, context)
        if context.skip_blind and SMODS.pseudorandom_probability(card, 'BitterCheck', G.GAME.probabilities.normal, 2, 'identifier') then
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

-- crabus
local function checkslop(table)
    for _, var in pairs(table) do

        if type(var) == "table" then
            return checkslop(var)
        elseif type(var) == "number" and var > 100 then
            return true
        end

        return false
    end
end


SMODS.Joker {
    key = "crabus",
    name = "Crabus",
    pronouns = "any_all",

    config = { extra = {chips = 0} },
    blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.chips}}
	end,


    rarity = 2,
    cost = 5,
    pools = {["BitterPool"] = true},

    calculate = function(self, card, context)
        if context.Bitters_press then
            if card.states.hover.is == true then

                -- check for slop
                for _, card in pairs(G.jokers.cards) do
                    local slop = checkslop(card.ability)
                    if slop then SMODS.destroy_cards(card, false, true) end
                end

                if not G.effectmanager then G.effectmanager = {} end
                G.effectmanager[1] = {{ -- Look at consumables for info on what each do
                    name = "explosion",
                    frame = 1,
                    maxframe = 17,
                    xpos = (card.T.x + ((card.T.w * card.T.scale) / 2)) * 85,
                    ypos = 0,
                    duration = 30,
                    fps = 60,
                    tfps = 60,
                },}

                card.ability.extra.chips = card.ability.extra.chips + 1
                card:juice_up()
            end
        end
    end,
}

-- Jamirror
SMODS.Joker {
    key = "jamirror",
    name = "Jamirror",
    pronouns = "he_him",

    blueprint_compat = false,
	config = { extra = 5 },
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra}}
	end,
    
	atlas = 'ReflectJokers',
	pos = { x = 3, y = 0 },
    pools = {["BitterPool"] = true},

	rarity = 2,
	cost = 16,

    set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge("Reflection", G.C.SECONDARY_SET.Planet, G.C.WHITE, 1)
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
}

-- astra
SMODS.Joker { -- fixed
    key = "Astra",
    name = "Astra",

    blueprint_compat = true,
	config = {extra = {}},
	loc_vars = function(self, info_queue, card)
		return { vars = {Bitterstuff.ModsUsing}}
	end,
    
	-- atlas = 'ReflectJokers', 
	-- pos = { x = 4, y = 5 },

	rarity = 3,
	cost = 12,
    pools = {["BitterPool"] = true},

    set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge("Reflection", G.C.SECONDARY_SET.Planet, G.C.WHITE, 1)
 	end,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xchips = Bitterstuff.ModsUsing
            }
        end
    end
}

-- glitchkat
SMODS.Joker {
    key = "glitchkat",
    name = "GlitchKat10",

    blueprint_compat = true,
	config = { extra = {cards = 1} },
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.cards}}
	end,
    
	atlas = 'ReflectJokers',
	pos = { x = 0, y = 2 },

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
    name = "Nxkoo",
    pronouns = "any_all",

    blueprint_compat = true,
	config = { extra = {cards = 1} },
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.cards}}
	end,
    
	atlas = 'ReflectJokers',
	pos = { x = 2, y = 2 },

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

-- lily
SMODS.Joker {
    key = "lily",
    name = "Lily Felli",
    pronouns = "she_her",

	atlas = 'ReflectJokers',
	pos = {x=3,y=1},
    soul_pos = {x=4, y=4},

	rarity = 3,
	cost = 9,
    blueprint_compat = false,
    pools = {["BitterPool"] = true},

    set_badges = function(self, card, badges)
 		badges[#badges+1] = create_badge("Reflection", G.C.SECONDARY_SET.Planet, G.C.WHITE, 1)
 	end,

    add_to_deck = function(self, card, from_debuff)
        local nine_tally = 0
        for _, playing_card in ipairs(G.playing_cards) do
            if playing_card:get_id() == 9 then nine_tally = nine_tally + 1 end
        end
        G.jokers:change_size(nine_tally)
    end,

    calculate = function(self, card, context)
        if context.playing_card_added then
            for i, v in pairs(context.cards) do
                if v:get_id() == 9 then
                    -- Add
                    G.jokers:change_size(1)
                end
            end
        elseif context.remove_playing_cards and context.scoring_hand then
            for i, v in pairs(context.removed) do
                if v:get_id() == 9 then
                    -- Remove
                    G.jokers:change_size(-1)
                end
            end
        end
    end
}


-- Arcadiseudf
SMODS.Joker {
    key = "arcjoker",
    name = "arc",

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

    atlas = 'ReflectJokers',
	pos = { x = 1, y = 1 },
	soul_pos = { x = 4, y = 1 },
    rarity = "Bitters_BitterRarity",
    cost = 26,
    pools = {["BitterPool"] = true, ["BitterJokers"] = true},
    -- contemplating removing from bitter pool but eh

    set_badges = function(self, card, badges)
        badges[1] = create_badge("Autism", SMODS.Gradients["ExoticGrad"], G.C.WHITE, 1)
        badges[#badges+1] = create_badge("Reflection", G.C.SECONDARY_SET.Planet, G.C.WHITE, 1)
    end,

    calculate = function(self, card, context)

        if context.joker_main then
            return { 
                mult = card.ability.extra.mult
            }
        end

        if context.individual and context.cardarea == G.play and not context.blueprint then
            card.ability.extra.mult = card.ability.extra.mult* math.pi
        end
    end
}

-- swag
SMODS.Joker {
    key = "swagless",
    atlas = 'ReflectJokers',
	pos = { x = 2, y = 1 },
	soul_pos = { x = 4, y = 2 },

    pronouns = "he_him",
    blueprint_compat = true,

	config = { extra = {xmult = 1.5} },
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.xmult}}
	end,

    rarity = "Bitters_BitterRarity",
    cost = 14,
    pools = {["BitterPool"] = true, ["BitterJokers"] = true},

    set_badges = function(self, card, badges)
        badges[1] = create_badge("Bitchless", SMODS.Gradients["ExoticGrad"], G.C.WHITE, 1)
        badges[#badges+1] = create_badge("Reflection", G.C.SECONDARY_SET.Planet, G.C.WHITE, 1)
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if not next(SMODS.get_enhancements(context.other_card)) then
                return {
                    xmult = card.ability.extra.xmult
                }  
            elseif not context.blueprint then
                card.ability.extra.xmult = card.ability.extra.xmult + 0.25
                return {
                    message = "Bitch!",
                    colour = G.C.GOLD
                }
            end
        end
	end,
}
local potSprite
SMODS.DrawStep {
    key = "SwaglessPotStep",
    order = 60,
    func = function(card, layer)
        if card and card.config.center == G.P_CENTERS["j_Bitters_swagless"] then
            local ltime = G.TIMERS.REAL + 1000

            local _xOffset = 0
            local _yOffset = 0
            local scale_mod = 0.07 + 0.02*math.sin(1.8*ltime) + 0.00*math.sin((ltime - math.floor(ltime))*math.pi*14)*(1 - (ltime - math.floor(ltime)))^3
            local rotate_mod = 0.05*math.sin(1.219*ltime) + 0.00*math.sin((ltime)*math.pi*5)*(1 - (ltime - math.floor(ltime)))^2

            potSprite = potSprite or Sprite(card.T.x, card.T.y, card.T.w, card.T.h, G.ASSET_ATLAS["Bitters_ReflectJokers"], {x=4, y=3})
                                    -- xpos, ypos, width, height, atlas, position
            potSprite.role.draw_major = card
            potSprite:draw_shader('dissolve', 1, nil, nil, card.children.center,scale_mod, rotate_mod, _xOffset, 0.1 + 0.03*math.sin(1.8*ltime) + _yOffset,nil, 0.3)
            potSprite:draw_shader('dissolve', nil, nil, nil, card.children.center, scale_mod, rotate_mod, _xOffset, _yOffset)
            -- (_shader, _shadow_height, _send, _no_tilt, other_obj, ms, mr, mx, my, custom_shader, tilt_shadow)
        end
    end,
    conditions = {vortex = false, facing = 'front'}
}

-- Bitter (THATS ME!!!)
SMODS.Joker {
    key = "bitterjoker",
    name = "BitterDoes",

    pronouns = "he_him",

    blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = {G.GAME.probabilities.normal, 2}}
	end,
    
	atlas = 'ReflectJokers',
	pos = { x = 0, y = 1 },
	soul_pos = { x = 4, y = 0 },
    pools = {["BitterPool"] = true, ["BitterJokers"] = true},

	rarity = "Bitters_BitterRarity",
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
                    if SMODS.pseudorandom_probability(card, 'BitterCheck', G.GAME.probabilities.normal, 2, 'identifier') then
                        table.insert(results, ret)
                    else
                        return {
                            message = localize('k_nope_ex')
                        }
                    end
                end
            end
        end

        return SMODS.merge_effects(results)
    end
}
