return{
	descriptions={
		Joker={
			j_plt_planetarium={
				name="Planetarium",
				text={
					"This Joker gains",
					"{C:chips}+#1#{} Chips every time",
					"a {C:planet}Planet{} card is used",
					"{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)"
				}
			},
			j_plt_horoscope={
				name="Horoscope Reader",
				text={
					"{C:red}+#1#{} Mult per {C:planet}Planet{}",
					"card used this run",
					"{C:inactive}(Currently {C:red}+#2#{C:inactive})"
				}
			},
			j_plt_dying={
				name="Dying Star",
				text={
					"After {C:attention}#1#{} rounds,",
					"sell this card to {C:attention}Create{}",
					"a random {X:planet,C:white}Celestial{} {C:attention}Joker{}",
					"{C:inactive}(Currently {C:attention}#2#{C:inactive}/#1#)"
				}
			},
			j_plt_rotting={
				name="Rotting Start",
				text={
					"After {C:attention}#1#{} rounds,",
					"sell this card to {C:attention}Create{}",
					"a random {X:Legendary,C:white}Legendary {X:planet,C:white}Celestial{} {C:attention}Joker{}",
					"{C:inactive}(Currently {C:attention}#2#{C:inactive}/#1#)"
				}
			},
			j_plt_hypernova={
				name="Hypernova",
				text={
					"{X:mult,C:white}X#1#{} Mult",
					"Retrigger once for every",
					"time {C:attention}poker hand{} has been",
					"played this run"
				}
			},
			j_plt_creation={
				name="Pillars of Creation",
				text={
					"{C:attention}Create{} a {C:attention}random {C:planet}Planet{} card",
					"that levels {C:attention}discarded{} hand",
					"{C:inactive}Also grants {C:attention}+#1#{C:inactive} consumeable slots{}"
				}
			},

			j_plt_aries={
				name="Aries"
			},
			j_plt_taurus={
				name="Taurus"
			},
			j_plt_gemini={
				name="Gemini"
			},
			j_plt_cancer={
				name="Cancer"
			},
			j_plt_leo={
				name="Leo"
			},
			j_plt_virgo={
				name="Virgo"
			},
			j_plt_libra={
				name="Libra"
			},
			j_plt_scorpio={
				name="Scorpio"
			},
			j_plt_sagittarius={
				name="Sagittarius"
			},
			j_plt_capricorn={
				name="Capricorn"
			},
			j_plt_aquarius={
				name="Aquarius"
			},
			j_plt_pisces={
				name="Pisces"
			},
			
		},
		Planet={
			c_plt_royal_planet={
				name="Juno",
				text={
					"({V:1}lvl.#1#{}) Level up",
					"{C:attention}#2#",
					"{C:mult}+#3#{} Mult and",
					"{C:chips}+#4#{} Chips"
				}
			},
			--[[c_plt_strengthen_pluto={
				name="Charon",
				text={
					"Empower {C:planet}Pluto{}",
					"{C:mult}+#1#{} Mult and",
					"{C:chips}+#2#{} Chips"
				}
			},]]
		},
		Other={
			plt_navy_seal={
				name="Navy Seal",
				text={
					"Creates the {C:planet}Planet{} card",
					"for played {C:attention}poker hand{}",
					"of when {C:attention}played{} and {C:attention}scored{}",
					"{C:inactive}(Must have room){}"
				}
			},
			plt_tanzanite_seal={
				name="Tanzanite Seal",
				text={
					"Create the {X:black,C:white}Negative{} {C:planet}Planet{} card",
					"for played {C:attention}poker hand{}",
					"when this card is {C:attention}retriggered{}"
				}
			},
			plt_royal_blue_seal={
				name="Royal Blue Seal",
				text={
					"Earn {C:money}$#1#{} for each",
					"{C:planet}Planet{} card in consumeable",
					"tray when {C:attention}played and scored{}"
				}
			},
			plt_blurple_seal={
				name="Blurple Seal",
				text={
					--[["Creates the {C:planet}Planet{} card",
					"of the {C:attention}discarded{} hand",
					"when {C:attention}discarded{}",
					"{C:inactive}(Must have room){}",]]
					"Levels up {C:attention}discarded{} hand",
					"when {C:attention}discarded{}"
				}
			},
			plt_ruby_seal={
				name="Ruby Seal",
				text={
					"{C:attention}Retrigger{} adjacent",
					"cards {C:attention}#1#{} time",
					"{C:red}WIP{}"
				}
			},
			plt_citrine_seal={
				name="Citrine Seal",
				text={
					"Earn {C:money}$#1#{} when this",
					"card is {C:attention}retriggered{}",
				}
			},
			plt_amethyst_seal={
				name="Amethyst Seal",
				text={
					"Creates a {X:black,C:white}Negative{} {C:tarot}Tarot{} card",
					"when this card is {C:attention}retriggered{}",
				}
			},
			plt_platinum_seal={
				name="Platinum Seal",
				text={
					"Earn {C:money}$#1#{} if this",
					"card is {C:attention}held in hand{}",
				}
			},
			plt_rose_gold_seal={
				name="Rose Gold Seal",
				text={
					"Create a {C:money}Money {C:tarot}Tarot{} card",
					"when this card is",
					"{C:attention}played and scored{}",
					"{C:inactive}(Must have room){}",
				}
			},
			plt_ultramarine_seal={
				name="Ultramarine Seal",
				text={
					"Create a {C:spectral}Spectral{} card if",
					"this card is {C:attention}held in hand{}"
				}
			},
		},
		Spectral={
			--[[plt_navy_sealer={
				name="Recruiter",
				text={
					"Add a {C:blue}Navy Seal{}",
					"to {C:attention}1{} selected",
					"card in your hand",
				}
			}]]
			c_plt_merge_seals={
				name="Combinare",
				text={
					"Select {C:attention}#1# cards with {C:attention}Seals{}",
					"convert the {C:attention}right{} card into",
					"the {C:attention}combination{} of both {C:attention}Seals{}"
				}
			},
			c_plt_nullius_planet={
				name="Nullius",
				text={
					"Empower selected hand",
					"{C:mult}+#1#{} Mult and",
					"{C:chips}+#2#{} Chips",
					"every level",
					"{C:inactive}(Selected hand: {C:attention}#3#{C:inactive}){}"
				}
			},
			c_plt_green_card={
				name="Creatio",
				text={
					"Create a card",
					"of your choice",
					"and add it to deck",
				}
			}
		}
	},
	misc={
		poker_hand_descriptions={
			plt_royal_flush={
				"5 cards in a row (consecutive ranks) with",
				"all cards sharing the same suit and",
				"all cards being between 10 and Ace"
			}
		},
		poker_hands={
			plt_royal_flush="Royal Flush",
		},
		dictionary={
			k_plt_celestial="Celestial",
			k_plt_leg_celestial="Celestial",
		},
		labels={
			plt_celestial="Celestial",
			plt_leg_celestial="Celestial",
			plt_navy_seal="Navy Seal",
			plt_tanzanite_seal="Tanzanite Seal",
			plt_royal_blue_seal="Royal Blue Seal",
			plt_blurple_seal="Blurple Seal",
			plt_ruby_seal="Ruby Seal",
			plt_citrine_seal="Citrine Seal",
			plt_amethyst_seal="Amethyst Seal",
			plt_platinum_seal="Platinum Seal",
			plt_rose_gold_seal="Rose Gold Seal",
			plt_ultramarine_seal="Ultramarine Seal",
		}
	}
}