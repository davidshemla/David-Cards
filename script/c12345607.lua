--Immortal call of the Haunted
local s,id=GetID()
function s.initial_effect(c)
    --Activate
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    c:RegisterEffect(e1)
    
    --Prevent destruction, increase ATK/DEF
    local e2=Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
    e2:SetCode(EFFECT_SEND_REPLACE)
    e2:SetRange(LOCATION_SZONE)
    e2:SetTarget(s.reptg)
    e2:SetValue(s.repval)
    c:RegisterEffect(e2)
    
    --Special Summon monsters from GY
    local e3=Effect.CreateEffect(c)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e3:SetType(EFFECT_TYPE_IGNITION)
    e3:SetRange(LOCATION_SZONE)
    e3:SetCountLimit(1)
    e3:SetTarget(s.sptg)
    e3:SetOperation(s.spop)
    c:RegisterEffect(e3)
end

function s.repfilter(c,tp)
    return c:IsFaceup() and c:IsControler(tp) and c:IsMonster() and c:IsReason(REASON_BATTLE+REASON_EFFECT+REASON_COST) and not c:IsReason(REASON_REPLACE)
end

function s.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return eg:IsExists(s.repfilter,1,nil,tp) end
    Duel.Hint(HINT_CARD,0,id)
    return true
end

function s.repval(e,c)
    local atk=c:GetAttack()
    local def=c:GetDefense()
    local new_atk=math.floor(atk*1.1)
    local new_def=math.floor(def*1.1)
    local e1=Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_SET_ATTACK_FINAL)
    e1:SetValue(new_atk)
    e1:SetReset(RESET_EVENT+RESETS_STANDARD)
    c:RegisterEffect(e1)
    local e2=Effect.CreateEffect(e:GetHandler())
    e2:SetType(EFFECT_TYPE_SINGLE)
    e2:SetCode(EFFECT_SET_DEFENSE_FINAL)
    e2:SetValue(new_def)
    e2:SetReset(RESET_EVENT+RESETS_STANDARD)
    c:RegisterEffect(e2)
    return true
end

function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
        and Duel.IsExistingTarget(aux.NecroValleyFilter(Card.IsCanBeSpecialSummoned),tp,LOCATION_GRAVE,0,1,nil,e,0,tp,false,false) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
    local g=Duel.SelectTarget(tp,aux.NecroValleyFilter(Card.IsCanBeSpecialSummoned),tp,LOCATION_GRAVE,0,1,Duel.GetLocationCount(tp,LOCATION_MZONE),nil,e,0,tp,false,false)
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,#g,0,0)
end

function s.spop(e,tp,eg,ep,ev,re,r,rp)
    local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
    local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
    if ft<=0 then return end
    local sg=g:Filter(Card.IsRelateToEffect,nil,e)
    for tc in aux.Next(sg) do
        if ft<=0 then break end
        Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
        ft=ft-1
    end
    Duel.SpecialSummonComplete()
end
