local original = ExperienceManager.mission_xp_award

function ExperienceManager:mission_xp_award(amount)
	original(self, amount)
	
	if managers.hud ~= nil then
	   managers.hud:show_hint({ text = amount.." XP gained" })
	end
end
