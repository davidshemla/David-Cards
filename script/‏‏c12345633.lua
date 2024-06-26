--無限光アイン・ソフ・オウル (Anime)
--Infinite Light (Anime)
local s,id=GetID()
function s.initial_effect(c)
    --activate
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetHintTiming(0,TIMING_END_PHASE)
    c:RegisterEffect(e1)
    --cannot be destroyed or targeted
    local e2=Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_SINGLE)
    e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e2:SetRange(LOCATION_SZONE)
    e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
    e2:SetValue(1)
    c:RegisterEffect(e2)
    local e3=Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_SINGLE)
    e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e3:SetRange(LOCATION_SZONE)
    e3:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
    e3:SetValue(aux.tgoval)
    c:RegisterEffect(e3)
    --special summon
    local e4=Effect.CreateEffect(c)
    e4:SetDescription(aux.Stringid(102380,0))
    e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e4:SetType(EFFECT_TYPE_QUICK_O)
    e4:SetRange(LOCATION_SZONE)
    e4:SetCode(EVENT_FREE_CHAIN)
    e4:SetHintTiming(0,TIMING_END_PHASE)
    e4:SetCondition(s.spcon)
    e4:SetTarget(s.sptg)
    e4:SetOperation(s.spop)
    c:RegisterEffect(e4)
    --cannot trigger
    local e5=Effect.CreateEffect(c)
    e5:SetType(EFFECT_TYPE_FIELD)
    e5:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e5:SetRange(LOCATION_SZONE)
    e5:SetCode(EFFECT_CANNOT_ACTIVATE)
    e5:SetTargetRange(1,0)
    e5:SetCondition(s.accon)
    e5:SetValue(s.aclimit)
    c:RegisterEffect(e5)
    local e6=Effect.CreateEffect(c)
    e6:SetType(EFFECT_TYPE_FIELD)
    e6:SetRange(LOCATION_SZONE)
    e6:SetCode(513000047)
    e6:SetTargetRange(LOCATION_MZONE,0)
    e6:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x4a))
    c:RegisterEffect(e6)
    --sp summon sephylon
    local e7=Effect.CreateEffect(c)
    e7:SetDescription(aux.Stringid(2407147,0))
    e7:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e7:SetType(EFFECT_TYPE_QUICK_O)
    e7:SetCode(EVENT_FREE_CHAIN)
    e7:SetRange(LOCATION_SZONE)
    e7:SetTarget(s.sephtg)
    e7:SetOperation(s.sephop)
    c:RegisterEffect(e7)
    aux.GlobalCheck(s,function()
        s[0]=0
        s[1]=0
        s[2]={}
        s[3]={}
        local ge1=Effect.CreateEffect(c)
        ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
        ge1:SetCode(EVENT_SUMMON_SUCCESS)
        ge1:SetOperation(s.checkop)
        Duel.RegisterEffect(ge1,0)
        local ge2=ge1:Clone()
        ge2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
        Duel.RegisterEffect(ge2,0)
        local ge3=ge1:Clone()
        ge3:SetCode(EVENT_SPSUMMON_SUCCESS)
        Duel.RegisterEffect(ge3,0)
    end)
end
s.listed_series={0x4a}
s.listed_names={36894320,8967776}

function s.spcon(e,tp,eg,ep,ev,re,r,rp)
    return not e:GetHandler():IsStatus(STATUS_CHAINING)
end

function s.spfilter(c,e,tp)
    return c:IsLevelAbove(10) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end

function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
        and Duel.IsExistingMatchingCard(s.spfilter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,nil,e,tp) end
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE)
end

function s.spop(e,tp,eg,ep,ev,re,r,rp)
    local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
    if not e:GetHandler():IsRelateToEffect(e) or ft<=0 then return end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
    local g=Duel.SelectMatchingCard(tp,s.spfilter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,ft,nil,e,tp)
    if #g>0 then
        Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
    end
end

function s.accon(e)
    return Duel.GetTurnPlayer()==e:GetHandlerPlayer() and Duel.GetCurrentPhase()==PHASE_STANDBY
end

function s.aclimit(e,re,tp)
    local rc=re:GetHandler()
    return re:GetActivateLocation()==LOCATION_MZONE and rc:IsSetCard(0x4a) and not rc:IsImmuneToEffect(e)
end

function s.cfilter(c,tp)
    return c:IsSetCard(0x4a) and c:IsFaceup() and c:IsSummonPlayer(tp)
end

function s.checkop(e,tp,eg,ep,ev,re,r,rp)
    local g1=eg:Filter(s.cfilter,nil,tp)
    local g2=eg:Filter(s.cfilter,nil,1-tp)
    local tc1=g1:GetFirst()
    while tc1 do
        if s[tp]==0 then
            s[2+tp][1]=tc1:GetCode()
            s[tp]=s[tp]+1
        else
            local chk=true
            for i=1,s[tp]+1 do
                if s[2+tp][i]==tc1:GetCode() then
                    chk=false
                end
            end
            if chk then
                s[2+tp][s[tp]+1]=tc1:GetCode()
                s[tp]=s[tp]+1
            end
        end
        tc1=g1:GetNext()
    end
    while tc2 do
        if s[1-tp]==0 then
            s[2+1-tp][1]=tc2:GetCode()
            s[1-tp]=s[1-tp]+1
        else
            local chk=true
            for i=1,s[1-tp]+1 do
                if s[2+1-tp][i]==tc2:GetCode() then
                    chk=false
                end
            end
            if chk then
                s[2+1-tp][s[1-tp]+1]=tc2:GetCode()
                s[1-tp]=s[1-tp]+1
            end
        end
        tc2=g2:GetNext()
    end
end

function s.filter(c,e,tp)
    return c:IsCode(8967776) and c:IsCanBeSpecialSummoned(e,0,tp,true,false) 
        and not c:IsHasEffect(EFFECT_NECRO_VALLEY)
end

function s.sephtg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
        and Duel.IsExistingMatchingCard(s.filter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil,e,tp) end
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end

function s.sephop(e,tp,eg,ep,ev,re,r,rp)
    if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
    local g=Duel.SelectMatchingCard(tp,s.filter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,e,tp)
    if #g>0 then
        Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP)
    end
end