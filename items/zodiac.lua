SMODS.ObjectType{
	object_type="ObjectType",
	key="plt_j_zodiac",
	default="j_plt_aries",
}

-- idea,
-- Cardinal quality -> strong-ish early game (maybe don't even appear after ante 4)
-- Fixed quality -> well, fixed jokers
-- Mutable quality -> scaling, or otherwise changing jokers

SMODS.Joker{
	key="plt_aries",
	blueprint_compat=true,
	perishable_compat=false,
	eternal_compat=false,
	pools={["plt_j_zodiac"]=true,},
	rarity=1,
	cost=2,
	atlas="plt_j_atlas",
	pos={x=0,y=0},
	soul_pos={x=2,y=0},
	config={extra={}},
	loc_vars=function(self,info_queue,card)
		return{vars={}}
	end,
	calculate=function(self,card,context)
		if(context.joker_main)then
			local  _hand, _tally = nil, 0
			for _, handname in ipairs(G.handlist) do
                if SMODS.is_poker_hand_visible(handname) and G.GAME.hands[handname].played > _tally then
                    _hand = handname
                    _tally = G.GAME.hands[handname].played
                end
			end
			return{
				chips=G.GAME.hands[_hand].chips+G.GAME.hands[_hand].mult
			}
		end
	end,
	add_to_deck=function(self,card,from_debuff) end,
	remove_from_deck=function(self,card,from_debuff) end,
}

SMODS.Joker{
	key="plt_taurus",
	blueprint_compat=true,
	perishable_compat=false,
	eternal_compat=false,
	pools={["plt_j_zodiac"]=true,},
	rarity=1,
	cost=2,
	atlas="plt_j_atlas",
	pos={x=0,y=0},
	soul_pos={x=3,y=0},
	config={extra={poker_hand="Pair"}},
	loc_vars=function(self,info_queue,card)
		return{vars={localize(card.ability.extra.poker_hand, 'poker_hands')}}
	end,
	calculate=function(self,card,context)
		if(context.joker_main)then
			return{
				chips=G.GAME.hands[card.ability.extra.poker_hand].chips,
				mult=G.GAME.hands[card.ability.extra.poker_hand].mult
			}
		end
	end,
	add_to_deck=function(self,card,from_debuff) end,
	remove_from_deck=function(self,card,from_debuff) end,
}

SMODS.Joker{
	key="plt_gemini",
	blueprint_compat=true,
	perishable_compat=false,
	eternal_compat=false,
	pools={["plt_j_zodiac"]=true,},
	rarity=1,
	cost=2,
	atlas="plt_j_atlas",
	pos={x=0,y=0},
	soul_pos={x=4,y=0},
	config={extra={poker_hand="Two Pair"}},
	loc_vars=function(self,info_queue,card)
		return{vars={localize(card.ability.extra.poker_hand, 'poker_hands')}}
	end,
	calculate=function(self,card,context)
		if(context.joker_main)then
			return{
				chips=G.GAME.hands[card.ability.extra.poker_hand].chips,
				mult=G.GAME.hands[card.ability.extra.poker_hand].mult
			}
		end
	end,
	add_to_deck=function(self,card,from_debuff) end,
	remove_from_deck=function(self,card,from_debuff) end,
}

SMODS.Joker{
	key="plt_cancer",
	blueprint_compat=true,
	perishable_compat=false,
	eternal_compat=false,
	pools={["plt_j_zodiac"]=true,},
	rarity=1,
	cost=2,
	atlas="plt_j_atlas",
	pos={x=0,y=0},
	soul_pos={x=5,y=0},
	config={extra={poker_hand="Three of a Kind"}},
	loc_vars=function(self,info_queue,card)
		return{vars={localize(card.ability.extra.poker_hand, 'poker_hands')}}
	end,
	calculate=function(self,card,context)
		if(context.joker_main)then
			return{
				chips=G.GAME.hands[card.ability.extra.poker_hand].chips,
				mult=G.GAME.hands[card.ability.extra.poker_hand].mult
			}
		end
	end,
	add_to_deck=function(self,card,from_debuff) end,
	remove_from_deck=function(self,card,from_debuff) end,
}

SMODS.Joker{
	key="plt_leo",
	blueprint_compat=true,
	perishable_compat=false,
	eternal_compat=false,
	pools={["plt_j_zodiac"]=true,},
	rarity=1,
	cost=2,
	atlas="plt_j_atlas",
	pos={x=0,y=0},
	soul_pos={x=6,y=0},
	config={extra={poker_hand="Straight"}},
	loc_vars=function(self,info_queue,card)
		return{vars={localize(card.ability.extra.poker_hand, 'poker_hands')}}
	end,
	calculate=function(self,card,context)
		if(context.joker_main)then
			return{
				chips=G.GAME.hands[card.ability.extra.poker_hand].chips,
				mult=G.GAME.hands[card.ability.extra.poker_hand].mult
			}
		end
	end,
	add_to_deck=function(self,card,from_debuff) end,
	remove_from_deck=function(self,card,from_debuff) end,
}

SMODS.Joker{
	key="plt_virgo",
	blueprint_compat=true,
	perishable_compat=false,
	eternal_compat=false,
	pools={["plt_j_zodiac"]=true,},
	rarity=1,
	cost=2,
	atlas="plt_j_atlas",
	pos={x=0,y=0},
	soul_pos={x=7,y=0},
	config={extra={poker_hand="Flush"}},
	loc_vars=function(self,info_queue,card)
		return{vars={localize(card.ability.extra.poker_hand, 'poker_hands')}}
	end,
	calculate=function(self,card,context)
		if(context.joker_main)then
			return{
				chips=G.GAME.hands[card.ability.extra.poker_hand].chips,
				mult=G.GAME.hands[card.ability.extra.poker_hand].mult
			}
		end
	end,
	add_to_deck=function(self,card,from_debuff) end,
	remove_from_deck=function(self,card,from_debuff) end,
}

SMODS.Joker{
	key="plt_libra",
	blueprint_compat=true,
	perishable_compat=false,
	eternal_compat=false,
	pools={["plt_j_zodiac"]=true,},
	rarity=1,
	cost=2,
	atlas="plt_j_atlas",
	pos={x=0,y=0},
	soul_pos={x=8,y=0},
	config={extra={poker_hand="Full House"}},
	loc_vars=function(self,info_queue,card)
		return{vars={localize(card.ability.extra.poker_hand, 'poker_hands')}}
	end,
	calculate=function(self,card,context)
		if(context.joker_main)then
			return{
				chips=G.GAME.hands[card.ability.extra.poker_hand].chips,
				mult=G.GAME.hands[card.ability.extra.poker_hand].mult
			}
		end
	end,
	add_to_deck=function(self,card,from_debuff) end,
	remove_from_deck=function(self,card,from_debuff) end,
}

SMODS.Joker{
	key="plt_scorpio",
	blueprint_compat=true,
	perishable_compat=false,
	eternal_compat=false,
	pools={["plt_j_zodiac"]=true,},
	rarity=1,
	cost=2,
	atlas="plt_j_atlas",
	pos={x=0,y=0},
	soul_pos={x=9,y=0},
	config={extra={poker_hand="Four of a Kind"}},
	loc_vars=function(self,info_queue,card)
		return{vars={localize(card.ability.extra.poker_hand, 'poker_hands')}}
	end,
	calculate=function(self,card,context)
		if(context.joker_main)then
			return{
				chips=G.GAME.hands[card.ability.extra.poker_hand].chips,
				mult=G.GAME.hands[card.ability.extra.poker_hand].mult
			}
		end
	end,
	add_to_deck=function(self,card,from_debuff) end,
	remove_from_deck=function(self,card,from_debuff) end,
}

SMODS.Joker{
	key="plt_sagittarius",
	blueprint_compat=true,
	perishable_compat=false,
	eternal_compat=false,
	pools={["plt_j_zodiac"]=true,},
	rarity=1,
	cost=2,
	atlas="plt_j_atlas",
	pos={x=0,y=0},
	soul_pos={x=0,y=1},
	config={extra={odds=3}},
	loc_vars=function(self,info_queue,card)
		local _num, _demon=SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'plt_sagittarius')
		return{vars={_num,_demon}}
	end,
	calculate=function(self,card,context)
		if(context.using_consumeable and context.consumeable.ability.set=="Planet" and context.consumeable.ability.plt_sagittarius==nil)then
			for _=1,(context.consumeable and context.consumeable.ability.overflow_used_amount or 1) do
                if(SMODS.pseudorandom_probability(card,"plt_sagittarius",1,card.ability.extra.odds))then
					G.E_MANAGER:add_event(Event({
						func=function()
							--error(tprint(context.consumeable))
							local cards = copy_card(context.consumeable)
							cards.ability.overflow_used_amount=nil
							cards.ability.plt_sagittarius=true
							cards:set_edition("e_negative")
							cards:add_to_deck()
							G.consumeables:emplace(cards)
							return(true)
						end
					}))
				end
            end
			
		end
	end,
	add_to_deck=function(self,card,from_debuff) end,
	remove_from_deck=function(self,card,from_debuff) end,
}

