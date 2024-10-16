--Lyrilusc Realm
local s,id=GetID()
function s.initial_effect(c)
    -- Activate
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    c:RegisterEffect(e1)

    -- Cannot be targeted
    local e2=Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_FIELD)
    e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
    e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
    e2:SetRange(LOCATION_FZONE)
    e2:SetTargetRange(LOCATION_MZONE,0)
    e2:SetTarget(s.target)
    e2:SetValue(s.value)
    c:RegisterEffect(e2)

    -- Add 1 "Lyrilusc" card and send to GY
    local e3=Effect.CreateEffect(c)
    e3:SetDescription(aux.Stringid(id,0))
    e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_TOGRAVE)
    e3:SetType(EFFECT_TYPE_IGNITION)
    e3:SetRange(LOCATION_FZONE)
    e3:SetCountLimit(1,id)
    e3:SetTarget(s.thtg)
    e3:SetOperation(s.thop)
    c:RegisterEffect(e3)

    -- Attach to "Lyrilusc" Xyz monster
    local e4=Effect.CreateEffect(c)
    e4:SetDescription(aux.Stringid(id,1))
    e4:SetType(EFFECT_TYPE_IGNITION)
    e4:SetRange(LOCATION_FZONE)
    e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e4:SetCountLimit(1,id+1)
    e4:SetTarget(s.xyztarget)
    e4:SetOperation(s.xyzoperation)
    c:RegisterEffect(e4)

    -- Special Summon "Lyrilusc" monsters from hand or GY
    local e5=Effect.CreateEffect(c)
    e5:SetDescription(aux.Stringid(id,3))
    e5:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e5:SetType(EFFECT_TYPE_IGNITION)
    e5:SetRange(LOCATION_FZONE)
    e5:SetCountLimit(1,id+3)
    e5:SetTarget(s.sptarget)
    e5:SetOperation(s.spoperation)
    c:RegisterEffect(e5)

    -- Negate and destroy
    local e6=Effect.CreateEffect(c)
    e6:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
    e6:SetType(EFFECT_TYPE_QUICK_O)
    e6:SetCode(EVENT_CHAINING)
    e6:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
    e6:SetRange(LOCATION_FZONE)
    e6:SetCountLimit(1,id+4)
    e6:SetCondition(s.negcon)
    e6:SetTarget(s.negtg)
    e6:SetOperation(s.negop)
    c:RegisterEffect(e6)

    -- Optional detach replacement effect
    local e7=Effect.CreateEffect(c)
    e7:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    e7:SetCode(EFFECT_OVERLAY_REMOVE_REPLACE)
    e7:SetRange(LOCATION_FZONE)
    e7:SetTargetRange(LOCATION_MZONE,0)
    e7:SetCondition(s.xyzremovecon)
    e7:SetValue(s.xyzremovevalue)
    c:RegisterEffect(e7)
end

-- Cannot be targeted filter
function s.target(e,c)
    return c:IsMonster() and c:IsSetCard(0xf7)
end

function s.value(e,re,rp)
    return rp~=e:GetHandlerPlayer()
end

-- Add 1 "Lyrilusc" card and send to GY
function s.thfilter(c)
    return c:IsSetCard(0xf7) and (c:IsAbleToHand() or c:IsAbleToGrave())
end

function s.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(s.thfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil) end
    Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end

function s.thop(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
    local g=Duel.SelectMatchingCard(tp,s.thfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
    if #g>0 then
        Duel.SendtoHand(g,nil,REASON_EFFECT)
        Duel.ConfirmCards(1-tp,g)
        if Duel.IsExistingMatchingCard(s.thfilter,tp,LOCATION_DECK,0,1,nil)
            and Duel.SelectYesNo(tp,aux.Stringid(id,2)) then -- Ask if they want to send a card to the GY
            Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
            local tg=Duel.SelectMatchingCard(tp,s.thfilter,tp,LOCATION_DECK,0,1,1,nil)
            Duel.SendtoGrave(tg,REASON_EFFECT)
        end
    end
end

-- Target a "Lyrilusc" Xyz monster for the attach effect
function s.xyzfilter(c)
    return c:IsFaceup() and c:IsSetCard(0xf7) and c:IsType(TYPE_XYZ)
end

function s.attachfilter(c)
    return c:IsSetCard(0xf7) and c:IsType(TYPE_MONSTER)
end

function s.xyztarget(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and s.xyzfilter(chkc) end
    if chk==0 then return Duel.IsExistingTarget(s.xyzfilter,tp,LOCATION_MZONE,0,1,nil)
        and Duel.IsExistingMatchingCard(s.attachfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
    Duel.SelectTarget(tp,s.xyzfilter,tp,LOCATION_MZONE,0,1,1,nil)
end

function s.xyzoperation(e,tp,eg,ep,ev,re,r,rp)
    local tc=Duel.GetFirstTarget()
    if tc:IsRelateToEffect(e) and tc:IsFaceup() then
        Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
        local g=Duel.SelectMatchingCard(tp,s.attachfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
        if #g>0 then
            Duel.Overlay(tc,g)
        end
    end
end

-- Special Summon "Lyrilusc" monsters
function s.spfilter(c,e,tp)
    return c:IsSetCard(0xf7) and c:IsSummonableCard()
end

function s.sptarget(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(s.spfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil) end
    local g=Duel.GetMatchingGroup(s.spfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,nil)
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,#g,tp,0)
end

function s.spoperation(e,tp,eg,ep,ev,re,r,rp)
    local g=Duel.GetMatchingGroup(s.spfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,nil)
    if #g>0 then
        -- Allow the player to select which cards to summon
        local sg=Duel.SelectMatchingCard(tp,s.spfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,#g,nil)
        if #sg>0 then
            Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
        end
    end
end

-- Negate and destroy
function s.negfilter(c,tp)
    return c:IsFaceup() and c:IsSetCard(0xf7) and c:IsControler(tp)
end

function s.negcon(e,tp,eg,ep,ev,re,r,rp)
    return ep~=tp and Duel.IsExistingMatchingCard(s.negfilter,tp,LOCATION_MZONE,0,1,nil,tp) and Duel.IsChainNegatable(ev)
end

function s.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return true end
    Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
    if re:GetHandler():IsRelateToEffect(re) then
        Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
    end
end

function s.negop(e,tp,eg,ep,ev,re,r,rp)
    if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
        Duel.Destroy(eg,REASON_EFFECT)
    end
end

-- Optional detach replacement effect
function s.xyzremovecon(e,tp,eg,ep,ev,re,r,rp)
    local tc=eg:GetFirst()
    return tc and tc:IsFaceup() and tc:IsSetCard(0xf7) and tc:IsType(TYPE_XYZ)
end

function s.xyzremovevalue(e,re,rp)
    local tp=e:GetOwnerPlayer()
    if Duel.SelectYesNo(tp,aux.Stringid(id,4)) then
        return tp~=rp -- Detach optional, return true if it's not the player who activated the effect
    end
    return false -- Do not detach if the player chooses no
end
