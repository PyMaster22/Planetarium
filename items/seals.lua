SMODS.Seal{
	-- planet card of played hand when played
	key="plt_navy",
	pos={x=6,y=4},
	badge_colour=HEX("0000A0"),
	calculate=function(self,card,context)
		if(context.main_scoring and context.cardarea==G.play
		and #G.consumeables.cards + G.GAME.consumeable_buffer<G.consumeables.config.card_limit)then
			G.GAME.consumeable_buffer=G.GAME.consumeable_buffer+1
			G.E_MANAGER:add_event(Event({
				trigger="before",
				delay=0.0,
				func=function()
					local _planet=nil
					for k,v in pairs(G.P_CENTER_POOLS.Planet)do
						if(v.config.hand_type==G.GAME.last_hand_played)then
							_planet=v.key
						end
					end
					if(_planet)then
						SMODS.add_card({key=_planet})
					end
					G.GAME.consumeable_buffer=0
					return(true)
				end
			}))
			return{message=localize("k_plus_planet"),color=G.C.SECONDARY_SET.Planet}
		end
	end
}

SMODS.Seal{
	-- negative planet card of played hand when retriggered
	key="plt_tanzanite",
	pos={x=6,y=4},
	config={extra={triggers=0}},
	badge_colour=HEX("4646f0"),
	calculate=function(self,card,context)
		if(context.main_scoring)then
			card.ability.seal.extra.triggers=card.ability.seal.extra.triggers+1
			if(card.ability.seal.extra.triggers>1)then
				G.E_MANAGER:add_event(Event({
					trigger="before",
					delay=0.0,
					func=function()
						local _planet=nil
						for k,v in pairs(G.P_CENTER_POOLS.Planet)do
							if(v.config.hand_type==G.GAME.last_hand_played)then
								_planet=v.key
							end
						end
						if(_planet)then
							SMODS.add_card{key=_planet,edition="e_negative"}
						end
						return(true)
					end
				}))
				return{message=localize("k_plus_planet"),color=G.C.SECONDARY_SET.Planet}
			end
		end
		if(context.final_scoring_step)then
			card.ability.seal.extra.triggers=0
		end
	end
}

SMODS.Seal{
	-- $2 per planet card in "inventory" when played and scored
	-- idk if this works
	key="plt_royal_blue",
	pos={x=6,y=4},
	config={extra={money=2,counted_planets=0}},
	badge_colour=HEX("305CDE"),
	loc_vars=function(self,info_queue,card)
		return{vars={card.ability.seal.extra.money}}
	end,
	calculate=function(self,card,context)
		if(context.main_scoring and context.cardarea==G.play)then
			if(context.other_consumeable and context.other_consumable.ability.set=="Planet")then
				card.ability.extra.seal.counted_planets=card.ability.seal.extra.counted_planets+1
			end
			if(not context.other_consumable)then
				return{dollars=card.ability.seal.extra.money*card.ability.seal.extra.counted_planets}
			end
		end
		if(context.end_of_round)then
			card.ability.seal.extra.counted_planets=0
		end
	end
}

SMODS.Seal{
	-- Level up discarded hand when discarded (I want planet)
	key="plt_blurple",
	pos={x=6,y=4},
	badge_colour=HEX("724bcc"),
	calculate=function(self,card,context)
		if(context.pre_discard and context.other_card == card)then
			SMODS.smart_level_up_hand(card,G.FUNCS.get_poker_hand_info(G.hand.highlighted),true,1)
		end
	end
}

SMODS.Seal{
	-- Retrigger adjacent cards 1 time
	-- maybe change to retrigger card to left 1 time (works on ruby seal)
	-- idk if this seal actually works
	key="plt_ruby",
	pos={x=6,y=4},
	config={extra={retriggers=1}},
	badge_colour=HEX("f01838"),
	loc_vars=function(self,info_queue,card)
		return{vars={card.ability.seal.extra.retriggers}}
	end,
	calculate=function(self,card,context)
		if((context.cardarea==G.play or context.cardarea==G.hand) and not context.ruby_trigger)then
			for i,v in ipairs(G.play.cards)do
				if(G.play.cards[i+1]==card or G.play.cards[i-1]==card)then
					context.crimson_trigger=true
					local eval,post=eval_card(v,context)
					local effects={eval}
					if(context.main_scoring)then
						eval.chips=v.base.nominal+v.ability.bonus or 0
						SMODS.calculate_context{individual=true,other_card=v,cardarea=v.area,scoring_hand=context.scoring_hand}
					end
					for _,v in ipairs(post or {}) do effects[#effects+1]=v end
					if(eval.retriggers)then
						for rt=1,#eval.retriggers do
							local rt_eval,rt_post=eval_card(v,context)
							table.insert(effects,{eval.retriggers[rt]})
							table.insert(effects,rt_eval)
							for _,v in ipairs(rt_post)do effects[#effects+1]=v end
							if(context.main_scoring)then
								table.insert(effects,{chips=v.base.nominal+v.ability.bonus or 0})
								SMODS.calculate_context({individual=true,other_card=v,cardarea=v.area,scoring_hand=context.scoring_hand})
							end
						end
					end
					SMODS.trigger_effects(effects,v)
				end
			end
			context.ruby_trigger=nil
		end
	end,
}

SMODS.Seal{
	-- i want: $3 when triggered (kinda gold card + gold seal)
	-- i make: $5 when retriggered cause i can make that
	key="plt_citrine",
	pos={x=6,y=4},
	config={extra={money=5,triggers=0}},
	badge_colour=HEX("f2c00c"),
	loc_vars=function(self,info_queue,card)
		return{vars={card.ability.seal.extra.money}}
	end,
	calculate=function(self,card,context)
		if(context.main_scoring)then
			card.ability.seal.extra.triggers=card.ability.seal.extra.triggers+1
		end
		if(context.end_of_round)then
			card.ability.seal.extra.triggers=0
		end
	end,
	get_p_dollars = function(self, card)
        return card.ability.seal.extra.triggers>1 and card.ability.seal.extra.money or 0
    end,
}

SMODS.Seal{
	-- Negative tarot card when retriggered
	key="plt_amethyst",
	pos={x=6,y=4},
	config={extra={triggers=0}},
	badge_colour=HEX("d35cfa"),
	calculate=function(self,card,context)
		if(context.main_scoring)then
			card.ability.seal.extra.triggers=card.ability.seal.extra.triggers+1
			if(card.ability.seal.extra.triggers>1)then
				G.E_MANAGER:add_event(Event({
					trigger = 'before',
					delay = 0.0,
					func = function()
						SMODS.add_card({
							set='Tarot',
							edition="e_negative",
							key_append="plt_amethyst",
						})
						return true
					end
				}))
				return{message=localize('k_plus_tarot'),colour=G.C.PURPLE}
			end
		end
		if(context.final_scoring_step)then
			card.ability.seal.extra.triggers=0
		end
	end
}

SMODS.Seal{
	-- $3 when held in hand (kinda stronger gold card)
	key="plt_platinum",
	pos={x=6,y=4},
	config={extra={money=3}},
	badge_colour=HEX("bef1f7"),
	loc_vars=function(self,info_queue,card)
		return{vars={card.ability.seal.extra.money}}
	end,
	calculate=function(self,card,context)
		if(context.main_scoring and context.cardarea==G.hand)then
			return{dollars=card.ability.seal.extra.money}
		end
	end
}

SMODS.Seal{
	-- Create a Hermit, Temperance, Devil, or Fool
	key="plt_rose_gold",
	pos={x=6,y=4},
	badge_colour=HEX("ebbef7"),
	calculate=function(self,card,context)
		if(context.main_scoring and context.cardarea==G.play
		and #G.consumeables.cards + G.GAME.consumeable_buffer<G.consumeables.config.card_limit)then
			G.GAME.consumeable_buffer=G.GAME.consumeable_buffer+1
			G.E_MANAGER:add_event(Event({
				trigger="before",
				delay=0.0,
				func=function()
					SMODS.add_card{
						set="MoneyTarot",
						area=G.consumeables,
						key_append="plt_rose_gold"
					}
					G.GAME.consumeable_buffer=0
					return(true)
				end
			}))
			return{message=localize("k_plus_tarot"),color=G.C.SECONDARY_SET.Tarot}
		end
	end
}

SMODS.Seal{
	-- Create a spectral card when held in hand at end of round (favors combinare)
	key="plt_ultramarine",
	pos={x=6,y=4},
	badge_colour=HEX("6d02d9"),
	calculate=function(self,card,context)
		if(context.end_of_round and context.cardarea==G.hand
		and #G.consumeables.cards + G.GAME.consumeable_buffer<G.consumeables.config.card_limit)then
			G.GAME.consumeable_buffer=G.GAME.consumeable_buffer+1
			G.E_MANAGER:add_event(Event({
				trigger="before",
				delay=0.0,
				func=function()
					--[[if(SMODS.pseudorandom_probability(card,"plt_ultramarine",1,7)) then
						SMODS.add_card{
							--set="Spectral",
							key="plt_merge_seals",
							key_append="plt_ultramarine"
						}
						return(true)
					end]]
					SMODS.add_card{
						set="Spectral",
						key_append="plt_ultramarine"
					}
					G.GAME.consumeable_buffer=0
					return(true)
				end
			}))
			return{message=localize("k_plus_spectral"),color=G.C.SECONDARY_SET.Spectral}
		end
	end
}