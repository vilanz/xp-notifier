
_G.name_of_source = ""
Hooks:PreHook(ElementExperience, "on_executed", "xp_notifier_on_executed", function (self, instigator)
	_G.name_of_source = self._editor_name
end)
