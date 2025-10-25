-- I don't think this is proccing when it should, but it works with Pisces so...
SMODS.PokerHand{
	key="plt_Royal Flush",
	mult=10,
	chips=120,
	l_mult=6,
	l_chips=60,
	example={
		{"H_A",true},
		{"H_K",true},
		{"H_Q",true},
		{"H_J",true},
		{"H_T",true}
	},
	evaluate=function(parts,hand)
		if(next(parts._straight) and next(parts._flush) and next(parts._highest)=="Ace")then
			return{SMODS.merge_lists(parts._straight,parts._flush)}
		end
	end
}