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
            -- bad developers
            j_Bitters_piratesoftware = {
                name = "Pirate Software",
                text = {
                    "{C:green}#1# in 2{} Chance of 'crashing' your game",
                    "Otherwise {X:mult,C:white}+#2#{} Mult"
                }
            },
            j_Bitters_yandev = {
                name = "Yandare Dev",
                text = {
                    "Added {C:attention}playing cards{} have everything {E:1}randomized"
                }
            },

            -- Funnys
            j_Bitters_FirstTry = {
                name = "Spinel",
                text = {
                    "{C:mult}+#1#{} Mult", 
                    "{C:inactive,s:0.6}Suggested by FirstTry.{}"
                }
            },
            j_Bitters_normie = {
                name = "Normie",
                text = {
                    "{X:mult,C:white}+#1#{} Mult{}"
                }
            },
            j_Bitters_v1ultrakill = {
                name = "John Ultrakill",
                text = {
                    "{X:chips,C:white}X#1#{} chips after parrying",
                    "Add +X#2# per parry",
                    "{C:inactive}(press f to parry)"
                },
            },
            j_Bitters_goldding = {
                name = "when they touchse yo {C:attention}golden{} {C:gold}dingaling{}",
                text = {
                    "{X:blue,C:white}X#1#{} Chips and {X:mult,C:white}X#2#{} Mult",
                    "if you touched their {C:attention}#3#{}",
                    "{C:inactive}({C:attention}dingaling suit{} {C:inactive}changes every round.)"
                }
            },
            j_Bitters_BEAR5 = {
                name = "{B:1}BEAR5",
                text = {
                    "{X:blue,C:white}X#1#{} {V:1}Chips and {X:mult,C:white}X#2#{} {V:1}Mult",
                    "{V:1}if you touched their {C:attention}#3#{} {V:1}or any {C:attention}#4#{}",
                    "{C:inactive}({C:attention}dingaling suit{} {V:2}changes every round.)"
                }
            },
            j_Bitters_elliottsmith = {
                name = "Elliot Smith",
                text = {
                    "{X:mult,C:white}x#2#{} Mult{} for each song on spotify by Elliot Smith",
                    "{C:inactive}(Currently 196 for {X:mult,C:white}x#1#{} {C:inactive}Mult)",
                    "{C:inactive,s:0.6}(Reacts in real time!)"  -- a lie btw
                }
            },
            j_Bitters_yourself = {
                name = "Yourself",
                text = {
                    "+1 {X:mult,C:white}xmult{} for every 20 files in your {E:1, C:blue}downloads{}", 
                    "This number cant be below X3", 
                    "{C:inactive}(Currently {X:mult,C:white}x#1#{})"
                }
            },
            j_Bitters_taskmgr = {
                name = "Task Manager",
                text = {
                    "{C:white,X:mult}X3{} mult per card",
                    "{E:1, C:mult}Will rename a random file ", "{E:1, C:mult}in your videos folder to 'Balls'",
                }
            },
            j_Bitters_squid = {
                name = "{f:Bitters_ComicSans}squid+",
                text = {
                    "Copies the {C:attention}joker{} to the left and do it {C:attention}twice"
                }
            },

            -- Cool people
            j_Bitters_Jambatro = {
                name = "Jambatro",
                text = {
                    "{X:mult,C:white}x#1#{} Mult{} if base score is divisible by #2#."
                }
            },
            j_Bitters_Astro = {
                name = "Astro",
                text = {
                    "If played hand has a scoring spade",
                    "randomize suit of all unscored cards."
                }
            },
            j_Bitters_Ekko = {
                name = "Ekko",
                text = {
                    "Creates the last used Tarot or Planet card",
                    "after skipping a blind",
                    "{C:inactive}(Must have room)",
                    "{C:inactive,s:0.6} 'it says gullible on the ceiling'"
                }
            },
            j_Bitters_Astra = {
                name = "Astra",
                text = {
                    "+1 xchips per 15 mods installed", 
                    "{C:inactive}(Currently {X:chips,C:white}X#1#{C:inactive})"
                }
            },
            j_Bitters_glitchkat = {
                name = "GlitchKat10",
                text = {
                    "Create #1# random {C:enhanced,T:e_polychrome}Polychrome{} consumeables at end of round", 
                    "{C:inactive}(Must have room)"
                }
            },
            j_Bitters_breeder = {
                name = "Nxkoo",
                text = {
                    "Spawns #1# random {E:2,f:Bitters_ComicSans}Angled Bitterness{}", "object after beating blind"
                }
            },
            j_Bitters_jamirror = {
                name = "Jamirror",
                text = {
                    "{C:green}#1# in #3#{} to add 1 operation (^) to mult after beating boss blind",
                    "{C:inactive}(Currently {X:mult,C:white}#2#{}){}"
                }
            },

            -- The coolest of cools
            j_Bitters_bitterjoker = {
                name = "{f:Bitters_ComicSans}BitterDoes",
                text = {
                    "{E:1}Copies abilities of all {E:1,C:attention}jokers",
                    "{C:green}1 in 4{} chance to succeed"
                }
            },
            j_Bitters_arcjoker = {
                name = "{f:Bitters_papyrus}arc",
                text = {
                    "{E:1}Mult is multiplied by {E:1,C:attention}π{E:1} per card played.",
                    "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)"
                }
            }

        },
        Other = {},
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



