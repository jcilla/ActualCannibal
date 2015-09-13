
---------------------------------------------------------------------------
-- Required .lua files
---------------------------------------------------------------------------
require("utils")

---------------------------------------------------------------------------
-- OnNPCSpawned
---------------------------------------------------------------------------
function CActualCannibalGameMode:OnNPCSpawned(keys)
	--acprint("OnNPCSpawned")
	local entity = EntIndexToHScript(keys.entindex)

	-- If a player's hero spawned, remove all their abilities
	if entity:IsHero() then		
		for i = 0, entity:GetAbilityCount()-1 do
			local ability = entity:GetAbilityByIndex(i)
			if ability ~= nil and not ability:IsAttributeBonus() then
				local abilityName = ability:GetAbilityName()
				entity:RemoveAbility(abilityName)
			end
		end
	end
end

---------------------------------------------------------------------------
-- OnGameRulesStateChange
---------------------------------------------------------------------------
function CActualCannibalGameMode:OnGameRulesStateChange(keys)
	local state = GameRules:State_Get()
	acprint("GameRules state became: "..state)

	if state == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
		acprint("DOTA_GAMERULES_STATE_GAME_IN_PROGRESS")

		local playerToAC = RandomInt(0,5)
		playerToAC = 0;
		acprint("  "..PlayerResource:GetPlayerName(playerToAC).." IS THE ACTUAL CANNIBAL")

		for i = 0, PlayerResource:GetPlayerCount()-1 do
			local player = PlayerResource:GetPlayer(i)
			local hero = player:GetAssignedHero()

			-- Turn one random player into the AC
			if player:GetPlayerID() == playerToAC then
				acprint("  putting player "..i.." on team 1 (AC)")
				player:SetTeam(DOTA_TEAM_BADGUYS)
				hero:SetTeam(DOTA_TEAM_BADGUYS)

				hero:AddAbility("actual_cannibal_echoing_howl")
				hero:AddAbility("actual_cannibal_lurking")
				hero:AddAbility("actual_cannibal_noxious_musk")
			-- Turn the rest into campers
			else
				acprint("  putting player "..i.." on team 0 (Campers)")
				player:SetTeam(DOTA_TEAM_GOODGUYS)
				hero:SetTeam(DOTA_TEAM_GOODGUYS)

				--hero:AddAbility("actual_cannibal_echoing_howl")
			end

			for i = 0, hero:GetAbilityCount()-1 do
				local ability = hero:GetAbilityByIndex(i)
				if ability ~= nil and not ability:IsAttributeBonus() then
					hero:UpgradeAbility(ability)
				end
			end

			acprint("  players for team 0 (Campers): "..PlayerResource:GetPlayerCountForTeam(DOTA_TEAM_GOODGUYS))
			acprint("  players for team 1 (AC): "..PlayerResource:GetPlayerCountForTeam(DOTA_TEAM_BADGUYS))
		end
	end

end