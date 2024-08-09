-- Sacred Beasts Calling
local s,id=GetID()
function s.initial_effect(c)
    -- Special Summon up to 5 copies of the specified monsters
    local e1 = Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetCountLimit(1)
    e1:SetTarget(s.sptg)
    e1:SetOperation(s.spop)
    c:RegisterEffect(e1)
end
s.listed_names={6007213,32491822,69890967}

-- Define the target function
function s.sptg(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then return true end
    local g = Duel.GetMatchingGroup(function(c) return c:IsCode(6007213, 32491822, 69890967) end, tp, LOCATION_HAND + LOCATION_DECK, 0, nil)
    Duel.SetOperationInfo(0, CATEGORY_SPECIAL_SUMMON, g, 5, 0, 0)
end

-- Define the operation function
function s.spop(e, tp, eg, ep, ev, re, r, rp)
    local g = Duel.GetMatchingGroup(function(c) return c:IsCode(6007213, 32491822, 69890967) end, tp, LOCATION_HAND + LOCATION_DECK, 0, nil)
    local tc = g:GetFirst()
    local count = 0
    while tc and count < 5 do
        Duel.SpecialSummon(tc, 0, tp, tp, true, false, POS_FACEUP_ATTACK)
        count = count + 1
        tc = g:GetNext()
    end
end