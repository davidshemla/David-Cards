-- Chimera Hydradrive Draghead - Aqua
local s,id=GetID()

function s.initial_effect(c)
	--link summon
	Link.AddProcedure(c,aux.FilterBoolFunctionEx(Card.IsType,TYPE_LINK),5,5,s.lcheck)
	c:EnableReviveLimit()
    -- Special Summon effect
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
    e1:SetCode(EVENT_SPSUMMON_SUCCESS)
    e1:SetCategory(CATEGORY_DESTROY)
    e1:SetTarget(s.destg)
    e1:SetOperation(s.desop)
    c:RegisterEffect(e1)

    -- Return to Extra Deck and Special Summon
    local e2=Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    e2:SetRange(LOCATION_MZONE)
    e2:SetCode(EVENT_PHASE+PHASE_END)
    e2:SetOperation(s.retop)
    c:RegisterEffect(e2)
end

s.listed_series={0x577}
s.listed_names={49372007}

function s.lcheck(g,lc,sumtype,tp)
	return g:CheckDifferentPropertyBinary(Card.GetAttribute,lc,sumtype,tp)
end

function s.destg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return true end
    local g=Duel.GetMatchingGroup(Card.IsType,tp,0,LOCATION_ONFIELD,nil,TYPE_SPELL+TYPE_TRAP)
    Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,#g,0,0)
end

function s.desop(e,tp,eg,ep,ev,re,r,rp)
    local g=Duel.GetMatchingGroup(Card.IsType,tp,0,LOCATION_ONFIELD,nil,TYPE_SPELL+TYPE_TRAP)
    Duel.Destroy(g,REASON_EFFECT)
end

function s.retop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    if c:IsFaceup() then
        Duel.SendtoDeck(c,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
        if c:IsLocation(LOCATION_EXTRA) and Duel.GetLocationCountFromEx(tp)>0
            and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_EXTRA,0,1,nil,49372007) then
            local sc=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_EXTRA,0,1,1,nil,49372007):GetFirst()
            if sc then
                Duel.SpecialSummon(sc,0,tp,tp,false,false,POS_FACEUP)
            end
        end
    end
end