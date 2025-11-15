SMODS.Atlas {
	key = "JokeJokersAtlas",
	path = "JokeJokers.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "backatlas",
	path = "Backs.png",
	px = 71,
	py = 95
}

-- SMODS.Atlas {
-- 	key = "voucherAtlas",
-- 	path = "Vouchers.png",
-- 	px = 71,
-- 	py = 95
-- }

SMODS.Atlas {
	key = "consumableatlas",
	path = "Consumables.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "tempsealAtlas",
	path = "tempseals.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "brickatlas",
	path = "Brick.png",
	px = 300,
	py = 300
}

-- Icon!
SMODS.Atlas {
    key = "modicon",
    path = "icon.png",
    px = 250,
    py = 250,
    frames = 28,
    atlas_table = 'ANIMATION_ATLAS'
}

-- sounds
-- coin
SMODS.Sound {
	key = "CoinThrow",
	path = "coin.mp3",
}
-- parry
SMODS.Sound {
	key = "ParrySound",
	path = "parry.mp3",
}
-- idiot
SMODS.Sound {
	key = "soundForIdiots",
	path = "WRONG.mp3",
}
-- AAAUH
SMODS.Sound {
	key = "bear5scream",
	path = "bear5.mp3",
}
SMODS.Sound {
	key = "Fullbear5",
	path = "fullbear5.mp3",
}
-- lego krkvkkrvkr
SMODS.Sound {
	key = "legobreaksound",
	path = "legobrick.mp3",
}

-- fonts
SMODS.Font({
    key = 'ComicSans',
    path = 'skeleton.ttf',
    render_scale = 200,         -- Base size in pixels (default: 200)
    TEXT_HEIGHT_SCALE = 0.83,   -- Line spacing (default: 0.83)
    TEXT_OFFSET = {x = 0, y = 15}, -- Alignment tweak (default: {0,0})
    FONTSCALE = 0.1,           	 -- Scale multiplier (default: 0.1)
    squish = .75,                 -- Horizontal stretch (default: 1)
    DESCSCALE = 1               -- Description scale (default: 1)
})

SMODS.Font({
    key = 'papyrus',
    path = 'papyrus.ttf',
    render_scale = 200,         -- Base size in pixels (default: 200)
    TEXT_HEIGHT_SCALE = 0.83,   -- Line spacing (default: 0.83)
    TEXT_OFFSET = {x = 0, y = 0}, -- Alignment tweak (default: {0,0})
    FONTSCALE = 0.1,           	 -- Scale multiplier (default: 0.1)
    squish = 1,                 -- Horizontal stretch (default: 1)
    DESCSCALE = 1               -- Description scale (default: 1)
})

SMODS.Font({
    key = 'Jokerman',
    path = 'Jokerman.otf',
    render_scale = 200,         -- Base size in pixels (default: 200)
    TEXT_HEIGHT_SCALE = 0.83,   -- Line spacing (default: 0.83)
    TEXT_OFFSET = {x = 0, y = 0}, -- Alignment tweak (default: {0,0})
    FONTSCALE = 0.1,           	 -- Scale multiplier (default: 0.1)
    squish = 1,                 -- Horizontal stretch (default: 1)
    DESCSCALE = 1               -- Description scale (default: 1)
})

-- objectTypes
SMODS.ObjectType {
	key = "BitterPool",
	default = "j_Bitters_bitterjoker"
}

-- Gradients
SMODS.Gradient({
        key = "ExoticGrad",
        colours = {
        HEX("42f5cb"),
        HEX("42adf5"),
        HEX("424dfc"),
        },
        cycle = 10
})