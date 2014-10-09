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
