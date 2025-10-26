SMODS.Consumable {
    key = "brickthrow",
    set = "Tarot",

    loc_txt = {
        name = "{V:1}Brick Thrower",
        text = {"When bought, throws brick", "1 in 4 chance to make a Joker negative", "otherwise throw brick at you"}
    },
    atlas = 'consumableatlas', pos = { x = 0, y = 0 },

    config = {colours = {HEX("C14A09")}}, unlocked = true, discovered = true,

    loc_vars = function(self, info_queue, card)
        local picked_card = G.GAME.current_round.card_picker_selection or { rank = 'Ace', suit = 'Spades' }
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
        if not G.effectmanager then G.effectmanager = {} end
        G.effectmanager[1] = {
            -- requires 
            [1] = {
            --[[
                name = "",
                frame = 0,
                xpos = 0,
                ypos = 0,
                duration = 0,
            ]]
                name = "brick", -- CaSe SeNsItIvE
                frame = 1, -- no idea if it starts on frame 0 or not
                maxframe = 43,
                xpos = 0, -- position on screen ??
                ypos = 0, -- ^^^^^^
                duration = 107, -- i think in frames
                fps = 60,
                tfps = 60, -- ticks per frame per second
            }
        }
    end
}