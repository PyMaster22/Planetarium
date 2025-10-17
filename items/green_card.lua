function create_UIBox_rank()
	G.GAME.GREEN_CARD_SUBMENU="Rank"
	G.GAME.GREEN_CARD_PLAYING={}
	local cards={}
	local ranks={}
	for i,v in pairs(SMODS.Ranks)do
		cards[#cards+1]=G.P_CENTERS.c_base
		ranks[#ranks+1]=i
	end
	table.sort(ranks,function(a,b) return(SMODS.Ranks[a].id<SMODS.Ranks[b].id)end)
	return(SMODS.card_collection_UIBox(cards,{5,5,5},{
		no_materialize=true,
		snap_back=true,
		h_mod=1.03,
		hide_single_page=true,
		back_func="exit",
		modify_card=function(card,center,i,j)
			SMODS.change_base(card,"Spades",ranks[(j-1)*5+i])
			if(
				center.hidden
			)then
				card.debuff=true
			end
		end
	}))
end
function create_UIBox_suit()
	G.GAME.GREEN_CARD_SUBMENU="Suit"
	local cards={}
	local suits={}
	for i,v in pairs(SMODS.Ranks)do
		cards[#cards+1]=G.P_CENTERS.c_base
		suits[#ranks+1]=i
	end
	table.sort(suits,function(a,b) return(SMODS.Suits[a].suit_nominal<SMODS.Suits[b].suit_nominal)end)
	return(SMODS.card_collection_UIBox(cards,{4,4,4},{
		no_materialize=true,
		snap_back=true,
		h_mod=1.03,
		hide_single_page=true,
		back_func="exit",
		modify_card=function(card,center,i,j)
			SMODS.change_base(card,suits[(j-1)*4+i],G.GAME.GREEN_CARD_PLAYING.rank)
			if(
				center.hidden
			)then
				card.debuff=true
			end
		end
	}))
end
function create_UIBox_enhancement()
	G.GAME.GREEN_CARD_SUBMENU="Enhancement"
	local cards={G.P_CENTERS.c_base}
	for i,v in pairs(G.P_CENTER_POOLS.Enhanced)do
		cards[#cards+1]=V
	end
	return(SMODS.card_collection_UIBox(cards,{4,4},{
		no_materialize=true,
		snap_back=true,
		h_mod=1.03,
		hide_single_page=true,
		back_func="exit",
		modify_card=function(card,center,i,j)
			SMODS.change_base(card,G.GAME.GREEN_CARD_PLAYING.suit,G.GAME.GREEN_CARD_PLAYING.rank)
			if(
				center.hidden
			)then
				card.debuff=true
			end
		end
	}))
end
function create_UIBox_edition()
	G.GAME.GREEN_CARD_SUBMENU="Edition"
	return(SMODS.card_collection_UIBox(G.P_CENTER_POOL.Edition,{5,5},{
		no_materialize=true,
		snap_back=true,
		h_mod=1.03,
		hide_single_page=true,
		back_func="exit",
		modify_card=function(card,center,i,j)
			card:set_edition(center.key,true,true)
			SMODS.change_base(card,G.GAME.GREEN_CARD_PLAYING.suit,G.GAME.GREEN_CARD_PLAYING.rank)
			card:set_ability(G.P_CENTERS[G.GAME.GREEN_CARD_PLAYING.center])
			if(
				center.hidden
			)then
				card.debuff=true
			end
		end
	}))
end
function create_UIBox_seal()
	G.GAME.GREEN_CARD_SUBMENU="Seal"
	local cards={{key=nil}}
	for i,v in pairs(G.P_CENTER_POOLS.Seal)do
		cards[#cards+1]=V
	end
	return(SMODS.card_collection_UIBox(cards,{5,5},{
		no_materialize=true,
		snap_back=true,
		h_mod=1.03,
		hide_single_page=true,
		center="c_base",
		back_func="exit",
		modify_card=function(card,center,i,j)
			card:set_seal(center.key,true)
			card:set_edition(G.GAME.GREEN_CARD_PLAYING.edition,true,true)
			SMODS.change_base(card,G.GAME.GREEN_CARD_PLAYING.suit,G.GAME.GREEN_CARD_PLAYING.rank)
			card:set_ability(G.P_CENTERS[G.GAME.GREEN_CARD_PLAYING.center])
			if(
				center.hidden
			)then
				card.debuff=true
			end
		end
	}))
end

function apply_green_card()
	local function apply_lower(strn)
		if type(strn) ~= string then -- safety
			strn = tostring(strn)
		end
		-- Remove content within {} and any remaining spaces
		strn = strn:gsub("%b{}", ""):gsub("%s+", "")
		--this weirdness allows you to get m and M separately
		if string.len(strn) == 1 then
			return strn
		end
		return string.lower(strn)
	end
	local current_card
	local entered_card = G.ENTERED_CARDlocal valid_check={}
	local valid_check={}
	G.PREVIOUS_ENTERED_CARD=G.ENTERED_CARD
	

SMODS.Consumable{
	key="plt_green_card",
	set="Spectral",
	soul_set="Standard",
	hidden=false,
	pos={x=2,y=2},
	can_use=function(self,card) return(true) end,
	use=function(self,card,area,copier)
		SMODS.add_card(self)
		G.OVERLAY_MENU_GREEN_CARD=true
		G.E_MANAGER:add_event(Event({
			func=function()
				G.GAME.USING_GREEN_CARD=true
				G.SETTINGS.paused=true
				G.FUNCS.overlay_menu({definition=create_UIBox_rank()})
				return(true)
			end
		}))
		G.GAME.GREEN_CARD_SUBMENU=nil
	end,
	init=function(self)
		local ccl=Card.click
		function Card:click()
			if(G.GAME.USING_GREEN_CARD)then
				if(not self.debuff)then
					if(self.config.center.consumeable)then
						local copy=copy_card(self)
						copy:add_to_deck()
						G.consumeables:emplace(copy)
						G.GAME.USING_GREEN_CARD=nil
						G.GAME.GREEN_CARD_SUBMENU=nil
						G.GAME.GREEN_CARD_PLAYING=nil
						G.FUNCS.exit_overlay_menu()
						ccl(self)
					elseif(
						self.config.center.key=="c_base"
						or self.config.center.set=="Enhanced"
						or self.edition
						or G.GAME.GREEN_CARD_SUBMENU=="Edition"
					)then
						if(G.GAME.GREEN_CARD_SUBMENU=="Rank")then
							G.GAME.FREEN_CARD_PLAYING.rank=self.base.value
							G.FUNCS.overlay_menu({definition=create_UIBox_suit})
						elseif(G.GAME.GREEN_CARD_SUBMENU=="Suit")then
							G.GAME.POINTER_PLAYING.suit=self.base.suit
							G.FUNCS.overlay_menu({definition=create_UIBox_enhancement})
						elseif(G.GAME.GREEN_CARD_SUBMENU=="Enhancement")then
							G.GAME.POINTER_PLAYING.center=self.config.center.key
							G.FUNCS.overlay_menu({definition=create_UIBox_edition})
						elseif(G.GAME.GREEN_CARD_SUBMENU=="Edition")then
							if(self.edition)then G.GAME.GREEN_CARD_PLAYING.edition=self.edition.key end
							G.FUNCS.overlay_menu({definition=create_UIBox_seal})
						elseif(G.GAME.GREEN_CARD_SUBMENU=="Seal")then
							G.GAME.POINTER_PLAYING.seal=self.seal
							local card=SMODS.create_card({
								key=G.GAME.GREEN_CARD_PLAYING.center,
								rank=G.GAME.GREEN_CARD_PLAYING.rank,
								suit=G.GAME.GREEN_CARD_PLAYING.suit,
							})
							card:set_ability(G.P_CENTERS[G.GAME.GREEN_CARD_PLAYING.center])
							if(G.GAME.GREEN_CARD_PLAYING.seal)then card:set_seal(G.GAME.GREEN_CARD_PLAYING.seal) end
							if(G.GAME.GREEN_CARD_PLAYING.edition)then card:set_edition(G.GAME.GREEN_CARD_PLAYING.edition) end
							if(G.STATE==G.STATES.SELECTING_HAND)then
								G.hand:emplace(card)
							else
								G.deck:emplace(card)
							end
							table.insert(G.playing_cards,card)
							G.GAME.USING_GREEN_CARD=nil
							G.GAME.GREEN_CARD_SUBMENU=nil
							G.GAME.GREEN_CARD_PLAYING=nil
							G.FUNCS.exit_overlay_menu()
							G.GAME.GREEN_CARD_PLAYING=nil
						end
					else
						G.ENTERED_CARD=self.config.center.key
						local ret=apply_green_card()
						if(ret)then
							G.GAME.USING_GREEN_CARD=nil
							G.GAME.GREEN_CARD_SUBMENU=nil
							G.GAME.GREEN_CARD_PLAYING=nil
							G.FUNCS.exit_overlay_menu()
							ccl(self)
						else
							G.GAME.USING_GREEN_CARD=true
						end
					end
				end
			end
		end
	end,
}