SMODS.Edition { -- THIS IS ONLY MEANT FOR PIRATE SOFTWARE!! This may break other jokers
    key = "unlucky",
    shader = 'flipped',
    loc_txt = {
        name = 'Unlucky',
        label = 'Unlucky',
        text = {
            [1] = 'Makes all jokers that depend on chance half as useful.'
        }
    },


    in_shop = false,
    weight = 0,
    
    config = { divide = 2 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.edition.chips } }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            local nomral =  G.GAME.probabilities.normal
            G.GAME.probabilities.normal = nomral / 2

            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = "1",
                func = function()
                    G.GAME.probabilities.normal = nomral
                end,
            }))

        end
    end
}