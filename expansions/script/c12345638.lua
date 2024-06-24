--Amazoness Rule
local s, id = GetID()
function s.initial_effect(c)
    -- Activate
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    c:RegisterEffect(e1)
    
    -- ATK boost
    local e2 = Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_FIELD)
    e2:SetCode(EFFECT_UPDATE_ATTACK)
    e2:SetRange(LOCATION_FZONE)
    e2:SetTargetRange(LOCATION_MZONE, 0)
    e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard, 0x4))
    e2:SetValue(500)
    c:RegisterEffect(e2)

    --reflect effect damage
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_REFLECT_DAMAGE)
	e3:SetRange(LOCATION_FZONE)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetTargetRange(1,0)
	e3:SetValue(s.refcon)
	c:RegisterEffect(e3)
	
	--Redirect battle damage
    local e4=Effect.CreateEffect(c)
    e4:SetType(EFFECT_TYPE_FIELD)
    e4:SetCode(EFFECT_REFLECT_BATTLE_DAMAGE)
    e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e4:SetRange(LOCATION_FZONE)
    e4:SetTargetRange(1,0)
    e4:SetValue(1)
    c:RegisterEffect(e4)
	
    -- LP gain
    local e5 = Effect.CreateEffect(c)
    e5:SetType(EFFECT_TYPE_FIELD + EFFECT_TYPE_CONTINUOUS)
    e5:SetCode(EVENT_SUMMON_SUCCESS)
    e5:SetRange(LOCATION_FZONE)
    e5:SetCondition(s.lpgcon)
    e5:SetOperation(s.lpop)
    c:RegisterEffect(e5)
    local e6 = e5:Clone()
    e6:SetCode(EVENT_SPSUMMON_SUCCESS)
    c:RegisterEffect(e6)
    local e7 = e5:Clone()
    e7:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
    c:RegisterEffect(e7)

    -- Negate and destroy
    local e8 = Effect.CreateEffect(c)
    e8:SetCategory(CATEGORY_NEGATE + CATEGORY_DESTROY)
    e8:SetType(EFFECT_TYPE_QUICK_O)
    e8:SetCode(EVENT_CHAINING)
    e8:SetRange(LOCATION_FZONE)
    e8:SetCountLimit(1)
    e8:SetCondition(s.negcon)
    e8:SetTarget(s.negtg)
    e8:SetOperation(s.negop)
    c:RegisterEffect(e8)

    -- Add Amazoness card from Deck/GY to hand
    local e9 = Effect.CreateEffect(c)
    e9:SetCategory(CATEGORY_TOHAND + CATEGORY_SEARCH)
    e9:SetType(EFFECT_TYPE_IGNITION)
    e9:SetRange(LOCATION_FZONE)
    e9:SetCountLimit(1)
    e9:SetTarget(s.thtg)
    e9:SetOperation(s.thop)
    c:RegisterEffect(e9)
    
    -- Monsters your opponent controls must attack if able
    local e10=Effect.CreateEffect(c)
    e10:SetType(EFFECT_TYPE_FIELD)
    e10:SetCode(EFFECT_MUST_ATTACK)
    e10:SetRange(LOCATION_FZONE)
    e10:SetTargetRange(0, LOCATION_MZONE)
    c:RegisterEffect(e10)
end
function s.refcon(e,re,val,r,rp,rc)
	return (r&REASON_EFFECT)~=0 and rp==1-e:GetHandlerPlayer()
end

function s.lpgcon(e, tp, eg, ep, ev, re, r, rp)
    return ep == 1 - tp
end

function s.lpop(e, tp, eg, ep, ev, re, r, rp)
    for tc in aux.Next(eg) do
        if tc:IsFaceup() then
            Duel.Recover(tp, tc:GetAttack(), REASON_EFFECT)
        end
    end
end

function s.negcon(e, tp, eg, ep, ev, re, r, rp)
    return rp == 1 - tp and Duel.IsChainNegatable(ev) and Duel.IsExistingMatchingCard(aux.FaceupFilter(Card.IsSetCard, 0x4), tp, LOCATION_MZONE, 0, 1, nil)
end

function s.negtg(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then return true end
    Duel.SetOperationInfo(0, CATEGORY_NEGATE, eg, 1, 0, 0)
    if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
        Duel.SetOperationInfo(0, CATEGORY_DESTROY, eg, 1, 0, 0)
    end
end

function s.negop(e, tp, eg, ep, ev, re, r, rp)
    if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
        Duel.Destroy(eg, REASON_EFFECT)
    end
end

function s.thfilter(c)
    return c:IsSetCard(0x4) and c:IsAbleToHand()
end

function s.thtg(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then return Duel.IsExistingMatchingCard(s.thfilter, tp, LOCATION_DECK + LOCATION_GRAVE, 0, 1, nil) end
    Duel.SetOperationInfo(0, CATEGORY_TOHAND, nil, 1, tp, LOCATION_DECK + LOCATION_GRAVE)
end

function s.thop(e, tp, eg, ep, ev, re, r, rp)
    Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_ATOHAND)
    local g = Duel.SelectMatchingCard(tp, s.thfilter, tp, LOCATION_DECK + LOCATION_GRAVE, 0, 1, 1, nil)
    if #g > 0 then
        Duel.SendtoHand(g, nil, REASON_EFFECT)
        Duel.ConfirmCards(1 - tp, g)
    end
end