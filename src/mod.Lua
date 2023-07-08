
local previous_total_xp = 0
local previous_base_xp = 0

Hooks:PreHook(ExperienceManager, "mission_xp_award", "xp_notifier_before_xp_increase", function ()
	if some_manager_is_missing() then return end
	if managers.crime_spree and managers.crime_spree:is_active() then return end
	
	local dissection
	previous_total_xp,dissection = get_current_total_xp()
	previous_base_xp = dissection["base"]
end)

Hooks:PostHook(ExperienceManager, "mission_xp_award", "xp_notifier_after_xp_increase", function ()
	if some_manager_is_missing() then return end
	if managers.crime_spree and managers.crime_spree:is_active() then return end
	
	local new_total_xp,dissection = get_current_total_xp()
	local xp_added = new_total_xp - previous_total_xp
	
	local new_base_xp = dissection["base"]
	local base_xp_added = new_base_xp - previous_base_xp
	
	local notification_text = xp_string(xp_added) .. " XP gained"
	if (XPNotifier.settings.show_total) then
		notification_text = notification_text .. " (Total XP: " .. xp_string(new_total_xp) .. ")"
	end
	if (XPNotifier.settings.show_base) then
		notification_text = notification_text .. " (Base XP: " .. xp_string(base_xp_added)
		if (XPNotifier.settings.show_total) then
			notification_text = notification_text .. "/" .. xp_string(new_base_xp)
		end
		notification_text = notification_text .. ")"
	end
	
	managers.hud:show_hint({ text = notification_text })
	
	if (XPNotifier.settings.debug_log and managers.job:current_real_job_id()) then
		local job_name = managers.localization:text(tweak_data.narrative.jobs[managers.job:current_real_job_id()].name_id)
		--I don't think the commas look good in the log
		log("[XpNotifier] XP added on " .. job_name .. " by " .. _G.name_of_source .. ": " ..
			xp_added .. "/" .. new_total_xp .. " (Base XP: " .. base_xp_added .. "/" .. new_base_xp .. ")")
	end
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
		or managers.hud._hud_hint == nil --this check fixes Goat Sim crash
	if is_missing then
		log("[XpNotifier] There's a manager missing!")
	end
	return is_missing
end

function xp_string(n)
	local formatted = ""
	if (XPNotifier.settings.round_thousands and n >= 1000) then
		formatted = managers.experience:experience_string(math.floor((n+500)/1000)) .. "K"
	else
		formatted = managers.experience:experience_string(n)
	end
	return formatted
end