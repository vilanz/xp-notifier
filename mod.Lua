local total_xp = 0 -- Create variables outside the hook, so we dont recreate them every hookcall
local notification_text = ""

function xp_string(n)
	if managers.experience ~= nil then -- Check for null/nil so we dont crash
	   return managers.experience:experience_string(n)
	else 
	   return n
	end
end

Hooks:PostHook(ExperienceManager, "mission_xp_award", "xp_notifier_after_xp_increase", function(self, amount)
	total_xp = total_xp + amount
	
	notification_text = xp_string(amount) .. " XP gained (Total XP: " .. xp_string(total_xp) .. ")"
	
	if managers.hud ~= nil then
	   managers.hud:show_hint({ text = notification_text })
	end
end)
