SMODS.Rarity{
	key="leg_celestial",
	badge_colour=G.C.SECONDARY_SET.Planet,
	default_weight=0,
	get_weight=function(self,weight,object_type)
		return(weight)
	end,
	pools={["Joker"]=true}
}

SMODS.Joker{
	key="plt_rotting",
	blueprint_compat=false,
	perishable_compat=false,
	eternal_compat=false,
	rarity=4,
	cost=20,
	pos={x=2,y=4},
	config={extra={rounds=0,rounds_needed=5}},
	immutable=true,
	loc_vars=function(self,info_queue,card)
		return{vars={card.ability.extra.rounds_needed,card.ability.extra.rounds}}
	end,
	calculate=function(self,card,context)
		if(context.selling_self and (card.ability.extra.rounds>=card.ability.extra.rounds_needed) and not context.blueprint)then
			G.E_MANAGER:add_event(Event({
				func=function()
					local card=SMODS.create_card({
						set="Joker",area=G.jokers,
						rarity="plt_leg_celestial",
						key_append="plt_rotting"
					})
					card:add_to_deck()
					G.jokers:emplace(card)
					card:juice_up(0.3,0.5)
					return(true)
				end
			}))
			return{
				message=localize("k_plus_joker"),
				colour=G.C.Planet
			}
		end
		if(context.end_of_round and context.game_over==false and context.main_eval and not context.blueprint) then
			card.ability.extra.rounds=card.ability.extra.rounds+1
			if(card.ability.extra.rounds==card.ability.extra.rounds_needed) then
				local eval=function(card) return not card.REMOVED end
				juice_card_until(card,eval,true)
				return{
					message=(card.ability.extra.rounds<card.ability.extra.rounds_needed)and
						(card.ability.extra.rounds.."/"..card.ability.extra.rounds_needed)or
						localize("k_active_ex"),
					color=G.C.FILTER
				}
			end
		end
	end,
	add_to_deck=function(self, card, from_debuff)end,
}

SMODS.Joker{
	key="plt_creation",
	blueprint_compat=false,
	perishable_compat=true,
	eternal_compat=true,
	rarity="plt_leg_celestial",
	in_pool=function(self,args) return{false,{allow_duplicates=true}} end,
	cost=4,
	pos={x=2,y=4},
	config={extra={c_slots=2},immutable={max_slots=20}},
	loc_vars=function(self,info_queue,card)
		return{vars={math.min(card.ability.extra.c_slots,card.ability.immutable.max_slots)}}
	end,
	calculate=function(self,card,context)
		if(context.pre_discard and #G.consumeables.cards+G.GAME.consumeable_buffer<G.consumeables.config.card_limit)then
			G.GAME.consumeable_buffer=G.GAME.consumeable_buffer+1
			G.E_MANAGER:add_event(Event({
				func=(function()
					local _hand=G.FUNCS.get_poker_hand_info(G.hand.highlighted)
					local _planet={}
					for k,v in pairs(G.P_CENTER_POOLS.Planet)do
						if(v.config.hand_type==_hand)then
							_planet[#_planet+1]=v.key
						end
					end
					if(#_planet)then
						SMODS.add_card{key=pseudorandom_element(_planet,pseudoseed("plt_creation"))}
					end
					
					G.GAME.consumeable_buffer=0
					return(true)
				end)
			}))
			return{message=localize("k_plus_planet")}
		end
	end,
	add_to_deck=function(self, card, from_debuff)
		G.consumeables.config.card_limit = G.consumeables.config.card_limit + math.min(card.ability.extra.c_slots,card.ability.immutable.max_slots)
	end,
	remove_from_deck=function(self,card,from_debuff)
		G.consumeables.config.card_limit = G.consumeables.config.card_limit - math.min(card.ability.extra.c_slots,card.ability.immutable.max_slots)
	end,
	set_badges=function(self,card,badges)
		badges[#badges+1]=create_badge(localize("k_legendary"),HEX("ab5bb5"))
	end,
}