-- ctrl-k + ctrl-0 to collapse all


-- bear5check
Bitterstuff.bear5check = function(card) -- taken from joker forge dont @ me
    G.E_MANAGER:add_event(Event({
        trigger = "after",
        delay = 0.85,
        func = function()
            if (function()
                    for i = 1, #G.jokers.cards do
                        if G.jokers.cards[i].config.center.key == "j_tngt_dingaling" then
                            G.jokers.cards[i]:remove()
                            return true
                        end
                    end
                return false 
            end)() then
                card:remove()
                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.add_card({key = "j_Bitters_BEAR5"})
                        return true
                    end
                }))
            end
            return true
        end
    }))
end

-- get highest played hand
Bitterstuff.Highesthand = function()
    local _handname, _played = 'High Card', -1
    for hand_key, hand in pairs(G.GAME.hands) do
        if hand.played > _played then
            _played = hand.played
            _handname = hand_key
        end
    end
    return _handname
end



-- ##
-- ##
--          QTE RELATED
-- ##
-- ##

function G.QTE_ResetVars(joker) -- Joker is string of name
    G["vars_"..joker] = {}
end

local function setQTE(joker, information)
    for i in pairs(information) do
        G["vars_"..joker][information[i].name] = information[i].info
    end
end

-- John Ultrakill

    local function hitParry(card)
        G.vars_j_Bitters_v1ultrakill.hasparrytriggered = true
        G.vars_j_Bitters_v1ultrakill.parrying = nil
        card.ability.extra.xchips = card.ability.extra.xchips + card.ability.extra.additional
        card.ability.extra.pleasetrigger = true
        play_sound("Bitters_ParrySound")
        card_eval_status_text(card, 'extra', nil, nil, nil, { message = "PARRIED!" })
    end

    -- when parry misses
    local function missParry(card)
        G.vars_j_Bitters_v1ultrakill.hasparrytriggered = true
        G.vars_j_Bitters_v1ultrakill.parrying = nil
        card.ability.extra.xchips = 2
        card.ability.extra.pleasetrigger = false
        play_sound("Bitters_soundForIdiots", 1, 0.5)
        card_eval_status_text(card, 'extra', nil, nil, nil, { message = "IDIOT!" })
    end

-- set up table for all qte jokers
local qtejokers = {
    "j_Bitters_v1ultrakill",
    "j_Bitters_english"
}

