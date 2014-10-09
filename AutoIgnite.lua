--[[

Not sure if that works tho!

]]--

function OnLoad()

end

function OnTick()
				if(Config.ignite) then
				local dmg = 0          
				if idata ~= nil and myHero:CanUseSpell(idata) == READY then
				for i = 1, heroManager.iCount, 1 do
				local target = heroManager:getHero(i)
				if ValidTarget(target) then dmg = 40 + 20 * myHero.level
				if target ~= nil and target.team ~= myHero.team and not target.dead and target.visible and GetDistance(target) < 600 and target.health <= dmg then
				CastSpell(idata, target)
				end
				end
				end
				end
				end
				end
end
