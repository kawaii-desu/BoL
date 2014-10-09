--[[ AUTO UPDATE - START ]]--
local version = "0.02"
local AUTOUPDATE = true
local UPDATE_HOST = "raw.githubusercontent.com"
local UPDATE_PATH = "/kawaii-desu/BoL/master/kawaii-Yi.lua".."?rand="..math.random(1,10000)
local UPDATE_FILE_PATH = LIB_PATH.."kawaii-Yi.lua"
local UPDATE_URL = "https://"..UPDATE_HOST..UPDATE_PATH

function AutoupdaterMsg(msg) print("<font color=\"#6699ff\"><b>kawaii-Yi:</b></font> <font color=\"#FFFFFF\">"..msg..".</font>") end
if AUTOUPDATE then
	local ServerData = GetWebResult(UPDATE_HOST, UPDATE_PATH)
	if ServerData then
		local ServerVersion = string.match(ServerData, "local version = \"%d+.%d+\"")
		ServerVersion = string.match(ServerVersion and ServerVersion or "", "%d+.%d+")
		if ServerVersion then
			ServerVersion = tonumber(ServerVersion)
			if tonumber(version) < ServerVersion then
				AutoupdaterMsg("New version available"..ServerVersion)
				AutoupdaterMsg("Updating, please don't press F9")
				DelayAction(function() DownloadFile(UPDATE_URL, UPDATE_FILE_PATH, function () AutoupdaterMsg("Successfully updated. ("..version.." => "..ServerVersion.."), press F9 twice to load the updated version.") end) end, 3)
			else
				AutoupdaterMsg("You have got the latest version ("..ServerVersion..")")
			end
		end
	else
		AutoupdaterMsg("Error downloading version info")
	end
end
--[[ AUTO UPDATE - END ]]--

--[[ LOCAL'S ETC START ]]--
if myHero.charName ~= "MasterYi" then return end
local ts
require "SxOrbWalk"
--[[ LOCAL'S ETC END ]]--

function OnLoad()
	SxOrb:LoadToMenu()
	Config = scriptConfig("kawaii-Yi", "kawaiiYi")
	Config:addParam("KillSteal", "Kill Steal", SCRIPT_PARAM_ONOFF, true)
	Config:addParam("combo", "Combo", SCRIPT_PARAM_ONKEYDOWN, false, string.byte(" "))
	ts = TargetSelector(TARGET_LOW_HP_PRIORITY,650)
	PrintChat("(^_^) kawaii-Yi loaded")
end

function KillSteal()
	for _, enemy in ipairs(GetEnemyHeroes()) do
		if ValidTarget(enemy) and enemy.visible then
			local qDmg = getDmg("Q", enemy, myHero)
			
				if enemy.health <= qDmg then
					CastSpell(_Q, ts.target)
				end
		end
	end
end

function OnTick()
	ts:update()
	if (Config.KillSteal) then
			KillSteal()
	end
	KillSteal()
	if (ts.target ~= nil) then
		if (Config.combo) then

			if (myHero:CanUseSpell(_Q) == READY) then
				CastSpell(_Q, ts.target)
			end
 
			if (myHero:CanUseSpell(_E) == READY) then
				CastSpell(_E, ts.target.x,ts.target.z)
			end
			
			if (myHero:CanUseSpell(_R) == READY) then
				CastSpell(_R, ts.target.x,ts.target.z)
			end
		end
	end
end

	function OnDraw()
	
	end
