SMODS.Atlas { -- not the best practice
	key = "JokeJokersAtlas",
	path = "JokeJokers.png",
	px = 71,
	py = 95
}

SMODS.Atlas { -- not the best practice
	key = "backatlas",
	path = "Backs.png",
	px = 52,
	py = 75 -- haha wrong size
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

-- fonts
SMODS.Font({
    key = 'ComicSans',
    path = 'skeleton.ttf',
    render_scale = 200,         -- Base size in pixels (default: 200)
    TEXT_HEIGHT_SCALE = 0.83,   -- Line spacing (default: 0.83)
    TEXT_OFFSET = {x = 0, y = 2}, -- Alignment tweak (default: {0,0})
    FONTSCALE = 0.1,            -- Scale multiplier (default: 0.1)
    squish = .75,                 -- Horizontal stretch (default: 1)
    DESCSCALE = 1               -- Description scale (default: 1)
})