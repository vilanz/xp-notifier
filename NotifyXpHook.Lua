local original = ExperienceManager.mission_xp_award

function ExperienceManager:mission_xp_award(amount)
	original(self, amount)
	
	if managers.hud ~= nil then
	   managers.hud:show_hint({ text = comma_value(amount).." XP gained" })
	end
end

function comma_value(amount)
  local formatted = amount
  while true do  
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1.%2')
    if (k==0) then
      break
    end
  end
  return formatted
end