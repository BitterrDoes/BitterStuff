-- SMODS.Rarity {
--     key = "gay",
--     pools = {
--         ["Joker"] = true
--     },
--     default_weight = 0.005,
--     badge_colour = SMODS.Gradient({
--         key = "BitterGay",
--         colours = {
--             HEX("ffaaaa"),
--             HEX("aaffaa"),
--             HEX("aaaaff"),
--         },
--         cycle = 15
--     }),
--     loc_txt = {
--         name = "Gay"
--     },
--     get_weight = function(self, weight, object_type)
--         return weight
--     end,
-- }

-- SMODS.Rarity {
--     key = "autism",
--     pools = {
--         ["Joker"] = true
--     },
--     default_weight = 0.005,
--     badge_colour = SMODS.Gradient({
--         key = "autismgrad",
--         colours = {
--         HEX("283044"),
--         HEX("78A1BB"),
--         HEX("EBF5EE"),
--         },
--         cycle = 20
--     }),
--     loc_txt = {
--         name = "autism"
--     },
--     get_weight = function(self, weight, object_type)
--         return weight
--     end,
-- }

SMODS.Rarity {
    key = "Bitters_BitterRarity",
    pools = {
        ["Joker"] = false
    },
    default_weight = 0.005,
    badge_colour = SMODS.Gradients["ExoticGrad"],
    loc_txt = {
        name = "BitterExotic"
    },
    get_weight = function(self, weight, object_type)
        return weight
    end,
}