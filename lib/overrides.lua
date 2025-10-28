SMODS.Joker:take_ownership("j_marble",{
	calculate=function(self,card,context)
        if(#SMODS.find_card("j_plt_scorpio")~=0)then return true,nil end
	end
})

SMODS.Joker:take_ownership("j_certificate",{
	calculate=function(self,card,context)
		if(#SMODS.find_card("j_plt_scorpio")~=0)then return true,nil end
	end
})