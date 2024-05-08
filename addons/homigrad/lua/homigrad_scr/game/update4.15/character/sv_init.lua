util.AddNetworkString('HG:GetCharacter')

local META = FindMetaTable('Player')
function META:GetCharacter()
   
    return self.dbvars.character

end

function META:SetCharacter(data)
    
    if (self) then
        self:SetDBVar('character', data)
    end

    return self.dbvars.character
end

