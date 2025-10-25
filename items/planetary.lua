SMODS.Rarity{
	key="celestial",
	badge_colour=G.C.SECONDARY_SET.Planet,
	default_weight=0,
	get_weight=function(self,weight,object_type)
		return(weight)
	end,
	pools={["Joker"]=true}
}

SMODS.Joker{
	key="plt_dying",
	blueprint_compat=true,
	perishable_compat=true,
	rarity=3,
	cost=4,
	pos={x=2,y=4},
	config={extra={rounds=0,rounds_needed=3}},
	loc_vars=function(self,info_queue,card)
		return{vars={card.ability.extra.rounds_needed,card.ability.extra.rounds}}
	end,
	calculate=function(self,card,context)
		if(context.selling_self and (card.ability.extra.rounds>=card.ability.extra.rounds_needed)) then 
			if(#G.jokers.cards>=G.jokers.config.card_limit+1) then
				return{
					message=localize("k_nope_ex"),
					colour=G.C.YELLOW
				}
			end
			if(pseudorandom(pseudoseed("plt_dying_rotting?"))<1/20 and 0)then
				G.E_MANAGER:add_event(Event({
					trigger="after",
					delay=0.4,
					func=function()
                		play_sound('timpani')
						local card=SMODS.create_card({
							set="Joker",area=G.jokers,
							rarity="plt_rotting",
							key_append="plt_dying"
						})
						card:add_to_deck()
						G.jokers:emplace(card)
						card:juice_up(0.3,0.5)
						return(true)
					end
				}))
			end
			G.E_MANAGER:add_event(Event({
				trigger="after",
				delay=0.4,
				func=function()
					local card=SMODS.create_card({
						set="Joker",area=G.jokers,
						rarity="plt_celestial",
						key_append="plt_dying"
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
	key="plt_hypernova",
	blueprint_compat=true,
	perishable_compat=true,
	rarity="plt_celestial",
	in_pool=function(self,args) return{false,{allow_duplicates=true}} end,
	pools={["plt_j_celestial"]=true,},
	cost=0,
	pos={x=2,y=4},
	config={extra={xmult_per=1.1}},
	loc_vars=function(self,info_queue,card)
		return{vars={card.ability.extra.xmult_per}}
	end,
	calculate=function(self,card,context)
		if context.retrigger_joker_check and not context.retrigger_joker and context.other_card == card then
			return {
				message = localize("k_again_ex"),
				repetitions = to_number(G.GAME.hands[G.FUNCS.get_poker_hand_info(G.play.cards)].played)-1,
				card=card
			}
		end
		if(context.joker_main)then
			local XMult=1
			for i=1,G.GAME.hands[context.scoring_name].played do
				XMult=XMult*card.ability.extra.xmult_per
			end
			return{xmult=card.ability.extra.xmult_per}--XMult}
		end
	end,
	add_to_deck=function(self, card, from_debuff)end,
}

assert(SMODS.load_file("items/legendary_celestial.lua"))()