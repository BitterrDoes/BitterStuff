SMODS.Consumable {
    key = "brickthrow",
    set = "Tarot",

    loc_txt = {
        name = "{V:1}Guy with brick",
        text = {"When bought, throws brick", "1 in 4 chance to make a Joker negative", "otherwise throw brick at you"}
    },
    atlas = 'consumableatlas', pos = { x = 0, y = 0 },

    config = {
        extra = {Chance = 4},
        colours = {HEX("C14A09")}
    },
    unlocked = true, discovered = true,

    loc_vars = function(self, info_queue, card)
		return { 
            vars = {
                colours = { HEX("C14A09"), HEX("2424b3") }
            }
        }
    end,

    cost = 3,
    pools = {["Bitter"] = true},

    can_use = function(self, card)
        if #G.jokers.cards > 0 then -- cuz if its 0 even if theres a negative we dont wanna check it
            return true
        end
        return false
    end,

    use = function(self, card, area)
        if SMODS.pseudorandom_probability(card, 'BrickThrower', G.GAME.probabilities.normal, card.ability.extra.Chance, 'identifier') then
            G.jokers.cards[math.ceil(pseudorandom("bricks") * #G.jokers.cards)]:set_edition("e_negative")
        else
            if not G.effectmanager then G.effectmanager = {} end
            G.effectmanager[1] = {
            -- requires 
                [1] = {
                    name = "brick", -- CaSe SeNsItIvE
                    frame = 1, -- no idea if it starts on frame 0 or not
                    maxframe = 43,
                    xpos = 480, -- position on screen ??
                    ypos = 120, -- ^^^^^^
                    duration = 80, -- i dont know how works, just keep trying
                    fps = 60,
                    tfps = 60, -- ticks per frame per second
                },
            }
            play_sound("Bitters_legobreaksound")
        end
    end
}

local presLookup = {
    {
        message = "+1 hand",
        colour = G.C.BLUE,
        variable = "next_hands",
        change = 1
    },
    {
        message = "+1 discard",
        colour = G.C.RED,
        variable = "discards",
        change = 1
    },
    {
        message = "+5 dollars",
        colour = G.C.MONEY,
        variable = "dollars",
        change = 5
    },
}

SMODS.Consumable {
    key = "present",
    set = "Tarot",

    loc_txt = {
        name = "Present",
        text = {
            "gives you a random {C:blue}buff{}",
            "for the {C:attention}next{} round"
        }
    },
    atlas = 'consumableatlas', pos = { x = 1, y = 0 },

    config = {
        extra = false,
    },
    unlocked = true, discovered = true,
    cost = 3,
    pools = {["Bitter"] = true},

    can_use = function(self, card)
        if not G.GAME.playing then
            return true
        end
        return false
    end,

    add_to_deck = function(self, card, from_debuff)
        -- yay more stolen code from dna
        local eval = function() return not G.GAME.playing end
        juice_card_until(card, eval, true)
    end,

    use = function(self, card, area)
        local choice = presLookup[math.random(1,#presLookup)]
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                attention_text({
                    text = choice.message,
                    scale = 1.3,
                    hold = 1.4,
                    major = card,
                    backdrop_colour = choice.colour,
                    align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and
                        'tm' or 'cm',
                    offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0 },
                    silent = true
                })
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.06 * G.SETTINGS.GAMESPEED,
                    blockable = false,
                    blocking = false,
                    func = function()
                        play_sound('tarot2', 0.76, 0.4)
                        G.GAME.round_bonus[choice.variable] = G.GAME.round_bonus[choice.variable] + choice.change
                        return true
                    end
                }))
                play_sound('tarot2', 1, 0.4)
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
    end,

    calculate = function(self, card, context)
        if context.blind_defeated and context.main_eval then
            local eval = function() return not G.GAME.playing end
            juice_card_until(card, eval, true)
        end
    end
}

SMODS.Consumable {
    key = 'meow',
    set = 'Spectral',
    pos = { x = 2, y = 2 },

    hidden = true,
    soul_set = 'Tarot',
    soul_rate = 0.001,

    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                SMODS.add_card({ set = 'BitterJokers', allow_duplicates = true })
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        delay(0.6)
    end,
    can_use = function(self, card)
        return G.jokers and #G.jokers.cards < G.jokers.config.card_limit
    end,
    draw = function(self, card, layer)
        -- This is for the Spectral shader. You don't need this with `set = "Spectral"`
        -- Also look into SMODS.DrawStep if you make multiple cards that need the same shader
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end
}

local oldmainmenu = Game.main_menu
function Game:main_menu(change_context)
    local g = oldmainmenu(self, change_context)
    G.shart_soul = Sprite(0, 0, 71, 95, G.ASSET_ATLAS["Bitters_cat"], {x = 0, y = 0})
    return g
end
-- yes the hook is here, no im not gonna put it in hooks.lua

SMODS.DrawStep { -- oh god, bitter create ur own G.shared_soul dont just copy it, - bitter
    key = 'Bitters_meow',
    order = 50,
    func = function(card)
        if card.config.center.key == "c_Bitters_meow" and (card.config.center.discovered or card.bypass_discovery_center) and G.shart_soul then
            local scale_mod = 0.05 + 0.05 * math.sin(1.8 * G.TIMERS.REAL) +
                0.07 * math.sin((G.TIMERS.REAL - math.floor(G.TIMERS.REAL)) * math.pi * 14) *
                (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 3
            local rotate_mod = 0.1 * math.sin(1.219 * G.TIMERS.REAL) +
                0.07 * math.sin((G.TIMERS.REAL) * math.pi * 5) * (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 2

            G.shart_soul.role.draw_major = card
            G.shart_soul:draw_shader('dissolve', 0, nil, nil, card.children.center, scale_mod, rotate_mod, nil,
                0.1 + 0.03 * math.sin(1.8 * G.TIMERS.REAL), nil, 0.6)
            G.shart_soul:draw_shader('dissolve', nil, nil, nil, card.children.center, scale_mod, rotate_mod)
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}