SMODS.Joker{
	key="plt_capricorn",
	blueprint_compat=true,
	perishable_compat=false,
	eternal_compat=false,
	pools={["plt_j_zodiac"]=true,},
	rarity=1,
	cost=2,
	atlas="plt_j_atlas",
	pos={x=0,y=0},
	soul_pos={x=1,y=0},
	config={extra={xmult_per=0.25}},
	loc_vars=function(self,info_queue,card)
		local zodiac_count=0
		if(not G.jokers)then return{vars={card.ability.extra.xmult_per,1}} end
		for i=1,#G.jokers.cards do

			if(G.jokers.cards[i].config.center.pools and G.jokers.cards[i].config.center.pools.plt_j_zodiac)then
				zodiac_count=zodiac_count+1
			end
		end
		return{vars={card.ability.extra.xmult_per,1+card.ability.extra.xmult_per*zodiac_count}}
	end,
	calculate=function(self,card,context)
		if(context.joker_main)then
			local zodiac_count=0
			for i=1,#G.jokers.cards do
				if(G.jokers.cards[i].config.center.pools and G.jokers.cards[i].config.center.pools.plt_j_zodiac)then
					zodiac_count=zodiac_count+1
				end
			end
			return{xmult=1+card.ability.extra.xmult_per*zodiac_count}
		end
	end,
	add_to_deck=function(self,card,from_debuff) end,
	remove_from_deck=function(self,card,from_debuff) end,
}

