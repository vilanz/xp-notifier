_G.XPNotifier = _G.XPNotifier or {}
XPNotifier._path = ModPath
XPNotifier._data_path = SavePath .. 'xpnotifier.txt'
XPNotifier.settings = {
	show_total = true,
	show_base = false,
	debug_log = false,
	round_thousands = false
}

function XPNotifier:ResetToDefaultValues()
	XPNotifier.settings = {
		show_total = true,
		show_base = false,
		debug_log = false,
		round_thousands = false
	}
end

function XPNotifier:Load()
	local file = io.open(XPNotifier._data_path, 'r')
	if file then
		for k, v in pairs(json.decode(file:read('*all')) or {}) do
			XPNotifier.settings[k] = v
		end
		file:close()
	end
end

function XPNotifier:Save()
	local file = io.open(XPNotifier._data_path, 'w+')
	if file then
		file:write(json.encode(XPNotifier.settings))
		file:close()
	end
end