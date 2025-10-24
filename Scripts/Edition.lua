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
    
    config = { divide = 2, nomral = 1},
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.divide, self.config.nomral} }
    end,

    calculate = function(self, card, context) -- this script fucking sucks, if someone comes across this please help me :(
        if context.pre_joker  then
            self.config.nomral =  G.GAME.probabilities.normal
            G.GAME.probabilities.normal = self.config.nomral / self.config.divide
        elseif context.post_joker then
            G.GAME.probabilities.normal = self.config.nomral
        end
    end
}