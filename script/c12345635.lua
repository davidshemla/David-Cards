--Field Spell Card: "Infernal Realm"
local s,id=GetID()
function s.initial_effect(c)
    --Activate
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    c:RegisterEffect(e1)

    --Effect damage becomes 2000
    local e2=Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_FIELD)
    e2:SetCode(EFFECT_CHANGE_DAMAGE)
    e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e2:SetRange(LOCATION_FZONE)
    e2:SetTargetRange(0,1) -- Opponent only
    e2:SetValue(s.damval)
    c:RegisterEffect(e2)

    --Unaffected by other card effects
    local e3=Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_SINGLE)
    e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e3:SetRange(LOCATION_FZONE)
    e3:SetCode(EFFECT_IMMUNE_EFFECT)
    e3:SetValue(s.immval)
    c:RegisterEffect(e3)
end

function s.damval(e,re,val,r,rp,rc)
    if bit.band(r,REASON_EFFECT)~=0 then
        return 2000
    else
        return val
    end
end

function s.immval(e,te)
    return te:GetOwner()~=e:GetOwner()
end
