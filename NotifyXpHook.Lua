local original = ExperienceManager.mission_xp_award

function ExperienceManager:mission_xp_award(amount)
	original(self, amount)
	
	if managers.hud ~= nil then
	   managers.hud:show_hint({ text = comma_value(amount).." XP gained" })
	end
end

function comma_value(n)
  return tostring(math.floor(n)):reverse():gsub("(%d%d%d)","%1.")
                                :gsub(",(%-?)$","%1"):reverse()
end