-- Chimera Hydradrive Draghead - Night
local s,id=GetID()

function s.initial_effect(c)
	-- Special Summon effect
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
    e1:SetCode(EVENT_SPSUMMON_SUCCESS)
    e1:SetCondition(s.spcon)
    e1:SetOperation(s.spop)
    c:RegisterEffect(e1)

    -- Return to Extra Deck and Special Summon
    local e2=Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    e2:SetRange(LOCATION_MZONE)
    e2:SetCode(EVENT_PHASE+PHASE_END)
    e2:SetCountLimit(1)
    e2:SetOperation(s.retop)
    c:RegisterEffect(e2)
end
s.listed_series={0x577}
s.listed_names={49372007}

function s.spcon(e,tp,eg,ep,ev,re,r,rp)
    return e:GetHandler():IsSummonType(SUMMON_TYPE_LINK)
end

function s.spop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    -- Shuffle opponent's GY and banish zone into the deck
    local g=Duel.GetFieldGroup(tp,0,LOCATION_GRAVE+LOCATION_REMOVED)
    if #g>0 then
        Duel.SendtoDeck(g,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
        Duel.ShuffleDeck(1-tp)
    end
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