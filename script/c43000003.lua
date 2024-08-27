-- Elemental HERO Hydraulic Bubbleman
local s,id=GetID()
function s.initial_effect(c)
    -- Special summon from hand if you control a face-up "Elemental HERO" monster
    local e1=Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(id,0))
    e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e1:SetType(EFFECT_TYPE_IGNITION)
    e1:SetRange(LOCATION_HAND)
    e1:SetCondition(s.spcon)
    e1:SetCost(s.spcost)
    e1:SetTarget(s.sptg)
    e1:SetOperation(s.spop)
    c:RegisterEffect(e1)

    -- Quick Effect: Protect all "Elemental HERO" monsters you control
    local e2=Effect.CreateEffect(c)
    e2:SetDescription(aux.Stringid(id,1))
    e2:SetType(EFFECT_TYPE_QUICK_O)
    e2:SetCode(EVENT_FREE_CHAIN)
    e2:SetRange(LOCATION_MZONE)
    e2:SetCountLimit(1,id)
    e2:SetTarget(s.ptarget)
    e2:SetOperation(s.poperation)
    c:RegisterEffect(e2)

    -- Draw and Special Summon if used as material
    local e3=Effect.CreateEffect(c)
    e3:SetDescription(aux.Stringid(id,2))
    e3:SetCategory(CATEGORY_DRAW+CATEGORY_SPECIAL_SUMMON)
    e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
    e3:SetCode(EVENT_TO_GRAVE)
    e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
    e3:SetCondition(s.drcon)
    e3:SetTarget(s.drtg)
    e3:SetOperation(s.drop)
    c:RegisterEffect(e3)
end

-- Effect 1: Special summon from hand
function s.spcon(e,tp,eg,ep,ev,re,r,rp)
    return Duel.IsExistingMatchingCard(Card.IsSetCard,tp,LOCATION_MZONE,0,1,nil,0x3008)
end

function s.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return true end
    -- Cost for Special Summon (if any, e.g., discarding a card or paying LP)
end

function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end

function s.spop(e,tp,eg,ep,ev,re,r,rp)
    Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)
end

-- Effect 2: Protect all "Elemental HERO" monsters you control
function s.ptarget(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return true end
    -- No specific target selection needed for this effect
end

function s.poperation(e,tp,eg,ep,ev,re,r,rp)
    local g=Duel.GetMatchingGroup(Card.IsSetCard,tp,LOCATION_MZONE,0,nil,0x3008)
    if #g>0 then
        for tc in aux.Next(g) do
            -- Make monsters unable to be destroyed by battle
            local e1=Effect.CreateEffect(e:GetHandler())
            e1:SetType(EFFECT_TYPE_SINGLE)
            e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
            e1:SetValue(1)
            e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
            tc:RegisterEffect(e1)
            
            -- Make monsters unaffected by opponent's effects
            local e2=Effect.CreateEffect(e:GetHandler())
            e2:SetType(EFFECT_TYPE_SINGLE)
            e2:SetCode(EFFECT_IMMUNE_EFFECT)
            e2:SetValue(s.efilter)
            e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
            tc:RegisterEffect(e2)
        end
    end
end

function s.efilter(e,re)
    -- Immunity to opponent's effects
    return e:GetOwnerPlayer()~=re:GetOwnerPlayer()
end

-- Effect 3: Draw and Special Summon if used as material
function s.drcon(e,tp,eg,ep,ev,re,r,rp)
    return r&REASON_FUSION~=0
end

function s.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return true end
    Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end

function s.drop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    if Duel.Draw(tp,1,REASON_EFFECT)>0 then
        local dc=Duel.GetOperatedGroup():GetFirst()
        if dc:IsSetCard(0x3008) and dc:IsType(TYPE_MONSTER) then
            if Duel.SelectYesNo(tp,aux.Stringid(id,3)) then
                Duel.SpecialSummon(dc,0,tp,tp,false,false,POS_FACEUP)
            end
        end
    end
end