-- engMaj

    function createMajorMenu(textNodes) -- example {      { n = G.UIT.T, config = {align= "cm", text = menu_name,0,#menu_name, colour = G.C.GREEN, scale = 0.75 } },      }
        return {n = G.UIT.C, config = {align = "cm", minw=3, minh=1, colour = HEX("00000088"), padding = 0.15, r = 0.02}, nodes = {
        -- Use a Row node to arrange the contents in rows:
            {n=G.UIT.R, config={align = "cm"}, nodes=textNodes}
        }}
    end
    function createTimer(time) -- example {      { n = G.UIT.T, config = {align= "cm", text = menu_name,0,#menu_name, colour = G.C.GREEN, scale = 0.75 } },      }
        return {n = G.UIT.C, config = {align = "cm", minw=3, minh=1, colour = HEX("00000088"), padding = 0.15, r = 0.02}, nodes = {
        -- Use a Row node to arrange the contents in rows:
            {n=G.UIT.R, config={align = "cm"}, nodes={      
                { n = G.UIT.T, config = {align= "cm", text = time, colour = G.C.GREEN, scale = 0.75 }},      
            }}
        }}
    end

-- ##
-- ##
-- Hooks
-- ##
-- ##

-- main hook for qte's
local old_play = G.FUNCS.play_cards_from_highlighted
G.FUNCS.play_cards_from_highlighted = function(e)
    local ret = old_play(e)

    for i, v in pairs(qtejokers) do
        if not G["vars_"..v] then
            G["vars_"..v] = {}
        end
    end
    
    if G.GAME.blind and G.GAME.blind.config.blind.key == "bl_Bitters_wordblind" then
        local c = G.GAME.blind
        local vars = G.vars_j_Bitters_english
        local random = math.random(1,#G.Bitters_words)
        local word = G.Bitters_words[random]
        local completed = ""
        local points = 0

        local my_menu = UIBox({
            definition = createMajorMenu({
                { n = G.UIT.T, config = {align= "cm", text = string.sub(word, 1, 1), colour = G.C.WHITE, scale = 0.75 } },
                { n = G.UIT.T, config = {align= "cm", text = string.sub(word, #completed+2, #word), colour = G.C.UI.TEXT_INACTIVE, scale = 0.75 } },
            }),
            config = {id = "btr_enMajText",type = "cm", major = c, bond = "Weak", instance_type = "POPUP"}
        })
        local my_menu_node = {n=G.UIT.O, config={object = my_menu, type = "cm"}}

        if c and not vars.qteBegun then
            -- card_eval_status_text(c, 'extra', nil, nil, nil, { message = "PARRY!" })
            setQTE("j_Bitters_english", {
                {name = "typing", info = {frames = 500}},
                {name = "qteBegun", info = true},
                {name = "haltingevaluation", info = true},
                {name = "haltevaleventsent", info = true},
            })
        end
        local Timer = UIBox({
            definition = createTimer(vars.typing.frames),
            config = {type = "tm", major = c, offset = {x=0,y=0.5}, bond = "Weak", instance_type = "POPUP"}
        })
        local Timernode = {n=G.UIT.O, config={object = Timer, type = "cm"}}

        if vars.haltevaleventsent then
            G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                blockable = false,
                blocking = true,
                delay = 0.1,
                func = function()
                    if not c then
                        G.QTE_ResetVars("j_Bitters_english")
                        my_menu:remove()
                        Timer:remove()
                        return true
                    end


                    if vars.typing and vars.typing.frames > 0 then

                        vars.typing.frames = vars.typing.frames - 1

                        Timer:remove()
                        Timer = UIBox({
                            definition = createTimer(vars.typing.frames),
                            config = {type = "tm", major = c, offset = {x=0,y=0.5}, bond = "Weak", instance_type = "POPUP"}
                        })
                        Timernode = {n=G.UIT.O, config={object = Timer, type = "tm"}}

                        local letter = string.sub(word,#completed+1,#completed+1)

                        if completed == word then
                            -- hitParry(c)
                            G.QTE_ResetVars("j_Bitters_english")
                            play_sound("Bitters_ParrySound")
                            c.ability.extra.mult = c.ability.extra.mult * c.ability.extra.additional
                            c.ability.extra.pleasetrigger = true
                            card_eval_status_text(c, 'extra', nil, nil, nil, { message = "Swag!" })
                            my_menu:remove()
                            Timer:remove()
                            return true
                        end

                        if love.keyboard.isDown(letter) then
                            -- set completed
                            completed = completed.. letter
                            -- reward
                            points = #completed

                            -- update text
                            my_menu:remove()
                            my_menu = UIBox({
                                definition = createMajorMenu({
                                    { n = G.UIT.T, config = {align= "cm", text = string.sub(word, 0, #completed), colour = G.C.UI.TEXT_INACTIVE, scale = 0.75 } },
                                    { n = G.UIT.T, config = {align= "cm", text = string.sub(word, #completed+1, #completed+1), colour = G.C.WHITE, scale = 0.75 } },
                                    { n = G.UIT.T, config = {align= "cm", text = string.sub(word, #completed+2, #word), colour = G.C.UI.TEXT_INACTIVE, scale = 0.75 } },
                                }),
                                config = {id = "btr_enMajText",type = "cm", major = c, bond = "Weak", instance_type = "POPUP"}
                            })
                            local my_menu_node = {n=G.UIT.O, config={object = my_menu, type = "cm"}}
                        elseif vars.typing.frames <= 0 then
                            -- ran out of time
                            points = 0
                            -- missParry(c)
                            G.QTE_ResetVars("j_Bitters_english")
                            c.ability.extra.pleasetrigger = false
                            c.ability.extra.mult = 2
                            play_sound("Bitters_soundForIdiots")
                            
                            my_menu:remove()
                            Timer:remove()
                            return true
                        end
                        
                        return false
                    else
                        -- fail safe
                        G.QTE_ResetVars("j_Bitters_english")
                        my_menu:remove()
                        Timer:remove()
                        return true
                    end
                end
            }))
        end    
    end
 
    for i = 1, #G.jokers.cards do
        local c = G.jokers.cards[i]
        local key = c.config.center_key
        if c.debuff then goto Ending end

        if key == "j_Bitters_v1ultrakill" then
            local vars = G.vars_j_Bitters_v1ultrakill

            if c and not vars.hasparrybeenthrown then
                card_eval_status_text(c, 'extra', nil, nil, nil, { message = "PARRY!" })
                play_sound("Bitters_CoinThrow")
                -- beginParry()
                setQTE("j_Bitters_v1ultrakill", {
                    {name = "parrying", info = {frames = 60}},
                    {name = "hasparrybeenthrown", info = true},
                    {name = "haltingevaluation", info = true},
                    {name = "haltevaleventsent", info = true},
                })
            end

            if vars.haltevaleventsent then
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    blockable = false,
                    blocking = true,
                    delay = 0.1,
                    func = function()
                        if not c then return true end

                        if vars.parrying and vars.parrying.frames > 0 then
                            vars.parrying.frames = vars.parrying.frames - 1
                            if love.keyboard.isDown('f') then
                                hitParry(c)
                                -- resetParryVars()
                                G.QTE_ResetVars("j_Bitters_v1ultrakill")
                                vars.haltevaleventsent = true
                                return true
                            elseif vars.parrying.frames <= 0 then
                                missParry(c)
                                -- resetParryVars()
                                G.QTE_ResetVars("j_Bitters_v1ultrakill")
                                return true
                            end
                            return false
                        else
                            -- resetParryVars()
                            G.QTE_ResetVars("j_Bitters_v1ultrakill")
                            return true
                        end
                    end
                }))
            end
        elseif key == "j_Bitters_english" then
            local vars = G.vars_j_Bitters_english
            local random = math.random(1,#G.Bitters_words)
            local word = G.Bitters_words[random]
            local completed = ""
            local points = 0

            local my_menu = UIBox({
                definition = createMajorMenu({
                    { n = G.UIT.T, config = {align= "cm", text = string.sub(word, 1, 1), colour = G.C.WHITE, scale = 0.75 } },
                    { n = G.UIT.T, config = {align= "cm", text = string.sub(word, #completed+2, #word), colour = G.C.UI.TEXT_INACTIVE, scale = 0.75 } },
                }),
                config = {id = "btr_enMajText",type = "cm", major = c, bond = "Weak", instance_type = "POPUP"}
            })
            local my_menu_node = {n=G.UIT.O, config={object = my_menu, type = "cm"}}

            if c and not vars.qteBegun then
                -- card_eval_status_text(c, 'extra', nil, nil, nil, { message = "PARRY!" })
                setQTE("j_Bitters_english", {
                    {name = "typing", info = {frames = 300}},
                    {name = "qteBegun", info = true},
                    {name = "haltingevaluation", info = true},
                    {name = "haltevaleventsent", info = true},
                })
            end
            local Timer = UIBox({
                definition = createTimer(vars.typing.frames),
                config = {type = "tm", major = c, offset = {x=0,y=0.5}, bond = "Weak", instance_type = "POPUP"}
            })
            local Timernode = {n=G.UIT.O, config={object = Timer, type = "cm"}}

            if vars.haltevaleventsent then
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    blockable = false,
                    blocking = true,
                    delay = 0.1,
                    func = function()
                        if not c then
                            G.QTE_ResetVars("j_Bitters_english")
                            my_menu:remove()
                            Timer:remove()
                            return true
                        end


                        if vars.typing and vars.typing.frames > 0 then

                            vars.typing.frames = vars.typing.frames - 1

                            Timer:remove()
                            Timer = UIBox({
                                definition = createTimer(vars.typing.frames),
                                config = {type = "tm", major = c, offset = {x=0,y=0.5}, bond = "Weak", instance_type = "POPUP"}
                            })
                            Timernode = {n=G.UIT.O, config={object = Timer, type = "tm"}}

                            local letter = string.sub(word,#completed+1,#completed+1)

                            if completed == word then
                                -- hitParry(c)
                                G.QTE_ResetVars("j_Bitters_english")
                                play_sound("Bitters_ParrySound")
                                c.ability.extra.mult = c.ability.extra.mult * c.ability.extra.additional
                                c.ability.extra.pleasetrigger = true
                                card_eval_status_text(c, 'extra', nil, nil, nil, { message = "Swag!" })
                                my_menu:remove()
                                Timer:remove()
                                return true
                            end

                            if love.keyboard.isDown(letter) then
                                -- set completed
                                completed = completed.. letter
                                -- reward
                                points = #completed

                                -- update text
                                my_menu:remove()
                                my_menu = UIBox({
                                    definition = createMajorMenu({
                                        { n = G.UIT.T, config = {align= "cm", text = string.sub(word, 0, #completed), colour = G.C.UI.TEXT_INACTIVE, scale = 0.75 } },
                                        { n = G.UIT.T, config = {align= "cm", text = string.sub(word, #completed+1, #completed+1), colour = G.C.WHITE, scale = 0.75 } },
                                        { n = G.UIT.T, config = {align= "cm", text = string.sub(word, #completed+2, #word), colour = G.C.UI.TEXT_INACTIVE, scale = 0.75 } },
                                    }),
                                    config = {id = "btr_enMajText",type = "cm", major = c, bond = "Weak", instance_type = "POPUP"}
                                })
                                local my_menu_node = {n=G.UIT.O, config={object = my_menu, type = "cm"}}
                            elseif vars.typing.frames <= 0 then
                                -- ran out of time
                                points = 0
                                -- missParry(c)
                                G.QTE_ResetVars("j_Bitters_english")
                                c.ability.extra.pleasetrigger = false
                                c.ability.extra.mult = 2
                                play_sound("Bitters_soundForIdiots")
                                
                                my_menu:remove()
                                Timer:remove()
                                return true
                            end
                            
                            return false
                        else
                            -- fail safe
                            G.QTE_ResetVars("j_Bitters_english")
                            my_menu:remove()
                            Timer:remove()
                            return true
                        end
                    end
                }))
            end    
        end

        ::Ending::
    end
end

-- cleanup after play evaluation
local old_eval = G.FUNCS.evaluate_play
G.FUNCS.evaluate_play = function(e)
    old_eval(e)
    -- resetParryVars()
    G.QTE_ResetVars("j_Bitters_v1ultrakill")
end