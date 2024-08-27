--The Seal Of Orichalcos
--Scripted by The Razgriz
local s,id=GetID()
function s.initial_effect(c)
	--Activate
	aux.AddSkillProcedure(c,2,false,nil,nil)
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_STARTUP)
	e1:SetCountLimit(1)
	e1:SetRange(0x5f)
	e1:SetLabel(0)
	e1:SetOperation(s.op)
	c:RegisterEffect(e1)
end
function s.op(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabel()==0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PREDRAW)
		e1:SetCondition(s.flipcon)
		e1:SetOperation(s.flipop)
		Duel.RegisterEffect(e1,tp)
	end
	e:SetLabel(1)
end
function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
	--condition
	return Duel.GetCurrentChain()==0 and Duel.GetTurnCount()==1
end
function s.flipop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
	Duel.Hint(HINT_CARD,tp,id)
	Duel.RegisterFlagEffect(ep,id,0,0,0)
	local c=e:GetHandler()
	-- ATK boost
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetValue(500)
	Duel.RegisterEffect(e1,tp)
	-- Target restriction
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetCondition(s.atkcon)
	e2:SetValue(s.atklimit)
	Duel.RegisterEffect(e2,tp)
	-- Indestructible count
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e3:SetTargetRange(LOCATION_ONFIELD,0)
	e3:SetValue(s.indct)
	Duel.RegisterEffect(e3,tp)
	-- Draw a card when losing LP or paying LP
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_DAMAGE)
	e4:SetCondition(s.drcon)
	e4:SetOperation(s.drop)
	Duel.RegisterEffect(e4,tp)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e5:SetCode(EVENT_PAY_LPCOST)
	e5:SetCondition(s.drcon)
	e5:SetOperation(s.drop)
	Duel.RegisterEffect(e5,tp)
	-- Gain LP during Standby Phase
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e6:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e6:SetCountLimit(1)
	e6:SetCondition(s.lpcon)
	e6:SetOperation(s.lpop)
	Duel.RegisterEffect(e6,tp)
	--summon without tribute
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(id, 0))
	e7:SetType(EFFECT_TYPE_FIELD)
	e7:SetCode(EFFECT_SUMMON_PROC)
	e7:SetTargetRange(LOCATION_HAND,0)
	e7:SetCondition(s.ntcon)
	e7:SetTarget(aux.FieldSummonProcTg(function(e,c) return c:IsLevelAbove(5) end))
	Duel.RegisterEffect(e7,tp)
	local e8=e7:Clone()
	e8:SetCode(EFFECT_SET_PROC)
	Duel.RegisterEffect(e8,tp)
	--no limit on Normal Summons
	local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_FIELD)
	e9:SetCode(EFFECT_SET_SUMMON_COUNT_LIMIT)
	e9:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e9:SetTargetRange(1,0)
	e9:SetValue(99)
	Duel.RegisterEffect(e9,tp)
	-- Draw until you have 4 cards
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e10:SetCode(EVENT_PREDRAW)
	e10:SetCondition(s.drcon2)
	e10:SetOperation(s.drop2)
	Duel.RegisterEffect(e10,tp)
	-- No limit to hand size
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_FIELD)
	e11:SetCode(EFFECT_HAND_LIMIT)
	e11:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e11:SetTargetRange(1,0)
	e11:SetValue(99)
	Duel.RegisterEffect(e11,tp)
	-- Shuffle and draw during Standby Phase
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e12:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e12:SetCountLimit(1)
	e12:SetCondition(s.stbcon)
	e12:SetOperation(s.stbop)
	Duel.RegisterEffect(e12,tp)
	-- Reveal opponent's hand
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_FIELD)
	e13:SetCode(EFFECT_PUBLIC)
	e13:SetTargetRange(0,LOCATION_HAND)
	Duel.RegisterEffect(e13,tp)
end

function s.atkcon(e)
	return Duel.IsExistingMatchingCard(aux.FaceupFilter(Card.IsAttackPos),e:GetHandlerPlayer(),LOCATION_MZONE,0,2,nil)
end

function s.atklimit(e,c)
	return c~=e:GetHandlerPlayer() and c:IsAttackPos() and c:GetAttack()~=Duel.GetFieldGroup(e:GetHandlerPlayer(),LOCATION_MZONE,0):GetMaxGroup(Card.GetAttack):GetFirst():GetAttack()
end

function s.indct(e,re,r,rp)
	if (r&REASON_EFFECT~=0 or r&REASON_BATTLE~=0) and rp~=e:GetHandlerPlayer() then
		return 1
	else 
		return 0 
	end
end

function s.drcon(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp and ev>0
end

function s.drop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
end

function s.lpcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end

function s.lpop(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetFieldGroupCount(tp,LOCATION_ONFIELD,0)
	if ct>0 then
		Duel.Recover(tp,ct*500,REASON_EFFECT)
	end
end

function s.ntcon(e,c,minc)
	if c==nil then return true end
	local tp=e:GetHandlerPlayer()
	return minc==0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
end

function s.drcon2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp and Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)<4
end

function s.drop2(e,tp,eg,ep,ev,re,r,rp)
	local hg=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	local ct=4-hg:GetCount()-1
	if ct>0 then
		Duel.Draw(tp,ct,REASON_EFFECT)
	end
end

function s.stbcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end

function s.stbop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.SelectYesNo(tp,aux.Stringid(id,1)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		local g=Duel.SelectMatchingCard(tp,aux.TRUE,tp,LOCATION_HAND,0,1,99,nil)
		if g:GetCount()>0 then
			Duel.SendtoDeck(g,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
			Duel.ShuffleDeck(tp)
			Duel.Draw(tp,g:GetCount(),REASON_EFFECT)
		end
	end
end