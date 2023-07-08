
local key = ModPath .. '	' .. RequiredScript
if _G[key] then return else _G[key] = true end

Hooks:Add('LocalizationManagerPostInit', 'LocalizationManagerPostInit_XPNotifier', function(loc)
	loc:load_localization_file(XPNotifier._path .. 'menu/english.txt', false)
end)

Hooks:Add('MenuManagerInitialize', 'MenuManagerInitialize_XPNotifier', function(menu_manager)
	MenuCallbackHandler.XPNotifierOptionsCheckbox = function(this, item)
		XPNotifier.settings[item:name()] = item:value() == 'on'
	end
	
	MenuCallbackHandler.XPNotifierOptionsSave = function(this, item)
		XPNotifier:Save()
	end

	XPNotifier:Load()

	MenuHelper:LoadFromJsonFile(XPNotifier._path .. 'menu/options.txt', XPNotifier, XPNotifier.settings)
end)
