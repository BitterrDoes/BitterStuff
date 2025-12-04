--[[

-- Funnies.lua

    -- night guard
    local function AiCheck(char, state, c) -- char = b / c | state = related door state
    if c.debuff then return end
    if not char or not state then print("couldnt find char or state", char, state) return false end

    if math.random(1, 20) >= char.ai then

    -- randomly change ai level
        local rnd = math.random(1,4) - 2
        if rnd == 2 then rnd = 0 end -- 1 = down | 2 or 4 = same | 3 = up
        char.ai = char.ai + rnd
        if char.ai > 18 then char.ai = 18 end

    -- force remove if door
        print("aaaaaaaaaaa", state)
        if char.steps == 4 and state == "D" and math.random(1, 20) >= char.ai  then
            -- leave office
            char.steps = -1 -- maunhbhuhvb
        end

        -- Actual Moving
        if math.random(1,4) ~= 1 then
            -- move forward
            char.steps = char.steps + 1
            if char.steps >= 5 then
                char.steps = 0
                -- "kill" player
                SMODS.debuff_card(c, true, "death")
                return true
            elseif char.steps == 4 then
                char.office = true
            end
        else
            char.steps = char.steps - 1
        end

        return true
    else
        return false
    end
end

local atlasLookup = {
    Bonnie = {x=0,y=0},
    Chica = {x=1,y=0},

    L0R0 = {x=2,y=0},

    L0RL = {x=3,y=0},
    L0RD = {x=4,y=0},

    LLR0 = {x=2,y=1},
    LDR0 = {x=5,y=0},

    LLRL = {x=3,y=1},
    LDRD = {x=0,y=1},

    LDRL = {x=1,y=1},
    LLRD = {x=1,y=4},
}

-- night Guard
SMODS.Joker {
    key = "guard",
    name = "Night Guard",
    pronouns = "he_him",

    atlas = 'JokeJokersAtlas',
	pos = { x = 2, y = 4 },
    
    blueprint_compat = true,
    config = { extra = {
        xmult = 3,
        additional = 2,
        ticks = 0
    }},
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.xmult, card.ability.extra.additional}}
	end,
    
    pools = {["BitterPool"] = true},
	rarity = 3,
    cost = 7,

    update = function(_,c) -- not using dt since im lazy
        if c.debuff then return end
    
        -- Allow only one to control
        if not G.jokers or not G.jokers.cards then return end
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i].config.center.key == "j_Bitters_guard" then
                if G.jokers.cards[i] ~= c then return end
                break
            end
        end
    
        if not G.btr_guard then
            G.btr_guard = {}
        end
        local vars = G.btr_guard
        if not G.btr_guard.control_info then
            G.btr_guard.control_info = {
                -- doors
                Q = false,
                E = false,

                -- lights
                A = false,
                D = false,

                -- cools
                lcool = 0,
                rcool = 0,
            } -- all i need to make "fnaf 1"
            -- Ill also just say that it takes 4 steps to be at the door, and 5 to kill
        end
        if not G.btr_guard.game_info then
            G.btr_guard.game_info = {
                B = {
                    steps = 0, ai = 10, office = false
                },
                C = {
                    steps = 0, ai = 7, office = false
                }, 
                L_state = "0",
                R_state = "0"
            } -- all i need to make "fnaf 1"
            -- Ill also just say that it takes 4 steps to be at the door, and 5 to kill
        end
    
        vars.ticks = (vars.ticks or 0) + 1

        if vars.ticks >= 120 then -- full of something
            vars.ticks = 0
            -- main ai shit
            local bcheck = AiCheck(vars.game_info.B, vars.game_info.L_state, c)
            local ccheck = AiCheck(vars.game_info.C, vars.game_info.R_state, c)
            print(vars.game_info)

            -- print(vars)
            -- if bcheck or ccheck then -- Ireally shouldnt use G this much but ehhhhhhhh
            --     if G.btr_guard.Sprite then
            --         G.btr_guard.Sprite:remove()
            --     end
            --     G.btr_guard.Sprite = UIBox({
            --         definition = Bitterstuff.guardUpdate(),
            --         config = {id = "Office",type = "cm", major = G.ROOM_ATTACH, bond = "Weak", instance_type = "POPUP"}
            --     })
            --     G.btr_guard.Node = {n=G.UIT.O, config={object = G.btr_guard.Sprite, type = "cm"}}
            -- end
        end

        -- Controls stuff
        local ctrl = vars.control_info
        ctrl.lcool = ctrl.lcool - 1
        ctrl.rcool = ctrl.rcool - 1
            -- left
        if love.keyboard.isDown('q') and ctrl.lcool <= 0 then
            ctrl.lcool = 10
            ctrl.Q = not ctrl.Q
            ctrl.A = false
            vars.game_info.L_state = ctrl.Q and "D" or "0"
        elseif love.keyboard.isDown('a') and ctrl.lcool <= 0 then
            ctrl.lcool = 10
            ctrl.A = not ctrl.A
            ctrl.Q = false
            vars.game_info.L_state = ctrl.A and "L" or "0"
        end
            -- right
        if love.keyboard.isDown('e') and ctrl.rcool <= 0 then
            ctrl.rcool = 10
            ctrl.E = not ctrl.E
            ctrl.D = false
            vars.game_info.R_state = ctrl.E and "D" or "None"
        elseif love.keyboard.isDown('d') and ctrl.rcool <= 0 then
            ctrl.rcool = 10
            ctrl.D = not ctrl.D
            ctrl.E = false
            vars.game_info.R_state = ctrl.D and "L" or "None"
        end

        -- Bitterstuff.guardUpdate()
        -- Update ui
        if G.btr_guard.node then
            G.btr_guard.node:remove()
        end

        G.btr_guard.node = UIBox({
            definition = Bitterstuff.guardUpdate(),
            config = {type = "br", major = G.ROOM_ATTACH, offset = {x=1,y=0.9}, bond = "Weak", instance_type = "POPUP"}
        })
        local Uinode = {n=G.UIT.O, config={object = G.btr_guard.node, type = "br"}}

        -- Continue this tmr, I needa make the ui actually better | if requires atlas, use a lookup table 👍👍👍👍
        -- possibly just sprite?
    end,
    
    calculate = function(self, card, context) -- what a normie joker, oh wait all the code is gonna be external
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}








]]