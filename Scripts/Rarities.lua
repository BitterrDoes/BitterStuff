SMODS.Rarity {
    key = "reflected",
    pools = {
        ["Joker"] = true
    },
    default_weight = 0.15,
    badge_colour = HEX('00ffe8'),
    loc_txt = {
        name = "Reflected"
    },
    get_weight = function(self, weight, object_type)
        return weight
    end,
}