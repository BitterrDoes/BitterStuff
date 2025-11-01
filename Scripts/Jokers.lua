--[[
template
SMODS.Joker {
    key = "temp",

    loc_txt = {
        name = "Template",
        text = {"{X:mult,C:white}x#1#{} Mult{}"}
    },

    blueprint_compat = true,
	config = { extra = {mult = 2} },
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.mult}}
	end,
    
	atlas = 'JokeJokersAtlas',
	pos = { x = 0, y = 0 },

	rarity = 1,
	cost = 1,
    pools = {["BitterPool"] = true},

    set_badges = function(self, card, badges) -- delete if not a balala member
 		badges[#badges+1] = create_badge("Reflection", G.C.SECONDARY_SET.Planet, G.C.WHITE, 1)
 	end,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.mult
            }  
        end
    end
}

--]]



-- cold beans testing
SMODS.Joker {
    key = "sophron",

    loc_txt = {
        name = "Sophron ",
        text = {"Retrigger each {C:attention}played card{} for each card to the left of it"}
    },

    blueprint_compat = true,
	config = {extra = {mods = Bitterstuff.ModsUsing, times = 1}},
	loc_vars = function(self, info_queue, card)
		return { vars = {Bitterstuff.ModsUsing, card.ability.extra.times}}
	end,
    
	atlas = 'JokeJokersAtlas', 
	pos = { x = 4, y = 5 },

	rarity = 4,
	cost = 13,
    pools = {["BitterPool"] = true},

    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            local leftcards = 0
            for _, other_card in pairs(G.play.cards) do
                if other_card == context.other_card then
                    break
                end
                leftcards = leftcards + 1
            end
            if leftcards <= 0 then return end
            return {
                repetitions = leftcards
            }
        end
    end
}

-- ideas rightt

-- tiktok water filter, that one that makes you look like you're drowning in liquid metal right, but gives crazy mult, oh also will randomly rise, (bucket to get rid of some??)
-- The family's fighting again, X15 mult if theres a king and queen of different suits
-- all ultrakill layers

-- to be changed | make arc's text not have a pi shaped holes
-- broken-ish | nxkoo dont account for negatives
-- crashes | 

-- to be tested