SMODS.Joker{
	key="plt_aquarius",
	blueprint_compat=true,
	perishable_compat=false,
	eternal_compat=false,
	pools={["plt_j_zodiac"]=true,},
	rarity=1,
	cost=2,
	atlas="plt_j_atlas",
	pos={x=0,y=0},
	soul_pos={x=2,y=1},
	config={extra={slots=1}},
	immutable=true,
	loc_vars=function(self,info_queue,card)
		return{vars={card.ability.extra.slots}}
	end,
	calculate=function(self,card,context)
	end,
	add_to_deck=function(self,card,from_debuff)
		G.jokers.config.card_limit=G.jokers.config.card_limit+card.ability.extra.slots
	end,
	remove_from_deck=function(self,card,from_debuff)
		G.jokers.config.card_limit=G.jokers.config.card_limit-card.ability.extra.slots
	end,
	in_pool=function(self,args)
		return(true,{allow_duplicates=true})
	end
}


-- perhaps something to justify changing the sprite
SMODS.Joker{
	key="plt_pisces",
	blueprint_compat=true,
	perishable_compat=false,
	eternal_compat=false,
	pools={["plt_j_zodiac"]=true,},
	rarity=1,
	cost=2,
	atlas="plt_j_atlas",
	pos={x=0,y=0},
	soul_pos={x=3,y=1},
	config={extra={poker_hand="plt_Royal Flush"}},
	loc_vars=function(self,info_queue,card)
		return{vars={localize(card.ability.extra.poker_hand, 'poker_hands')}}
	end,
	calculate=function(self,card,context)
		if(context.joker_main)then
			return{
				chips=G.GAME.hands[card.ability.extra.poker_hand].chips,
				mult=G.GAME.hands[card.ability.extra.poker_hand].mult
			}
		end
	end,
	add_to_deck=function(self,card,from_debuff) end,
	remove_from_deck=function(self,card,from_debuff) end,
}