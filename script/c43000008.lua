-- Devoted Wroughtweiler
local s,id=GetID()
function s.initial_effect(c)
	-- Special Summon and add a "Polymerization" or "Fusion" Spell
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(s.spcon)
	e1:SetTarget(s.sptg)
	e1:SetOperation(s.spop)
	c:RegisterEffect(e1)
	
	-- Ignition Effect: Special Summon from GY
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(s.qecon)
	e2:SetCost(s.qecost)
	e2:SetTarget(s.qetg)
	e2:SetOperation(s.qeop)
	c:RegisterEffect(e2)
	
	-- Banish instead of destruction
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCondition(s.banishcon)
	e3:SetValue(s.banishval)
	c:RegisterEffect(e3)
end

-- Check if you control a face-up "Elemental HERO" monster
function s.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(aux.FaceupFilter(Card.IsSetCard,0x3008),tp,LOCATION_MZONE,0,1,nil)
end

-- Special Summon and add a Spell
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SEARCH,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end

function s.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local c=e:GetHandler()
	if Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)~=0 then
	local function IsFusionSpell(c)
    return c:IsCode(24094653) or (c:IsSetCard(0x3008) and c:IsType(TYPE_SPELL + TYPE_TRAP)) and c:IsAbleToHand()
end
		local g = Duel.GetMatchingGroup(IsFusionSpell, tp, LOCATION_DECK + LOCATION_GRAVE, 0, nil)
		if #g>0 and Duel.SelectYesNo(tp,aux.Stringid(id,0)) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
			local tc=g:Select(tp,1,1,nil):GetFirst()
			Duel.SendtoHand(tc,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,tc)
		end
	end
end

-- Quick Effect: Special Summon from GY
function s.qecon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsMainPhase() and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false)
end

function s.qecost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.Release(e:GetHandler(),REASON_COST)
end

function s.qetg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(Card.IsType,tp,LOCATION_GRAVE,0,1,nil,TYPE_MONSTER) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,Card.IsType,tp,LOCATION_GRAVE,0,1,1,nil,TYPE_MONSTER)
end

function s.qeop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
		tc:CancelToGrave()
	end
end

-- Banish instead of destruction
function s.banishcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and Duel.IsExistingMatchingCard(aux.FilterFaceupFunction(Card.IsSetCard,0x3008),tp,LOCATION_MZONE,0,1,nil)
end

function s.banishval(e,re,r,rp)
	return bit.band(r,REASON_BATTLE+REASON_EFFECT)~=0 and 1
end
