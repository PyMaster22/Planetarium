-- Other rarity jokers
assert(SMODS.load_file("items/planetary.lua"))()

SMODS.Joker{
	key="plt_planetarium",
	blueprint_compat=true,
	perishable_compat=false,
	rarity=1,
	cost=4,
	pos={x=2,y=7},
	config={extra={chips=0,chips_gain=15}},
	loc_vars=function(self,info_queue,card)
		return{vars={card.ability.extra.chips_gain,card.ability.extra.chips}}
	end,
	calculate=function(self,card,context)
		if(context.using_consumeable and not context.blueprint and context.consumeable.ability.set=="Planet") then
			--card.ability.extra.chips=card.ability.extra.chips+(card.ability.extra.chips_gain*(context.consumeable.ability.overflow_used_amount or 1))
			SMODS.scale_card(card,{
				ref_table=card.ability.extra,
				ref_value="chips",
				scalar_value="chips_gain",
			})
			return {
				message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } }
			}
		end
		if(context.joker_main) then
			return{chips=card.ability.extra.chips}
		end
	end,
	add_to_deck=function(self, card, from_debuff)end,
}

SMODS.Joker{
	key="plt_horoscope",
	blueprint_compat=true,
	perishable_compat=true,
	rarity=1,
	cost=6,
	pos={x=7,y=5},
	config={extra={mult=1}},
	loc_vars=function(self,info_queue,card)
		return{vars={card.ability.extra.mult,card.ability.extra.mult*(G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.planet or 0)}}
	end,
	calculate=function(self,card,context)
		if(context.using_consumeable and not context.blueprint and context.consumeable.ability.set=="Planet") then
			return{
				message=localize{type="variable",key="a_mult",vars={G.GAME.consumeable_usage_total.planet}}
			}
		end
		if(context.joker_main) then
			return{
				mult=card.ability.extra.mult*
				(G.GAME.consumeable_usage_total and
				G.GAME.consumeable_usage_total.planet or
				0)
			}
		end
	end,
	add_to_deck=function(self, card, from_debuff)end,
}

--[[ -- A joker that makes more jokers after so many rounds
SMODS.Joker{
	key="plt_dying",
	blueprint_compat=true,
	perishable_compat=true,
	rarity=3,
	cost=4,
	pos={x=2,y=4},
	config={extra={rounds=3,rounds_needed=1,cards={"j_supernova","j_plt_hypernova"}}},
	loc_vars=function(self,info_queue,card)
		for i=1,#card.ability.extra.cards do
			info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.extra.cards[i] ]
		end
		return{vars={card.ability.extra.rounds_needed,card.ability.extra.rounds}}
	end,
	calculate=function(self,card,context)
		if(context.selling_self and (card.ability.extra.rounds>=card.ability.extra.rounds_needed)) then 
			for i=1,#card.ability.extra.cards do
				local newcard=SMODS.add_card({
					set="Joker",key=card.ability.extra.cards[i],
					area=G.jokers,
					no_edition=true
				})
			end
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
}]]
