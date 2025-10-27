SMODS.Rarity {
    key = "gay",
    pools = {
        ["Joker"] = true
    },
    default_weight = 0.015,
    badge_colour = SMODS.Gradient({
        key = "BitterGay",
        colours = {
            HEX("ffaaaa"),
            HEX("aaffaa"),
            HEX("aaaaff"),
        },
        cycle = 15
    }),
    loc_txt = {
        name = "Gay"
    },
    get_weight = function(self, weight, object_type)
        return weight
    end,
}

SMODS.Rarity {
    key = "autism",
    pools = {
        ["Joker"] = true
    },
    default_weight = 0.025,
    badge_colour = SMODS.Gradient({
        key = "autismgrad",
        colours = {
        HEX("283044"),
        HEX("78A1BB"),
        HEX("EBF5EE"),
        },
        cycle = 20
    }),
    loc_txt = {
        name = "autism"
    },
    get_weight = function(self, weight, object_type)
        return weight
    end,
}

SMODS.Rarity {
    key = "baddev",
    pools = {
        ["Joker"] = true
    },
    default_weight = 0.1,
    badge_colour = HEX("ff2222"),
    loc_txt = {
        name = "Bad Developer"
    },
    get_weight = function(self, weight, object_type)
        return weight
    end,
}

SMODS.Rarity {
    key = "bear5rare",
    pools = {
        ["Joker"] = false
    },
    default_weight = 0,
    badge_colour = HEX("0000FF"),
    loc_txt = {
        name = "BEAR5"
    },
    get_weight = function(self, weight, object_type)
        return weight
    end,
}