try(destroyDialog ManusVRJSONTool)catch()
rollout ManusVRJSONTool "Manus VR - Export JSON" width:240 height:72
(
	editText lbl_name "Name  " pos:[8,8] width:164 height:16
	checkbox chk_legacy "Legacy" pos:[178,8] width:64 height:16
	button export_json "Export JSON" pos:[8,32] width:224 height:32

	fn fnDateTime datetime = (
		time = getLocalTime()
		year = time[1] as string
		month = time[2] as string
		day = time[4] as string
		hour = time[5] as string
		minute = time[6] as string

		if month.count < 2 do ( month = "0" + month)
		if day.count < 2 do ( day = "0" + day)
		if hour.count < 2 do ( hour = "0" + hour)
		if minute.count < 2 do ( minute = "0" + minute)

		datetime = (year + "/" + month + "/" + day + " " + hour + ":" + minute)
	)

	on ManusVRJSONTool open do
	(
		iterations_default = "10"
		lower_neck_length_default = "0.17"
		upper_neck_length_default = "0.20"
		upper_neck_offset_x_default = "0.00"
		upper_neck_offset_y_default = "0.22"
		upper_neck_offset_z_default = "0.16"

		a = distance $upperarm_r $lowerarm_r
		b = distance $lowerarm_r $hand_r
		c = distance $upperarm_r $upperarm_l
		conversion_array = #(a, b, c)

		units.DisplayType = #Metric
		units.MetricType = #meters

		for i = 1 to conversion_array.count do
		(
			conversion_array[i] = units.formatValue conversion_array[i]
			conversion_array[i] = (substring conversion_array[i] 1 (conversion_array[i].count - 1))
		)

		units.DisplayType = #Generic

		lbl_name.text = fnDateTime datetime
	)

	on export_json pressed do
	(

	legacy = chk_legacy.checked as string

json =
fnDateTime datetime + "
" + legacy + "
line 01
line 02"

		export_file = systemTools.getEnvVariable("AppData") + "/ManusVR/body_test.json"

		out_file = createfile ((export_file))
		format json to:out_file
		close out_file
	)
)

createDialog ManusVRJSONTool