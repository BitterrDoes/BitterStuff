SMODS.Shader({ key = 'flipped', path = 'flipped.fs' })

SMODS.Edition { -- THIS IS ONLY MEANT FOR PIRATE SOFTWARE!! This may break other jokers
    key = "unlucky",
    shader = 'flipped',
    loc_txt = {
        name = 'Unlucky',
        label = 'Unlucky',
        text = {
            [1] = 'Halves luck'
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
            delay(1)
            G.GAME.probabilities.normal = nomral
        end
    end
}