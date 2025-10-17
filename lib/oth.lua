function stringifyTable(t,depth, indent)
    if(depth<=0) then return("") end
    depth=depth-1
    indent = indent or ""
    local result = "{\n"
    local nextIndent = indent .. "  "
    for k, v in pairs(t) do
        result = result .. nextIndent
        if type(k) == "number" then
            result = result .. "[" .. k .. "] = "
        else
            result = result .. "[\"" .. tostring(k) .. "\"] = "
        end
        if type(v) == "table" then
            result = result .. stringifyTable(v,depth, nextIndent) .. ",\n"
        else
            result = result .. tostring(v) .. ",\n"
        end
    end
    result = result .. indent .. "}"
    return result
end

SMODS.ObjectType{
	key="MoneyTarot",
	default="c_temperance",
	cards={},
	inject=function(self)
		SMODS.ObjectType.inject(self)
		self:inject_card(G.P_CENTERS.c_hermit)
		self:inject_card(G.P_CENTERS.c_devil)
		self:inject_card(G.P_CENTERS.c_fool)
	end
}