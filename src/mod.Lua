
local previous_total_xp = 0
Hooks:PreHook(ExperienceManager, "mission_xp_award", "xp_notifier_before_xp_increase", function ()
	previous_total_xp = get_current_total_xp()
end)

Hooks:PostHook(ExperienceManager, "mission_xp_award", "xp_notifier_after_xp_increase", function ()
	local new_total_xp = get_current_total_xp()
	local xp_added = new_total_xp - previous_total_xp
	
	if managers.hud ~= nil then
		local notification_text = xp_string(xp_added) .. " XP gained (Total XP: " .. xp_string(new_total_xp) .. ")"
		managers.hud:show_hint({ text = notification_text })
	end
end)

function get_current_total_xp()
	local num_alive_players = managers.network:session():amount_of_alive_players()
	return managers.experience:get_xp_dissected(true, num_alive_players, true)
end

function xp_string(n)
	return managers.experience:experience_string(n)
end
