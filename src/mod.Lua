
local previous_total_xp = 0
Hooks:PreHook(ExperienceManager, "mission_xp_award", "xp_notifier_before_xp_increase", function ()
	if some_manager_is_missing() then
		return
	end
	previous_total_xp = get_current_total_xp()
end)

Hooks:PostHook(ExperienceManager, "mission_xp_award", "xp_notifier_after_xp_increase", function ()
	if some_manager_is_missing() then
		return
	end
	local new_total_xp = get_current_total_xp()
	local xp_added = new_total_xp - previous_total_xp

	local notification_text = xp_string(xp_added) .. " XP gained (Total XP: " .. xp_string(new_total_xp) .. ")"
	managers.hud:show_hint({ text = notification_text })
end)

function get_current_total_xp()
	local mission_not_failed = true -- always will be since we're ingame
	local num_alive_players = managers.network:session():amount_of_alive_players()
	local is_not_in_custody = not Utils:IsInCustody()
	return managers.experience:get_xp_dissected(
		mission_not_failed, num_alive_players, is_not_in_custody
	)
end

function some_manager_is_missing()
	-- in some edge cases some managers might be nil
	-- since this is just a mod and we don't want to crash the game, just don't run anything
	local is_missing = managers.network == nil
		or managers.experience == nil
		or managers.hud == nil
	if is_missing then
		log("[XpNotifier] There's a manager missing!")
	end
	return 
end

function xp_string(n)
	return managers.experience:experience_string(n)
end
