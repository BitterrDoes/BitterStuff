return {
    descriptions = {
        Back = {
            b_Bitters_pirateback = {
                name = "Blizzard Deck",
                text = {
                    "Starts with an",
                    "{C:enhanced,E:1}Eternal, Unlucky{}",
                    "Pirate Software", 
                    "{C:attention}win ante is #1#",
                }
            },
            b_Bitters_BitterBack = {
                name = "Bitter Deck",
                text = {
                    "Start with BitterDoes", 
                    "{C:inactive}Super Faster Scaling per new ante"
                }
            },
            b_Bitters_BrokenBack = {
                name = "Broken Deck",
                text = {
                    "Start with only five cards",
                    "{C:inactive}win ante is #1#"
                }
            },
        },
        Blind = {},
        Enhanced = {},
        Joker = {
            j_Bitters_v2goober = {
                name = "{C:red}Goober V2",
                text = {
                    "Doesn't do much, just kinda sits there",
                    "Doesn't take any slots", -- Because he cant
                },
            },
            -- Funnys
            j_Bitters_piratesoftware = {
                name = "Pirate Software",
                text = {
                    "{C:green}#1# in 2{} Chance of 'crashing' your game",
                    "Otherwise {X:mult,C:white}X#2#{} Mult"
                }
            },
            j_Bitters_yandev = { -- balanced
                name = "Yandare Dev",
                text = {
                    "Added {C:attention}playing cards{} have",
                    "everything {E:1}randomized"
                }
            },
            j_Bitters_FirstTry = { -- Balanced
                name = "Spinel",
                text = {
                    "{C:chips}+#1#{} chips", 
                    "{C:inactive,s:0.6}Suggested by FirstTry.{}"
                }
            },
            j_Bitters_jidea = { -- Comparable to riff raff
                name = "Joker Idea",
                text = {
                    "Sell this {C:attention}joker{} to", 
                    "make {C:attention}#1#{} perishable jokers",
                    "{C:inactive}(Must have space)"
                }
            },
            j_Bitters_normie = {
                name = "Normie",
                text = {
                    "{C:mult}+#1#{} Mult{} if hand played is",
                    "your highest played hand"
                }
            },
            j_Bitters_v1ultrakill = { -- Doesnt need to be balanced
                name = "John Ultrakill",
                text = {
                    "{X:chips,C:white}X#1#{} chips after parrying",
                    "Add +X#2# per parry",
                    "{C:inactive}(press f to parry)"
                },
            },
            j_Bitters_saleman = { -- Doesnt need to be balanced
                name = "Salesman",
                text = {
                    "When a {C:attention}Blind{} is selected",
                    "{E:1}target {C:attention}1{} random card",
                    "Played {E:1}targeted{} {C:attention}cards",
                    "retrigger {C:attention}3{} times"
                },
            },
            j_Bitters_english = { -- Doesnt need to be balanced
                name = "English Major",
                text = {
                    "{C:mult}+#1#{} mult if displayed word", 
                    "is typed sucessfully",
                    "Times mult by {C:mult}x#2#{} per completion",
                },
            },
            j_Bitters_taskmgr = { -- Fair Downside | Balanced
                name = "Task Manager",
                text = {
                    "{C:white,X:mult}X3{} mult per card",
                    "{E:1, C:mult}Will rename a random file ", "{E:1, C:mult}in your videos folder to 'Balls'",
                }
            },
            j_Bitters_yourself = { -- Balanced
                name = "Yourself",
                text = {
                    "+1 {X:mult,C:white}xmult{} for every 20 files in your {E:1, C:blue}downloads{}", 
                    "This number cant be below X3", 
                    "{C:inactive}(Currently {X:mult,C:white}x#1#{})"
                }
            },
            j_Bitters_goldding = { -- just a better ancient Joker??
                name = "when they touchse yo {C:attention}golden{} {C:gold}dingaling{}",
                text = {
                    "{X:blue,C:white}X#1#{} Chips and {X:mult,C:white}X#2#{} Mult",
                    "if you touched their {C:attention}#3#{}",
                    "{C:inactive}({C:attention}dingaling suit{} {C:inactive}changes every round.)"
                }
            },
            j_Bitters_BEAR5 = { -- Dont wanna fix
                name = "{B:1}BEAR5",
                text = {
                    "{X:blue,C:white}X#1#{} {V:1}Chips and {X:mult,C:white}X#2#{} {V:1}Mult",
                    "{V:1}if you touched their {C:attention}#3#{} {V:1}or any {C:attention}#4#{}",
                    "{C:inactive}({C:attention}suit{} {V:2}changes every round.)"
                }
            },
            j_Bitters_elliottsmith = { -- Is legendary
                name = "Elliot Smith",
                text = {
                    "{X:mult,C:white}x#2#{} Mult{} for each song on spotify by Elliot Smith",
                    "{C:inactive}(Currently 196 for {X:mult,C:white}x#1#{} {C:inactive}Mult)",
                    "{C:inactive,s:0.6}(Reacts in real time!)"  -- a lie btw
                }
            },
            j_Bitters_squid = { -- is legendary
                name = "{f:Bitters_ComicSans}squid+",
                text = {
                    "Copies the {C:attention}joker{} to the left and do it {C:attention}twice"
                }
            },

            -- Cool people
            j_Bitters_Jambatro = {
                name = "Jambatro",
                text = {
                    "{X:mult,C:white}x#1#{} Mult{} if base",
                    "score is odd."
                }
            },
            j_Bitters_Astro = { -- I mean its astro I cant not keep it like this
                name = "Astro",
                text = {
                    "If played hand has a scoring spade",
                    "randomize suit of all unscored cards."
                }
            },
            j_Bitters_cass = { -- oh god...
                name = "cassknows",
                text = {
                    {
                        "spawns {V:4}a{} Perishable {C:attention}Crafty Joker{}, when {V:4}a{} {C:purple}Tarot{} card is used;", 
                        "{C:green}A{C:inactive}(#1#){C:green} in B{C:inactive}(#2#){E:1} chance to spawn {V:4}a{} random {C:planet}Planet{} card",
                        "where {C:green}A{} is the number of {C:planet}Planet{} cards used and {C:green}B{} is number of {C:purple}Tarots{} used",
                        "when {V:4}a{} {C:red}non-{C:dark_edition}Negative{} {C:attention}Joker{} is {B:1}destroyed{}, create {V:4}a{} {C:attention}3 of {C:spades}Spades{}",
                        "if you have at least {C:attention}4{} different suits in hand when scoring",
                        "turn {V:4}a{} {V:1}random{} card in deck into {C:hearts}Hearts{} and make it {C:attention}Glass{}",
                        "while holding exactly {C:attention}1 {C:purple}Tarot{} card, {C:green}uncommon{} {C:attention}Jokers{} and even ranks can't be debuffed",
                        "after holding {V:4}a{} this {C:attention}Joker{} for {C:attention}5{} rounds {C:inactive}(#3#){}, create another {X:default,C:white}cassknows{} {C:attention}Joker{} and {E:2,C:red}self destruct{}", 
                        "if {C:chips}chips{} are {E:1}even{}, {E:2}divide{} them by {C:attention}2{}, {B:3}otherwise{} {C:mult}mult{}iply by {X:chips,C:white}X3{} and subtract {C:chips}-1",
                        "{V:2}selling {V:4}a{} {C:red}rare{C:attention} Joker{} has {V:4}a{} {C:green}7%{E:1} chance to create {V:4}a{} {C:dark_edition}Negative{} {C:money}Rental{} copy",
                    },
                }   
            },
            j_Bitters_Rice = { -- now a chance | balanced
                name = "Rice Shower",
                text = {
                    "{C:green}#1# in 2{} Chance to Create the last",
                    "used {C:purple}Tarot{} or {C:planet}Planet{} card after skipping",

                    "{C:inactive}(Must have room)",

                    
                    "{C:inactive,s:0.6} 'it says gullible on the ceiling'"
                }
            },
            j_Bitters_Astra = { -- Balanced enough to the point he's only 2x for me
                name = "Astra",
                text = {
                    "+1 xchips per 15 mods installed", 
                    "{C:inactive}(Currently {X:chips,C:white}X#1#{C:inactive})"
                }
            },
            j_Bitters_glitchkat = { -- balanced
                name = "GlitchKat10",
                text = {
                    "Creates 1 random {C:enhanced,T:e_polychrome}Polychrome{} consumeable at end of round", 
                    "{C:inactive}(Must have room)"
                }
            },
            j_Bitters_breeder = { -- For the funzies
                name = "Nxkoo",
                text = {
                    "Spawns #1# random {E:2,f:Bitters_ComicSans}Angled Bitterness{}", 
                    "object after beating blind"
                }
            },
            j_Bitters_lily = { -- new
                name = "Lily Felli",
                text = {
                    "{C:attention}+1{} Joker slot for",
                    "each {C:attention}9{} in deck"
                }
            },
            j_Bitters_jamirror = { -- purposely unbalanced
                name = "Jamirror",
                text = {
                    "Retrigger {C:attention}Joker{} to the left",
                    "for the next {C:attention}#1#{} rounds"
                }
            },

            -- The coolest of cools
            j_Bitters_swagless = { -- balanced
                name = "{f:Bitters_Jokerman}Swagless",
                text = {
                    "{C:attention}Unenhanced cards{} give {X:mult,C:white}X#1#{} Mult when scored",
                    "Increase by {X:mult,C:white}X0.25{} when an {C:attention}Enhanced card{} is scored"
                }
            },
            j_Bitters_arcjoker = {
                name = "{f:Bitters_papyrus}arc",
                text = {
                    "{E:1}Mult is multiplied by {E:1,f:Bitters_arial,C:attention}π{E:1} per card played.",
                    "{C:inactive}(Currently {C:mult}X#1#{C:inactive} Mult)"
                }
            },
            j_Bitters_bitterjoker = {
                name = "{f:Bitters_ComicSans}BitterDoes",
                text = {
                    "{E:1}Copies abilities of all {E:1,C:attention}jokers",
                    "{C:green}#1# in #2#{} chance to succeed"
                }
            },


            -- glop
            j_Bitters_glopless = {
                name = "{f:Bitters_Jokerman}Glopless",
                text = {
                    "{C:attention}Unenhanced cards{} give {X:green,C:white}X#1#{} Glop when scored",
                    "Increase by {X:green,C:white}X0.25{} when an {C:attention}Enhanced card{} is scored"
                }
            },
            j_Bitters_arc_glop = {
                name = "{f:Bitters_papyrus}arc",
                text = {
                    "{E:1,C:green}Glop{E:1} is multiplied by {E:1,f:Bitters_arial,C:attention}π{E:1} per card played.",
                    "{E:1}for every {E:1,C:green}1,000,000{E:1} glop add {E:1,f:Bitters_arial,X:sfark,C:white}Xπ{E:1} Sfark",
                    "{C:inactive}(Currently {C:green}+#1#{C:inactive} glop and {X:sfark,C:white}X#2#{C:inactive})"
                }
            },
            j_Bitters_glopmirror = { -- purposely unbalanced
                name = "Glopmirror",
                text = {
                    "Retrigger {C:attention}Joker{} to the left",
                    "for the next {C:attention}#1#{} rounds ",
                    "give {C:green}+0.5{} glop for every round left",
                }
            },
            j_Bitters_glopself = { -- Balanced
                name = "Glopself",
                text = {
                    "{X:green,C:white}+X1{} XGlop for every 20 files in your {E:1, C:blue}downloads{}", 
                    "This number cant be below {X:green,C:white}X3", 
                    "{C:inactive}(Currently {X:green,C:white}x#1#{})"
                }
            },
            j_Bitters_GLOP5 = { -- Dont wanna fix
                name = "{B:1}GLOP5",
                text = {
                    "{X:glop,C:white}X#1#{} {V:1}Glop and {X:chips,C:white}X#2#{} {V:1}Chips",
                    "{V:1}if you touched their {C:attention}#3#{} {V:1}or any {C:attention}#4#{}",
                    "{C:inactive}({C:attention}suit{} {V:2}changes every round.)"
                }
            },
        },
        Other = {
            Bitters_CassGlop = {
                name = "Re:potassium Crossmod",
                text = {
                    '{V:1}Spawn{} a {C:dark_edition}negative{} {C:planet}Glopur{} every {C:attention}3{} rounds {B:1,C:inactive}(#1#){}',
                }
            }
        },
        Planet = {},
        Spectral = {},
        Stake = {},
        Tag = {},
        Tarot = {

        },
        Voucher = {},
    },
    misc = {
        achievement_descriptions = {},
        achievement_names = {},
        blind_states = {},
        challenge_names = {},
        collabs = {},
        dictionary = {},
        high_scores = {},
        labels = {},
        poker_hand_descriptions = {},
        poker_hands = {},
        quips = {},
        ranks = {},
        suits_plural = {},
        suits_singular = {},
        tutorial = {},
        v_dictionary = {},
        v_text = {},
    },
}



