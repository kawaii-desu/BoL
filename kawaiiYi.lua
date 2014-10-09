--[[

Script Name:
	-inzaneYi
	
Champion:
	-Master Yi
Functions:

	-Move to Mouse
	-Auto Attack
	-Auto Ignite
	-Full Combo: Q > R > E (if in range)

Coded by:
	-kawaii desu
	
Credits:
	-shagratt 	- Awesome Beginner Tutorial
]]--

local version = "0.01"
local AUTOUPDATE = true
local UPDATE_HOST = "raw.github.com"
local UPDATE_PATH = "/kawaii-desu/BoL/master/common/kawaii-Yi.lua".."?rand="..math.random(1,10000)
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

myHero = GetMyHero()
local ts
local idata = nil

function OnLoad()
	version = "0.1"
	PrintChat(version)
				---                                                    MENU
				Config = scriptConfig("Combo", "MasterYi")
				Config:addParam("drawCircle3D", "Draw AA Range", SCRIPT_PARAM_ONOFF, true)
				Config:addParam("ignite", "Auto Ignite", SCRIPT_PARAM_ONOFF, true)
				Config:addParam("attack", "Auto Attack", SCRIPT_PARAM_ONOFF, true)
				Config:addParam("combo", "SBTW Combo", SCRIPT_PARAM_ONKEYDOWN, false,string.byte(" "))
				---                                                    MENU END
	ts = TargetSelector(TARGET_LOW_HP_PRIORITY,650)
	if (myHero.charName == "MasterYi") then
				---                                                    HAS IGNITE?
        if myHero:GetSpellData(SUMMONER_1).name:find("summonerdot") then idata = SUMMONER_1
        elseif myHero:GetSpellData(SUMMONER_2).name:find("summonerdot") then idata = SUMMONER_2
        else idata = nil
        end
				---                                                    HAS IGNITE?
	end
end

function OnTick()
	ts:update()
	---                                                    AUTO IGNITE
				if(Config.ignite) then
				local dmg = 0          
				if idata ~= nil and myHero:CanUseSpell(idata) == READY then
				for i = 1, heroManager.iCount, 1 do
				local target = heroManager:getHero(i)
				if ValidTarget(target) then dmg = 40 + 20 * myHero.level
				if target ~= nil and target.team ~= myHero.team and not target.dead and target.visible and GetDistance(target) < 600 and target.health <= dmg then
				CastSpell(idata, target)
				end end end end end end
	---                                                    AUTO IGNITE
	if (ts.target ~= nil) then -- if Target is near us
		
		if(Config.combo) then -- if Combo is activated = Move to Mouse + AA + Q/E/R
		
				if(Config.attack) then 												-- if AA is active
				if ts.target ~= nil and GetDistance(ts.target) <= 125 then
				myHero:Attack(ts.target)
				end																						-- if AA is active
		
			myHero:MoveTo(mousePos.x, mousePos.z)
			
			if (myHero:CanUseSpell(_Q) == READY) then 		-- if Q is ready
				CastSpell(_Q, ts.target) 										-- cast Q
			end
			
			if (myHero:CanUseSpell(_E) == READY) then 		-- if E is ready
				CastSpell(_E, ts.target) 										-- cast E
			end
			
					if (myHero:CanUseSpell(_R) == READY) then -- if R is ready
				CastSpell(_R, ts.target) 										-- cast R
			end
	end
end

functioon onDraw()
	if (Config.drawCircle3D) then
		DrawCircle3D(myHero.x, myHero.y, myHero.z, 125, 2, 0x111111, 10)
	end
end
