
---------------------------------------------------------------------------
-- Required .lua files
---------------------------------------------------------------------------
require("utils")

---------------------------------------------------------------------------
-- Echoing Howl
---------------------------------------------------------------------------
EchoingHowlVisionRadius = 0

function EchoingHowl_Think(keys)
	EchoingHowlVisionRadius = EchoingHowlVisionRadius + 500
	AddFOWViewer(DOTA_TEAM_BADGUYS, keys.caster:GetOrigin(), EchoingHowlVisionRadius, 0.7, false)
end

function EchoingHowl_Finish(keys)
	--DeepPrintTable(keys)
	EchoingHowlVisionRadius = 0
end

---------------------------------------------------------------------------
-- Lurking
---------------------------------------------------------------------------
function Lurking_Start(keys)
	acprint("Lurking_Start")
end

function Lurking_End(keys)
	acprint("Lurking_End")
end