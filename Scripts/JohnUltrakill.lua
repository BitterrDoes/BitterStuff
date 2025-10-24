-- I felt like the length of the script for v1 was a tad bit too much, so I've decided to place it here

-- helper func to reset vars
local function resetParryVars()
    G.hasparrybeenthrown = nil
    G.hasparrytriggered = nil
    G.haltingevaluation = nil
    G.haltevaleventsent = nil
    G.parrying = nil
end

-- begin parry window func
local function beginParry()
    G.parrying = { frames = 60 }
    G.hasparrybeenthrown = true
    G.haltingevaluation = true
    G.haltevaleventsent = true
end

-- when parry hits
local function hitParry(card)
    G.hasparrytriggered = true
    G.parrying = nil
    play_sound("tarot1")
    card.ability.extra.xchips = card.ability.extra.xchips + card.ability.extra.additional
    card.ability.extra.pleasetrigger = true
    play_sound("Bitters_ParrySound")
    card_eval_status_text(card, 'extra', nil, nil, nil, { message = "PARRIED!" })
end

-- when parry misses
local function missParry(card)
    G.hasparrytriggered = true
    G.parrying = nil
    card.ability.extra.xchips = 2
    card.ability.extra.pleasetrigger = false
    play_sound("Bitters_soundForIdiots", 1, 0.5)
    card_eval_status_text(card, 'extra', nil, nil, nil, { message = "IDIOT!" })
end

-- main hook for playing cards
local old_play = G.FUNCS.play_cards_from_highlighted
G.FUNCS.play_cards_from_highlighted = function(e)
    local ret = old_play(e)
    local parry_joker = nil

    for i = 1, #G.jokers.cards do
        local c = G.jokers.cards[i]
        if c.config.center_key == "j_Bitters_v1ultrakill" and not c.debuff then
            parry_joker = c
            break
        end
    end

    if parry_joker and not G.hasparrybeenthrown then
        card_eval_status_text(parry_joker, 'extra', nil, nil, nil, { message = "PARRY!" })
        play_sound("Bitters_CoinThrow")
        beginParry()
    end

    if G.haltevaleventsent then
        G.E_MANAGER:add_event(Event({
            trigger = 'immediate',
            blockable = false,
            blocking = true,
            delay = 0.1,
            func = function()
                if not parry_joker then return true end

                if G.parrying and G.parrying.frames > 0 then
                    G.parrying.frames = G.parrying.frames - 1
                    if love.keyboard.isDown('f') then
                        hitParry(parry_joker)
                        resetParryVars()
                        return true
                    elseif G.parrying.frames <= 0 then
                        missParry(parry_joker)
                        resetParryVars()
                        return true
                    end
                    return false
                else
                    resetParryVars()
                    return true
                end
            end
        }))
    end
end

-- cleanup after play evaluation
local old_eval = G.FUNCS.evaluate_play
G.FUNCS.evaluate_play = function(e)
    old_eval(e)
    resetParryVars()
end
