--CNo.32 海咬龍シャーク・ドレイク・バイス (Anime)
--fixed by MLD
function c511010132.initial_effect(c)
	--xyz summon
	c:EnableReviveLimit()
	aux.AddXyzProcedure(c,nil,4,4,c511010132.ovfilter,aux.Stringid(49221191,0))
	--atk/def
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511010132,1))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET,EFFECT_FLAG2_XMDETACH)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c511010132.cost)
	e1:SetTarget(c511010132.target)
	e1:SetOperation(c511010132.operation)
	c:RegisterEffect(e1)
	--selfdes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_SELF_DESTROY)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c511010132.descon)
	c:RegisterEffect(e2)
	--battle indestructable
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e6:SetValue(c511010132.indes)
	c:RegisterEffect(e6)
	if not c511010132.global_check then
		c511010132.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c511010132.numchk)
		Duel.RegisterEffect(ge2,0)
	end
end
c511010132.xyz_number=32
function c511010132.ovfilter(c)
	return c:IsFaceup() and c:IsCode(65676461)
end
c511010132.collection={
	[13429800]=true;[34290067]=true;[10532969]=true;[71923655]=true;[32393580]=true;
	[810000016]=true;[20358953]=true;[37798171]=true;[70101178]=true;[23536866]=true;
	[7500772]=true;[511001410]=true;[69155991]=true;[37792478]=true;[17201174]=true;
	[44223284]=true;[70655556]=true;[63193879]=true;[25484449]=true;[810000026]=true;
	[17643265]=true;[64319467]=true;[810000030]=true;[810000008]=true;[20838380]=true;
	[87047161]=true;[80727036]=true;[28593363]=true;[50449881]=true;[49221191]=true;
	[65676461]=true;[440556]=true;[511001273]=true;[31320433]=true;[5014629]=true;
	[14306092]=true;[84224627]=true;[511001163]=true;[511001169]=true;[511001858]=true;
}
function c511010132.rfilter(c)
	return c:IsType(TYPE_MONSTER) and (c:IsSetCard(0x321) or c511010132.collection[c:GetCode()]) and c:IsAbleToRemoveAsCost()
end
function c511010132.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST)
		and Duel.IsExistingMatchingCard(c511010132.rfilter,tp,LOCATION_GRAVE,0,1,nil) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c511010132.rfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
	e:SetLabel(g:GetFirst():GetAttack())
end
function c511010132.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetTargetParam(e:GetLabel())
	e:SetLabel(0)
end
function c511010132.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local atk=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-atk)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
	end
end
function c511010132.descon(e)
	return Duel.GetLP(e:GetHandlerPlayer())>=1000
end
function c511010132.numchk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,49221191)
	Duel.CreateToken(1-tp,49221191)
end
function c511010132.indes(e,c)
	return not c:IsSetCard(0x48)
end
