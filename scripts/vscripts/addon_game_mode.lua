
if CActualCannibalGameMode == nil then
	_G.CActualCannibalGameMode = class({})
end

---------------------------------------------------------------------------
-- Required .lua files
---------------------------------------------------------------------------
require("utils")
require("event_listeners")

---------------------------------------------------------------------------
--[[
	Precache things we know we'll use.  Possible file types include (but not limited to):
		PrecacheResource( "model", "*.vmdl", context )
		PrecacheResource( "soundfile", "*.vsndevts", context )
		PrecacheResource( "particle", "*.vpcf", context )
		PrecacheResource( "particle_folder", "particles/folder", context )
]]
---------------------------------------------------------------------------
function Precache( context )
	
end

---------------------------------------------------------------------------
-- Create the game mode when we activate
---------------------------------------------------------------------------
function Activate()
	GameRules.ActualCannibalAddon = CActualCannibalGameMode()
	GameRules.ActualCannibalAddon:InitGameMode()
end

function CActualCannibalGameMode:InitGameMode()
	acprint("InitGameMode")

	local GameModeEnt = GameRules:GetGameModeEntity()
	GameModeEnt.CActualCannibalGameMode = self

	GameModeEnt:SetThink("OnThink", self, "GlobalThink", 0)

	-- Set game mode options
	--GameModeEnt:SetHUDVisible(DOTA_HUD_VISIBILITY_TOP_TIMEOFDAY,	false)
	GameModeEnt:SetHUDVisible(DOTA_HUD_VISIBILITY_TOP_HEROES,		false)

	-- Set game rules
	GameRules:SetSameHeroSelectionEnabled(true)
	--GameRules:SetSafeToLeave(true)
	GameRules:SetPreGameTime(5)

	-- Add listeners
	ListenToGameEvent("npc_spawned",				Dynamic_Wrap(CActualCannibalGameMode, "OnNPCSpawned"),	self)
	ListenToGameEvent("game_rules_state_change",	Dynamic_Wrap(CActualCannibalGameMode, "OnGameRulesStateChange"),	self)

end

---------------------------------------------------------------------------
-- Evaluate the state of the game
---------------------------------------------------------------------------
function CActualCannibalGameMode:OnThink()
	if GameRules:State_Get() >= DOTA_GAMERULES_STATE_POST_GAME then
		return nil
	end
	
	GameRules:SetTimeOfDay(0.95)

	local t = GameRules:GetGameTime()
	acprint("Think. t="..t)

	return 10
end