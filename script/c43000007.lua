-- Elemental HERO Cutting Bladedge
local s,id=GetID()
function s.initial_effect(c)
    -- Special Summon by tributing 1 "Elemental HERO" monster
    local e1=Effect.CreateEffect(c)
    e1:SetCode(EFFECT_SPSUMMON_PROC)
    e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetRange(LOCATION_HAND)
    e1:SetCondition(s.spcon)
    e1:SetTarget(s.sptg)
    e1:SetOperation(s.spop)
    c:RegisterEffect(e1)
    
    -- Inflict damage if "Elemental HERO" monster destroys a monster by battle or card effect
    local e2=Effect.CreateEffect(c)
    e2:SetDescription(aux.Stringid(id,1))
    e2:SetCategory(CATEGORY_DAMAGE)
    e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
    e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
    e2:SetCode(EVENT_DESTROYED)
    e2:SetRange(LOCATION_MZONE)
    e2:SetCondition(s.damcon)
    e2:SetTarget(s.damtg)
    e2:SetOperation(s.damop)
    c:RegisterEffect(e2)
end

-- Special Summon condition
function s.spcon(e,c)
    if c==nil then return true end
	return Duel.CheckReleaseGroup(c:GetControler(),Card.IsSetCard,1,false,1,true,c,c:GetControler(),nil,false,nil,0x3008)
end

-- Special Summon target
function s.sptg(e,tp,eg,ep,ev,re,r,rp,c)
    local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local g=Duel.SelectReleaseGroup(tp,Card.IsSetCard,1,1,false,true,true,c,nil,nil,false,nil,0x3008)
	if g then
		g:KeepAlive()
		e:SetLabelObject(g)
	return true
	end
	return false
end

-- Special Summon operation
function s.spop(e,tp,eg,ep,ev,re,r,rp,c)
    local g=e:GetLabelObject()
	if not g then return end
	Duel.Release(g,REASON_COST)
	g:DeleteGroup()
end

-- Damage condition
function s.damcon(e,tp,eg,ep,ev,re,r,rp)
    local tc=eg:GetFirst()
    local rc=tc:GetReasonCard()
    return tc:IsReason(REASON_BATTLE+REASON_EFFECT) and tc:IsPreviousLocation(LOCATION_MZONE)
end

-- Damage target
function s.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return true end
    local tc=eg:GetFirst()
    local dam=math.max(tc:GetAttack(), tc:GetDefense())
    if dam<0 then dam=0 end
    Duel.SetTargetPlayer(1-tp)
    Duel.SetTargetParam(dam)
    Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end

-- Damage operation
function s.damop(e,tp,eg,ep,ev,re,r,rp)
    local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
    Duel.Damage(p,d,REASON_EFFECT)
end
