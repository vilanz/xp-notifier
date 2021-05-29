local original_fn = ExperienceManager.mission_xp_award

function ExperienceManager:mission_xp_award(amount)
	original_fn(self, amount)
	
	if managers.hud ~= nil then
		local xp_gained_text = dot_separated_number(amount) .. " XP gained"
		managers.hud:show_hint({ text = xp_gained_text })
	end	
end

function dot_separated_number(n)
	return tostring(math.floor(n))
		:reverse()
		:gsub("(%d%d%d)","%1.")
		:gsub(",(%-?)$","%1")
		:reverse()
end