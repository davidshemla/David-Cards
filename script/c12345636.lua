--Luck Manipulator
local s,id=GetID()
function s.initial_effect(c)
    -- Activate
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    c:RegisterEffect(e1)
    
    -- Change dice result
    local e2=Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    e2:SetCode(EVENT_TOSS_DICE_NEGATE)
    e2:SetRange(LOCATION_FZONE)
    e2:SetOperation(s.diceop)
    c:RegisterEffect(e2)
    
    -- Change coin result
    local e3=Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    e3:SetCode(EVENT_TOSS_COIN_NEGATE)
    e3:SetRange(LOCATION_FZONE)
    e3:SetOperation(s.coinop)
    c:RegisterEffect(e3)
end

function s.diceop(e,tp,eg,ep,ev,re,r,rp)
    local diceNum = {}
    for i=1, ev do
        local num = Duel.AnnounceNumber(tp,1,2,3,4,5,6)
        diceNum[i] = num
    end
    Duel.SetDiceResult(table.unpack(diceNum))
end

function s.coinop(e,tp,eg,ep,ev,re,r,rp)
    local coinResults = {}
    for i=1, ev do
        local res = Duel.SelectOption(tp, 60, 61) -- 60 is HEADS, 61 is TAILS
        coinResults[i] = res == 0 and 1 or 0 -- Switch between 1 (HEADS) and 0 (TAILS)
    end
    Duel.SetCoinResult(table.unpack(coinResults))
end