
local total_xp_gained = 0 

local update_original = HUDManager.update
function HUDManager:update(...)
	local new_total_exp = managers.experience:get_xp_dissected(true, 0, true)
	if new_total_exp > total_xp_gained then
		local xp_increase = new_total_exp - total_xp_gained
		total_xp_gained = new_total_exp
		managers.hud:show_hint({
			text = xp_increase.." EXP gained"
		})
	end
	return update_original(self, ...)
end
