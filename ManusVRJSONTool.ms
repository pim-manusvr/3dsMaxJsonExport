try(destroyDialog ManusVRJSONTool)catch()
rollout ManusVRJSONTool "Manus VR - Export JSON" width:240 height:72
(
	editText lbl_name "Name: " pos:[8,8] width:164 height:16
	checkbox chk_legacy "Legacy" pos:[178,8] width:64 height:16 checked:false
	button export_json "Export JSON" pos:[8,32] width:224 height:32

	global ManusVRJSONToolVersion = "Manus VR - JSON Tool 0.1 alpha"

	global bones_array

	global json

	global iterations_default
	global lower_neck_length_default
	global upper_neck_length_default
	global upper_neck_offset_x_legacy_default
	global upper_neck_offset_y_legacy_default
	global upper_neck_offset_z_legacy_default
	global upper_neck_offset_x_default
	global upper_neck_offset_y_default
	global upper_neck_offset_z_default
	global upper_arm_length_calculated
	global lower_arm_length_calculated
	global shoulder_length_calculated
	global conversion_array
	global export_file
	global out_file

	global bonesmissing = false

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

	fn fnCheckBones = (
		global bones_array = #($hand_l, $hand_r, $thumb_01_l, $thumb_01_r, $thumb_02_l, $thumb_02_r, $thumb_03_l, $thumb_03_r, $index_01_l, $index_01_r, $index_02_l, $index_02_r, $index_03_l, $index_03_r, $middle_01_l, $middle_01_r, $middle_02_l, $middle_02_r, $middle_03_l, $middle_03_r, $ring_01_l, $ring_01_r, $ring_02_l, $ring_02_r, $ring_03_l, $ring_03_r, $pinky_01_l, $pinky_01_r, $pinky_02_l, $pinky_02_r, $pinky_03_l, $pinky_03_r)

		for i = 1 to bones_array.count do
		(
			if bones_array[i] == undefined then 
			(
				bonesmissing = true
			)
		)
	)

	fn fnGetQuaternionsOpen = (
		-- Set animation to start frame
		sliderTime = animationRange.start.frame

		-- Wrist
		-- Left
		global wrist_l_rotation_x_start = $hand_l.rotation.controller.value.x as string
		global wrist_l_rotation_y_start = $hand_l.rotation.controller.value.y as string
		global wrist_l_rotation_z_start = $hand_l.rotation.controller.value.z as string
		global wrist_l_rotation_w_start = $hand_l.rotation.controller.value.w as string
		-- Right
		global wrist_r_rotation_x_start = $hand_r.rotation.controller.value.x as string
		global wrist_r_rotation_y_start = $hand_r.rotation.controller.value.y as string
		global wrist_r_rotation_z_start = $hand_r.rotation.controller.value.z as string
		global wrist_r_rotation_w_start = $hand_r.rotation.controller.value.w as string

		-- rotation_0 rotations
		-- thumb
		-- thumb_01_start
		-- Left
		global thumb_01_l_rotation_x_start = $thumb_01_l.rotation.controller.value.x as string
		global thumb_01_l_rotation_y_start = $thumb_01_l.rotation.controller.value.y as string
		global thumb_01_l_rotation_z_start = $thumb_01_l.rotation.controller.value.z as string
		global thumb_01_l_rotation_w_start = $thumb_01_l.rotation.controller.value.w as string
		-- Right
		global thumb_01_r_rotation_x_start = $thumb_01_r.rotation.controller.value.x as string
		global thumb_01_r_rotation_y_start = $thumb_01_r.rotation.controller.value.y as string
		global thumb_01_r_rotation_z_start = $thumb_01_r.rotation.controller.value.z as string
		global thumb_01_r_rotation_w_start = $thumb_01_r.rotation.controller.value.w as string

		-- thumb_02_start
		-- Left
		global thumb_02_l_rotation_x_start = $thumb_02_l.rotation.controller.value.x as string
		global thumb_02_l_rotation_y_start = $thumb_02_l.rotation.controller.value.y as string
		global thumb_02_l_rotation_z_start = $thumb_02_l.rotation.controller.value.z as string
		global thumb_02_l_rotation_w_start = $thumb_02_l.rotation.controller.value.w as string
		-- Right
		global thumb_02_r_rotation_x_start = $thumb_02_r.rotation.controller.value.x as string
		global thumb_02_r_rotation_y_start = $thumb_02_r.rotation.controller.value.y as string
		global thumb_02_r_rotation_z_start = $thumb_02_r.rotation.controller.value.z as string
		global thumb_02_r_rotation_w_start = $thumb_02_r.rotation.controller.value.w as string

		-- thumb_03_start
		-- Left
		global thumb_03_l_rotation_x_start = $thumb_03_l.rotation.controller.value.x as string
		global thumb_03_l_rotation_y_start = $thumb_03_l.rotation.controller.value.y as string
		global thumb_03_l_rotation_z_start = $thumb_03_l.rotation.controller.value.z as string
		global thumb_03_l_rotation_w_start = $thumb_03_l.rotation.controller.value.w as string
		-- Right
		global thumb_03_r_rotation_x_start = $thumb_03_r.rotation.controller.value.x as string
		global thumb_03_r_rotation_y_start = $thumb_03_r.rotation.controller.value.y as string
		global thumb_03_r_rotation_z_start = $thumb_03_r.rotation.controller.value.z as string
		global thumb_03_r_rotation_w_start = $thumb_03_r.rotation.controller.value.w as string

		-- index
		-- index_01_start
		-- Left
		global index_01_l_rotation_x_start = $index_01_l.rotation.controller.value.x as string
		global index_01_l_rotation_y_start = $index_01_l.rotation.controller.value.y as string
		global index_01_l_rotation_z_start = $index_01_l.rotation.controller.value.z as string
		global index_01_l_rotation_w_start = $index_01_l.rotation.controller.value.w as string
		-- Right
		global index_01_r_rotation_x_start = $index_01_r.rotation.controller.value.x as string
		global index_01_r_rotation_y_start = $index_01_r.rotation.controller.value.y as string
		global index_01_r_rotation_z_start = $index_01_r.rotation.controller.value.z as string
		global index_01_r_rotation_w_start = $index_01_r.rotation.controller.value.w as string

		-- index_02_start
		-- Left
		global index_02_l_rotation_x_start = $index_02_l.rotation.controller.value.x as string
		global index_02_l_rotation_y_start = $index_02_l.rotation.controller.value.y as string
		global index_02_l_rotation_z_start = $index_02_l.rotation.controller.value.z as string
		global index_02_l_rotation_w_start = $index_02_l.rotation.controller.value.w as string
		-- Right
		global index_02_r_rotation_x_start = $index_02_r.rotation.controller.value.x as string
		global index_02_r_rotation_y_start = $index_02_r.rotation.controller.value.y as string
		global index_02_r_rotation_z_start = $index_02_r.rotation.controller.value.z as string
		global index_02_r_rotation_w_start = $index_02_r.rotation.controller.value.w as string

		-- index_03_start
		-- Left
		global index_03_l_rotation_x_start = $index_03_l.rotation.controller.value.x as string
		global index_03_l_rotation_y_start = $index_03_l.rotation.controller.value.y as string
		global index_03_l_rotation_z_start = $index_03_l.rotation.controller.value.z as string
		global index_03_l_rotation_w_start = $index_03_l.rotation.controller.value.w as string
		-- Right
		global index_03_r_rotation_x_start = $index_03_r.rotation.controller.value.x as string
		global index_03_r_rotation_y_start = $index_03_r.rotation.controller.value.y as string
		global index_03_r_rotation_z_start = $index_03_r.rotation.controller.value.z as string
		global index_03_r_rotation_w_start = $index_03_r.rotation.controller.value.w as string

		-- middle
		-- middle_01_start
		-- Left
		global middle_01_l_rotation_x_start = $middle_01_l.rotation.controller.value.x as string
		global middle_01_l_rotation_y_start = $middle_01_l.rotation.controller.value.y as string
		global middle_01_l_rotation_z_start = $middle_01_l.rotation.controller.value.z as string
		global middle_01_l_rotation_w_start = $middle_01_l.rotation.controller.value.w as string
		-- Right
		global middle_01_r_rotation_x_start = $middle_01_r.rotation.controller.value.x as string
		global middle_01_r_rotation_y_start = $middle_01_r.rotation.controller.value.y as string
		global middle_01_r_rotation_z_start = $middle_01_r.rotation.controller.value.z as string
		global middle_01_r_rotation_w_start = $middle_01_r.rotation.controller.value.w as string

		-- middle_02_start
		-- Left
		global middle_02_l_rotation_x_start = $middle_02_l.rotation.controller.value.x as string
		global middle_02_l_rotation_y_start = $middle_02_l.rotation.controller.value.y as string
		global middle_02_l_rotation_z_start = $middle_02_l.rotation.controller.value.z as string
		global middle_02_l_rotation_w_start = $middle_02_l.rotation.controller.value.w as string
		-- Right
		global middle_02_r_rotation_x_start = $middle_02_r.rotation.controller.value.x as string
		global middle_02_r_rotation_y_start = $middle_02_r.rotation.controller.value.y as string
		global middle_02_r_rotation_z_start = $middle_02_r.rotation.controller.value.z as string
		global middle_02_r_rotation_w_start = $middle_02_r.rotation.controller.value.w as string

		-- middle_03_start
		-- Left
		global middle_03_l_rotation_x_start = $middle_03_l.rotation.controller.value.x as string
		global middle_03_l_rotation_y_start = $middle_03_l.rotation.controller.value.y as string
		global middle_03_l_rotation_z_start = $middle_03_l.rotation.controller.value.z as string
		global middle_03_l_rotation_w_start = $middle_03_l.rotation.controller.value.w as string
		-- Right
		global middle_03_r_rotation_x_start = $middle_03_r.rotation.controller.value.x as string
		global middle_03_r_rotation_y_start = $middle_03_r.rotation.controller.value.y as string
		global middle_03_r_rotation_z_start = $middle_03_r.rotation.controller.value.z as string
		global middle_03_r_rotation_w_start = $middle_03_r.rotation.controller.value.w as string

		-- ring
		-- ring_01_start
		-- Left
		global ring_01_l_rotation_x_start = $ring_01_l.rotation.controller.value.x as string
		global ring_01_l_rotation_y_start = $ring_01_l.rotation.controller.value.y as string
		global ring_01_l_rotation_z_start = $ring_01_l.rotation.controller.value.z as string
		global ring_01_l_rotation_w_start = $ring_01_l.rotation.controller.value.w as string
		-- Right
		global ring_01_r_rotation_x_start = $ring_01_r.rotation.controller.value.x as string
		global ring_01_r_rotation_y_start = $ring_01_r.rotation.controller.value.y as string
		global ring_01_r_rotation_z_start = $ring_01_r.rotation.controller.value.z as string
		global ring_01_r_rotation_w_start = $ring_01_r.rotation.controller.value.w as string

		-- ring_02_start
		-- Left
		global ring_02_l_rotation_x_start = $ring_02_l.rotation.controller.value.x as string
		global ring_02_l_rotation_y_start = $ring_02_l.rotation.controller.value.y as string
		global ring_02_l_rotation_z_start = $ring_02_l.rotation.controller.value.z as string
		global ring_02_l_rotation_w_start = $ring_02_l.rotation.controller.value.w as string
		-- Right
		global ring_02_r_rotation_x_start = $ring_02_r.rotation.controller.value.x as string
		global ring_02_r_rotation_y_start = $ring_02_r.rotation.controller.value.y as string
		global ring_02_r_rotation_z_start = $ring_02_r.rotation.controller.value.z as string
		global ring_02_r_rotation_w_start = $ring_02_r.rotation.controller.value.w as string

		-- ring_03_start
		-- Left
		global ring_03_l_rotation_x_start = $ring_03_l.rotation.controller.value.x as string
		global ring_03_l_rotation_y_start = $ring_03_l.rotation.controller.value.y as string
		global ring_03_l_rotation_z_start = $ring_03_l.rotation.controller.value.z as string
		global ring_03_l_rotation_w_start = $ring_03_l.rotation.controller.value.w as string
		-- Right
		global ring_03_r_rotation_x_start = $ring_03_r.rotation.controller.value.x as string
		global ring_03_r_rotation_y_start = $ring_03_r.rotation.controller.value.y as string
		global ring_03_r_rotation_z_start = $ring_03_r.rotation.controller.value.z as string
		global ring_03_r_rotation_w_start = $ring_03_r.rotation.controller.value.w as string

		-- pinky
		-- pinky_01_start
		-- Left
		global pinky_01_l_rotation_x_start = $pinky_01_l.rotation.controller.value.x as string
		global pinky_01_l_rotation_y_start = $pinky_01_l.rotation.controller.value.y as string
		global pinky_01_l_rotation_z_start = $pinky_01_l.rotation.controller.value.z as string
		global pinky_01_l_rotation_w_start = $pinky_01_l.rotation.controller.value.w as string
		-- Right
		global pinky_01_r_rotation_x_start = $pinky_01_r.rotation.controller.value.x as string
		global pinky_01_r_rotation_y_start = $pinky_01_r.rotation.controller.value.y as string
		global pinky_01_r_rotation_z_start = $pinky_01_r.rotation.controller.value.z as string
		global pinky_01_r_rotation_w_start = $pinky_01_r.rotation.controller.value.w as string

		-- pinky_02_start
		-- Left
		global pinky_02_l_rotation_x_start = $pinky_02_l.rotation.controller.value.x as string
		global pinky_02_l_rotation_y_start = $pinky_02_l.rotation.controller.value.y as string
		global pinky_02_l_rotation_z_start = $pinky_02_l.rotation.controller.value.z as string
		global pinky_02_l_rotation_w_start = $pinky_02_l.rotation.controller.value.w as string
		-- Right
		global pinky_02_r_rotation_x_start = $pinky_02_r.rotation.controller.value.x as string
		global pinky_02_r_rotation_y_start = $pinky_02_r.rotation.controller.value.y as string
		global pinky_02_r_rotation_z_start = $pinky_02_r.rotation.controller.value.z as string
		global pinky_02_r_rotation_w_start = $pinky_02_r.rotation.controller.value.w as string

		-- pinky_03_start
		-- Left
		global pinky_03_l_rotation_x_start = $pinky_03_l.rotation.controller.value.x as string
		global pinky_03_l_rotation_y_start = $pinky_03_l.rotation.controller.value.y as string
		global pinky_03_l_rotation_z_start = $pinky_03_l.rotation.controller.value.z as string
		global pinky_03_l_rotation_w_start = $pinky_03_l.rotation.controller.value.w as string
		-- Right
		global pinky_03_r_rotation_x_start = $pinky_03_r.rotation.controller.value.x as string
		global pinky_03_r_rotation_y_start = $pinky_03_r.rotation.controller.value.y as string
		global pinky_03_r_rotation_z_start = $pinky_03_r.rotation.controller.value.z as string
		global pinky_03_r_rotation_w_start = $pinky_03_r.rotation.controller.value.w as string 
	)

	fn fnGetQuaternionsClosed = (
		-- Set animation to end frame
		sliderTime = animationRange.end.frame

		-- rotation_1 rotations
		-- thumb
		-- thumb_01_end
		-- Left
		global thumb_01_l_rotation_x_end = $thumb_01_l.rotation.controller.value.x as string
		global thumb_01_l_rotation_y_end = $thumb_01_l.rotation.controller.value.y as string
		global thumb_01_l_rotation_z_end = $thumb_01_l.rotation.controller.value.z as string
		global thumb_01_l_rotation_w_end = $thumb_01_l.rotation.controller.value.w as string
		-- Right
		global thumb_01_r_rotation_x_end = $thumb_01_r.rotation.controller.value.x as string
		global thumb_01_r_rotation_y_end = $thumb_01_r.rotation.controller.value.y as string
		global thumb_01_r_rotation_z_end = $thumb_01_r.rotation.controller.value.z as string
		global thumb_01_r_rotation_w_end = $thumb_01_r.rotation.controller.value.w as string

		-- thumb_02_end
		-- Left
		global thumb_02_l_rotation_x_end = $thumb_02_l.rotation.controller.value.x as string
		global thumb_02_l_rotation_y_end = $thumb_02_l.rotation.controller.value.y as string
		global thumb_02_l_rotation_z_end = $thumb_02_l.rotation.controller.value.z as string
		global thumb_02_l_rotation_w_end = $thumb_02_l.rotation.controller.value.w as string
		-- Right
		global thumb_02_r_rotation_x_end = $thumb_02_r.rotation.controller.value.x as string
		global thumb_02_r_rotation_y_end = $thumb_02_r.rotation.controller.value.y as string
		global thumb_02_r_rotation_z_end = $thumb_02_r.rotation.controller.value.z as string
		global thumb_02_r_rotation_w_end = $thumb_02_r.rotation.controller.value.w as string

		-- thumb_03_end
		-- Left
		global thumb_03_l_rotation_x_end = $thumb_03_l.rotation.controller.value.x as string
		global thumb_03_l_rotation_y_end = $thumb_03_l.rotation.controller.value.y as string
		global thumb_03_l_rotation_z_end = $thumb_03_l.rotation.controller.value.z as string
		global thumb_03_l_rotation_w_end = $thumb_03_l.rotation.controller.value.w as string
		-- Right
		global thumb_03_r_rotation_x_end = $thumb_03_r.rotation.controller.value.x as string
		global thumb_03_r_rotation_y_end = $thumb_03_r.rotation.controller.value.y as string
		global thumb_03_r_rotation_z_end = $thumb_03_r.rotation.controller.value.z as string
		global thumb_03_r_rotation_w_end = $thumb_03_r.rotation.controller.value.w as string

		-- index
		-- index_01_end
		-- Left
		global index_01_l_rotation_x_end = $index_01_l.rotation.controller.value.x as string
		global index_01_l_rotation_y_end = $index_01_l.rotation.controller.value.y as string
		global index_01_l_rotation_z_end = $index_01_l.rotation.controller.value.z as string
		global index_01_l_rotation_w_end = $index_01_l.rotation.controller.value.w as string
		-- Right
		global index_01_r_rotation_x_end = $index_01_r.rotation.controller.value.x as string
		global index_01_r_rotation_y_end = $index_01_r.rotation.controller.value.y as string
		global index_01_r_rotation_z_end = $index_01_r.rotation.controller.value.z as string
		global index_01_r_rotation_w_end = $index_01_r.rotation.controller.value.w as string

		-- index_02_end
		-- Left
		global index_02_l_rotation_x_end = $index_02_l.rotation.controller.value.x as string
		global index_02_l_rotation_y_end = $index_02_l.rotation.controller.value.y as string
		global index_02_l_rotation_z_end = $index_02_l.rotation.controller.value.z as string
		global index_02_l_rotation_w_end = $index_02_l.rotation.controller.value.w as string
		-- Right
		global index_02_r_rotation_x_end = $index_02_r.rotation.controller.value.x as string
		global index_02_r_rotation_y_end = $index_02_r.rotation.controller.value.y as string
		global index_02_r_rotation_z_end = $index_02_r.rotation.controller.value.z as string
		global index_02_r_rotation_w_end = $index_02_r.rotation.controller.value.w as string

		-- index_03_end
		-- Left
		global index_03_l_rotation_x_end = $index_03_l.rotation.controller.value.x as string
		global index_03_l_rotation_y_end = $index_03_l.rotation.controller.value.y as string
		global index_03_l_rotation_z_end = $index_03_l.rotation.controller.value.z as string
		global index_03_l_rotation_w_end = $index_03_l.rotation.controller.value.w as string
		-- Right
		global index_03_r_rotation_x_end = $index_03_r.rotation.controller.value.x as string
		global index_03_r_rotation_y_end = $index_03_r.rotation.controller.value.y as string
		global index_03_r_rotation_z_end = $index_03_r.rotation.controller.value.z as string
		global index_03_r_rotation_w_end = $index_03_r.rotation.controller.value.w as string

		-- middle
		-- middle_01_end
		-- Left
		global middle_01_l_rotation_x_end = $middle_01_l.rotation.controller.value.x as string
		global middle_01_l_rotation_y_end = $middle_01_l.rotation.controller.value.y as string
		global middle_01_l_rotation_z_end = $middle_01_l.rotation.controller.value.z as string
		global middle_01_l_rotation_w_end = $middle_01_l.rotation.controller.value.w as string
		-- Right
		global middle_01_r_rotation_x_end = $middle_01_r.rotation.controller.value.x as string
		global middle_01_r_rotation_y_end = $middle_01_r.rotation.controller.value.y as string
		global middle_01_r_rotation_z_end = $middle_01_r.rotation.controller.value.z as string
		global middle_01_r_rotation_w_end = $middle_01_r.rotation.controller.value.w as string

		-- middle_02_end
		-- Left
		global middle_02_l_rotation_x_end = $middle_02_l.rotation.controller.value.x as string
		global middle_02_l_rotation_y_end = $middle_02_l.rotation.controller.value.y as string
		global middle_02_l_rotation_z_end = $middle_02_l.rotation.controller.value.z as string
		global middle_02_l_rotation_w_end = $middle_02_l.rotation.controller.value.w as string
		-- Right
		global middle_02_r_rotation_x_end = $middle_02_r.rotation.controller.value.x as string
		global middle_02_r_rotation_y_end = $middle_02_r.rotation.controller.value.y as string
		global middle_02_r_rotation_z_end = $middle_02_r.rotation.controller.value.z as string
		global middle_02_r_rotation_w_end = $middle_02_r.rotation.controller.value.w as string

		-- middle_03_end
		-- Left
		global middle_03_l_rotation_x_end = $middle_03_l.rotation.controller.value.x as string
		global middle_03_l_rotation_y_end = $middle_03_l.rotation.controller.value.y as string
		global middle_03_l_rotation_z_end = $middle_03_l.rotation.controller.value.z as string
		global middle_03_l_rotation_w_end = $middle_03_l.rotation.controller.value.w as string
		-- Right
		global middle_03_r_rotation_x_end = $middle_03_r.rotation.controller.value.x as string
		global middle_03_r_rotation_y_end = $middle_03_r.rotation.controller.value.y as string
		global middle_03_r_rotation_z_end = $middle_03_r.rotation.controller.value.z as string
		global middle_03_r_rotation_w_end = $middle_03_r.rotation.controller.value.w as string

		-- ring
		-- ring_01_end
		-- Left
		global ring_01_l_rotation_x_end = $ring_01_l.rotation.controller.value.x as string
		global ring_01_l_rotation_y_end = $ring_01_l.rotation.controller.value.y as string
		global ring_01_l_rotation_z_end = $ring_01_l.rotation.controller.value.z as string
		global ring_01_l_rotation_w_end = $ring_01_l.rotation.controller.value.w as string
		-- Right
		global ring_01_r_rotation_x_end = $ring_01_r.rotation.controller.value.x as string
		global ring_01_r_rotation_y_end = $ring_01_r.rotation.controller.value.y as string
		global ring_01_r_rotation_z_end = $ring_01_r.rotation.controller.value.z as string
		global ring_01_r_rotation_w_end = $ring_01_r.rotation.controller.value.w as string

		-- ring_02_end
		-- Left
		global ring_02_l_rotation_x_end = $ring_02_l.rotation.controller.value.x as string
		global ring_02_l_rotation_y_end = $ring_02_l.rotation.controller.value.y as string
		global ring_02_l_rotation_z_end = $ring_02_l.rotation.controller.value.z as string
		global ring_02_l_rotation_w_end = $ring_02_l.rotation.controller.value.w as string
		-- Right
		global ring_02_r_rotation_x_end = $ring_02_r.rotation.controller.value.x as string
		global ring_02_r_rotation_y_end = $ring_02_r.rotation.controller.value.y as string
		global ring_02_r_rotation_z_end = $ring_02_r.rotation.controller.value.z as string
		global ring_02_r_rotation_w_end = $ring_02_r.rotation.controller.value.w as string

		-- ring_03_end
		-- Left
		global ring_03_l_rotation_x_end = $ring_03_l.rotation.controller.value.x as string
		global ring_03_l_rotation_y_end = $ring_03_l.rotation.controller.value.y as string
		global ring_03_l_rotation_z_end = $ring_03_l.rotation.controller.value.z as string
		global ring_03_l_rotation_w_end = $ring_03_l.rotation.controller.value.w as string
		-- Right
		global ring_03_r_rotation_x_end = $ring_03_r.rotation.controller.value.x as string
		global ring_03_r_rotation_y_end = $ring_03_r.rotation.controller.value.y as string
		global ring_03_r_rotation_z_end = $ring_03_r.rotation.controller.value.z as string
		global ring_03_r_rotation_w_end = $ring_03_r.rotation.controller.value.w as string

		-- pinky
		-- pinky_01_end
		-- Left
		global pinky_01_l_rotation_x_end = $pinky_01_l.rotation.controller.value.x as string
		global pinky_01_l_rotation_y_end = $pinky_01_l.rotation.controller.value.y as string
		global pinky_01_l_rotation_z_end = $pinky_01_l.rotation.controller.value.z as string
		global pinky_01_l_rotation_w_end = $pinky_01_l.rotation.controller.value.w as string
		-- Right
		global pinky_01_r_rotation_x_end = $pinky_01_r.rotation.controller.value.x as string
		global pinky_01_r_rotation_y_end = $pinky_01_r.rotation.controller.value.y as string
		global pinky_01_r_rotation_z_end = $pinky_01_r.rotation.controller.value.z as string
		global pinky_01_r_rotation_w_end = $pinky_01_r.rotation.controller.value.w as string

		-- pinky_02_end
		-- Left
		global pinky_02_l_rotation_x_end = $pinky_02_l.rotation.controller.value.x as string
		global pinky_02_l_rotation_y_end = $pinky_02_l.rotation.controller.value.y as string
		global pinky_02_l_rotation_z_end = $pinky_02_l.rotation.controller.value.z as string
		global pinky_02_l_rotation_w_end = $pinky_02_l.rotation.controller.value.w as string
		-- Right
		global pinky_02_r_rotation_x_end = $pinky_02_r.rotation.controller.value.x as string
		global pinky_02_r_rotation_y_end = $pinky_02_r.rotation.controller.value.y as string
		global pinky_02_r_rotation_z_end = $pinky_02_r.rotation.controller.value.z as string
		global pinky_02_r_rotation_w_end = $pinky_02_r.rotation.controller.value.w as string

		-- pinky_03_end
		-- Left
		global pinky_03_l_rotation_x_end = $pinky_03_l.rotation.controller.value.x as string
		global pinky_03_l_rotation_y_end = $pinky_03_l.rotation.controller.value.y as string
		global pinky_03_l_rotation_z_end = $pinky_03_l.rotation.controller.value.z as string
		global pinky_03_l_rotation_w_end = $pinky_03_l.rotation.controller.value.w as string
		-- Right
		global pinky_03_r_rotation_x_end = $pinky_03_r.rotation.controller.value.x as string
		global pinky_03_r_rotation_y_end = $pinky_03_r.rotation.controller.value.y as string
		global pinky_03_r_rotation_z_end = $pinky_03_r.rotation.controller.value.z as string
		global pinky_03_r_rotation_w_end = $pinky_03_r.rotation.controller.value.w as string 

		-- Set animation to start frame
		sliderTime = animationRange.start.frame
	)

	fn fnJSONLegacy = (
		json =
"{
	\"Left\": {
		\"wrist\": [
			{
				\"joint\": \"hand_l\",
				\"translation\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0
				},
				\"rotation_0\": {
					\"x\": " + wrist_l_rotation_x_start + ",
					\"y\": " + wrist_l_rotation_y_start + ",
					\"z\": " + wrist_l_rotation_z_start + ",
					\"w\": " + wrist_l_rotation_w_start + "
				},
				\"rotation_1\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0,
					\"w\": 1
				}
			}
		],
		\"thumb\": [
			{
				\"joint\": \"thumb_00_l\",
				\"translation\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0
				},
				\"rotation_0\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0,
					\"w\": 1
				},
				\"rotation_1\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0,
					\"w\": 1
				}
			},
			{
				\"joint\": \"thumb_01_l\",
				\"translation\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0
				},
				\"rotation_0\": {
					\"x\": " + thumb_01_l_rotation_x_start + ",
					\"y\": " + thumb_01_l_rotation_y_start + ",
					\"z\": " + thumb_01_l_rotation_z_start + ",
					\"w\": " + thumb_01_l_rotation_w_start + "
				},
				\"rotation_1\": {
					\"x\": " + thumb_01_l_rotation_x_end + ",
					\"y\": " + thumb_01_l_rotation_y_end + ",
					\"z\": " + thumb_01_l_rotation_z_end + ",
					\"w\": " + thumb_01_l_rotation_w_end + "
				}
			},
			{
				\"joint\": \"thumb_02_l\",
				\"translation\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0
				},
				\"rotation_0\": {
					\"x\": " + thumb_02_l_rotation_x_start + ",
					\"y\": " + thumb_02_l_rotation_y_start + ",
					\"z\": " + thumb_02_l_rotation_z_start + ",
					\"w\": " + thumb_02_l_rotation_w_start + "
				},
				\"rotation_1\": {
					\"x\": " + thumb_02_l_rotation_x_end + ",
					\"y\": " + thumb_02_l_rotation_y_end + ",
					\"z\": " + thumb_02_l_rotation_z_end + ",
					\"w\": " + thumb_02_l_rotation_w_end + "
				}
			},
			{
				\"joint\": \"thumb_03_l\",
				\"translation\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0
				},
				\"rotation_0\": {
					\"x\": " + thumb_03_l_rotation_x_start + ",
					\"y\": " + thumb_03_l_rotation_y_start + ",
					\"z\": " + thumb_03_l_rotation_z_start + ",
					\"w\": " + thumb_03_l_rotation_w_start + "
				},
				\"rotation_1\": {
					\"x\": " + thumb_03_l_rotation_x_end + ",
					\"y\": " + thumb_03_l_rotation_y_end + ",
					\"z\": " + thumb_03_l_rotation_z_end + ",
					\"w\": " + thumb_03_l_rotation_w_end + "
				}
			},
			{
				\"joint\": \"thumb_04_l\",
				\"translation\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0
				},
				\"rotation_0\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0,
					\"w\": 1
				},
				\"rotation_1\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0,
					\"w\": 1
				}
			}
		],
		\"index\": [
			{
				\"joint\": \"index_00_l\",
				\"translation\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0
				},
				\"rotation_0\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0,
					\"w\": 1
				},
				\"rotation_1\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0,
					\"w\": 1
				}
			},
			{
				\"joint\": \"index_01_l\",
				\"translation\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0
				},
				\"rotation_0\": {
					\"x\": " + index_01_l_rotation_x_start + ",
					\"y\": " + index_01_l_rotation_y_start + ",
					\"z\": " + index_01_l_rotation_z_start + ",
					\"w\": " + index_01_l_rotation_w_start + "
				},
				\"rotation_1\": {
					\"x\": " + index_01_l_rotation_x_end + ",
					\"y\": " + index_01_l_rotation_y_end + ",
					\"z\": " + index_01_l_rotation_z_end + ",
					\"w\": " + index_01_l_rotation_w_end + "
				}
			},
			{
				\"joint\": \"index_02_l\",
				\"translation\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0
				},
				\"rotation_0\": {
					\"x\": " + index_02_l_rotation_x_start + ",
					\"y\": " + index_02_l_rotation_y_start + ",
					\"z\": " + index_02_l_rotation_z_start + ",
					\"w\": " + index_02_l_rotation_w_start + "
				},
				\"rotation_1\": {
					\"x\": " + index_02_l_rotation_x_end + ",
					\"y\": " + index_02_l_rotation_y_end + ",
					\"z\": " + index_02_l_rotation_z_end + ",
					\"w\": " + index_02_l_rotation_w_end + "
				}
			},
			{
				\"joint\": \"index_03_l\",
				\"translation\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0
				},
				\"rotation_0\": {
					\"x\": " + index_03_l_rotation_x_start + ",
					\"y\": " + index_03_l_rotation_y_start + ",
					\"z\": " + index_03_l_rotation_z_start + ",
					\"w\": " + index_03_l_rotation_w_start + "
				},
				\"rotation_1\": {
					\"x\": " + index_03_l_rotation_x_end + ",
					\"y\": " + index_03_l_rotation_y_end + ",
					\"z\": " + index_03_l_rotation_z_end + ",
					\"w\": " + index_03_l_rotation_w_end + "
				}
			},
			{
				\"joint\": \"index_04_l\",
				\"translation\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0
				},
				\"rotation_0\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0,
					\"w\": 1
				},
				\"rotation_1\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0,
					\"w\": 1
				}
			}
		],
		\"middle\": [
			{
				\"joint\": \"middle_00_l\",
				\"translation\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0
				},
				\"rotation_0\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0,
					\"w\": 1
				},
				\"rotation_1\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0,
					\"w\": 1
				}
			},
			{
				\"joint\": \"middle_01_l\",
				\"translation\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0
				},
				\"rotation_0\": {
					\"x\": " + middle_01_l_rotation_x_start + ",
					\"y\": " + middle_01_l_rotation_y_start + ",
					\"z\": " + middle_01_l_rotation_z_start + ",
					\"w\": " + middle_01_l_rotation_w_start + "
				},
				\"rotation_1\": {
					\"x\": " + middle_01_l_rotation_x_end + ",
					\"y\": " + middle_01_l_rotation_y_end + ",
					\"z\": " + middle_01_l_rotation_z_end + ",
					\"w\": " + middle_01_l_rotation_w_end + "
				}
			},
			{
				\"joint\": \"middle_02_l\",
				\"translation\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0
				},
				\"rotation_0\": {
					\"x\": " + middle_02_l_rotation_x_start + ",
					\"y\": " + middle_02_l_rotation_y_start + ",
					\"z\": " + middle_02_l_rotation_z_start + ",
					\"w\": " + middle_02_l_rotation_w_start + "
				},
				\"rotation_1\": {
					\"x\": " + middle_02_l_rotation_x_end + ",
					\"y\": " + middle_02_l_rotation_y_end + ",
					\"z\": " + middle_02_l_rotation_z_end + ",
					\"w\": " + middle_02_l_rotation_w_end + "
				}
			},
			{
				\"joint\": \"middle_03_l\",
				\"translation\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0
				},
				\"rotation_0\": {
					\"x\": " + middle_03_l_rotation_x_start + ",
					\"y\": " + middle_03_l_rotation_y_start + ",
					\"z\": " + middle_03_l_rotation_z_start + ",
					\"w\": " + middle_03_l_rotation_w_start + "
				},
				\"rotation_1\": {
					\"x\": " + middle_03_l_rotation_x_end + ",
					\"y\": " + middle_03_l_rotation_y_end + ",
					\"z\": " + middle_03_l_rotation_z_end + ",
					\"w\": " + middle_03_l_rotation_w_end + "
				}
			},
			{
				\"joint\": \"middle_04_l\",
				\"translation\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0
				},
				\"rotation_0\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0,
					\"w\": 1
				},
				\"rotation_1\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0,
					\"w\": 1
				}
			}
		],
		\"ring\": [
			{
				\"joint\": \"ring_00_l\",
				\"translation\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0
				},
				\"rotation_0\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0,
					\"w\": 1
				},
				\"rotation_1\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0,
					\"w\": 1
				}
			},
			{
				\"joint\": \"ring_01_l\",
				\"translation\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0
				},
				\"rotation_0\": {
					\"x\": " + ring_01_l_rotation_x_start + ",
					\"y\": " + ring_01_l_rotation_y_start + ",
					\"z\": " + ring_01_l_rotation_z_start + ",
					\"w\": " + ring_01_l_rotation_w_start + "
				},
				\"rotation_1\": {
					\"x\": " + ring_01_l_rotation_x_end + ",
					\"y\": " + ring_01_l_rotation_y_end + ",
					\"z\": " + ring_01_l_rotation_z_end + ",
					\"w\": " + ring_01_l_rotation_w_end + "
				}
			},
			{
				\"joint\": \"ring_02_l\",
				\"translation\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0
				},
				\"rotation_0\": {
					\"x\": " + ring_02_l_rotation_x_start + ",
					\"y\": " + ring_02_l_rotation_y_start + ",
					\"z\": " + ring_02_l_rotation_z_start + ",
					\"w\": " + ring_02_l_rotation_w_start + "
				},
				\"rotation_1\": {
					\"x\": " + ring_02_l_rotation_x_end + ",
					\"y\": " + ring_02_l_rotation_y_end + ",
					\"z\": " + ring_02_l_rotation_z_end + ",
					\"w\": " + ring_02_l_rotation_w_end + "
				}
			},
			{
				\"joint\": \"ring_03_l\",
				\"translation\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0
				},
				\"rotation_0\": {
					\"x\": " + ring_03_l_rotation_x_start + ",
					\"y\": " + ring_03_l_rotation_y_start + ",
					\"z\": " + ring_03_l_rotation_z_start + ",
					\"w\": " + ring_03_l_rotation_w_start + "
				},
				\"rotation_1\": {
					\"x\": " + ring_03_l_rotation_x_end + ",
					\"y\": " + ring_03_l_rotation_y_end + ",
					\"z\": " + ring_03_l_rotation_z_end + ",
					\"w\": " + ring_03_l_rotation_w_end + "
				}
			},
			{
				\"joint\": \"ring_04_l\",
				\"translation\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0
				},
				\"rotation_0\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0,
					\"w\": 1
				},
				\"rotation_1\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0,
					\"w\": 1
				}
			}
		],
		\"pinky\": [
			{
				\"joint\": \"pinky_00_l\",
				\"translation\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0
				},
				\"rotation_0\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0,
					\"w\": 1
				},
				\"rotation_1\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0,
					\"w\": 1
				}
			},
			{
				\"joint\": \"pinky_01_l\",
				\"translation\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0
				},
				\"rotation_0\": {
					\"x\": " + pinky_01_l_rotation_x_start + ",
					\"y\": " + pinky_01_l_rotation_y_start + ",
					\"z\": " + pinky_01_l_rotation_z_start + ",
					\"w\": " + pinky_01_l_rotation_w_start + "
				},
				\"rotation_1\": {
					\"x\": " + pinky_01_l_rotation_x_end + ",
					\"y\": " + pinky_01_l_rotation_y_end + ",
					\"z\": " + pinky_01_l_rotation_z_end + ",
					\"w\": " + pinky_01_l_rotation_w_end + "
				}
			},
			{
				\"joint\": \"pinky_02_l\",
				\"translation\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0
				},
				\"rotation_0\": {
					\"x\": " + pinky_02_l_rotation_x_start + ",
					\"y\": " + pinky_02_l_rotation_y_start + ",
					\"z\": " + pinky_02_l_rotation_z_start + ",
					\"w\": " + pinky_02_l_rotation_w_start + "
				},
				\"rotation_1\": {
					\"x\": " + pinky_02_l_rotation_x_end + ",
					\"y\": " + pinky_02_l_rotation_y_end + ",
					\"z\": " + pinky_02_l_rotation_z_end + ",
					\"w\": " + pinky_02_l_rotation_w_end + "
				}
			},
			{
				\"joint\": \"pinky_03_l\",
				\"translation\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0
				},
				\"rotation_0\": {
					\"x\": " + pinky_03_l_rotation_x_start + ",
					\"y\": " + pinky_03_l_rotation_y_start + ",
					\"z\": " + pinky_03_l_rotation_z_start + ",
					\"w\": " + pinky_03_l_rotation_w_start + "
				},
				\"rotation_1\": {
					\"x\": " + pinky_03_l_rotation_x_end + ",
					\"y\": " + pinky_03_l_rotation_y_end + ",
					\"z\": " + pinky_03_l_rotation_z_end + ",
					\"w\": " + pinky_03_l_rotation_w_end + "
				}
			},
			{
				\"joint\": \"pinky_04_l\",
				\"translation\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0
				},
				\"rotation_0\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0,
					\"w\": 1
				},
				\"rotation_1\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0,
					\"w\": 1
				}
			}
		]
	},
	\"Right\": {
		\"wrist\": [
			{
				\"joint\": \"hand_r\",
				\"translation\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0
				},
				\"rotation_0\": {
					\"x\": " + wrist_r_rotation_x_start + ",
					\"y\": " + wrist_r_rotation_y_start + ",
					\"z\": " + wrist_r_rotation_z_start + ",
					\"w\": " + wrist_r_rotation_w_start + "
				},
				\"rotation_1\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0,
					\"w\": 1
				}
			}
		],
		\"thumb\": [
			{
				\"joint\": \"thumb_00_r\",
				\"translation\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0
				},
				\"rotation_0\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0,
					\"w\": 1
				},
				\"rotation_1\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0,
					\"w\": 1
				}
			},
			{
				\"joint\": \"thumb_01_r\",
				\"translation\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0
				},
				\"rotation_0\": {
					\"x\": " + thumb_01_r_rotation_x_start + ",
					\"y\": " + thumb_01_r_rotation_y_start + ",
					\"z\": " + thumb_01_r_rotation_z_start + ",
					\"w\": " + thumb_01_r_rotation_w_start + "
				},
				\"rotation_1\": {
					\"x\": " + thumb_01_r_rotation_x_end + ",
					\"y\": " + thumb_01_r_rotation_y_end + ",
					\"z\": " + thumb_01_r_rotation_z_end + ",
					\"w\": " + thumb_01_r_rotation_w_end + "
				}
			},
			{
				\"joint\": \"thumb_02_r\",
				\"translation\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0
				},
				\"rotation_0\": {
					\"x\": " + thumb_02_r_rotation_x_start + ",
					\"y\": " + thumb_02_r_rotation_y_start + ",
					\"z\": " + thumb_02_r_rotation_z_start + ",
					\"w\": " + thumb_02_r_rotation_w_start + "
				},
				\"rotation_1\": {
					\"x\": " + thumb_02_r_rotation_x_end + ",
					\"y\": " + thumb_02_r_rotation_y_end + ",
					\"z\": " + thumb_02_r_rotation_z_end + ",
					\"w\": " + thumb_02_r_rotation_w_end + "
				}
			},
			{
				\"joint\": \"thumb_03_r\",
				\"translation\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0
				},
				\"rotation_0\": {
					\"x\": " + thumb_03_r_rotation_x_start + ",
					\"y\": " + thumb_03_r_rotation_y_start + ",
					\"z\": " + thumb_03_r_rotation_z_start + ",
					\"w\": " + thumb_03_r_rotation_w_start + "
				},
				\"rotation_1\": {
					\"x\": " + thumb_03_r_rotation_x_end + ",
					\"y\": " + thumb_03_r_rotation_y_end + ",
					\"z\": " + thumb_03_r_rotation_z_end + ",
					\"w\": " + thumb_03_r_rotation_w_end + "
				}
			},
			{
				\"joint\": \"thumb_04_r\",
				\"translation\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0
				},
				\"rotation_0\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0,
					\"w\": 1
				},
				\"rotation_1\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0,
					\"w\": 1
				}
			}
		],
		\"index\": [
			{
				\"joint\": \"index_00_r\",
				\"translation\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0
				},
				\"rotation_0\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0,
					\"w\": 1
				},
				\"rotation_1\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0,
					\"w\": 1
				}
			},
			{
				\"joint\": \"index_01_r\",
				\"translation\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0
				},
				\"rotation_0\": {
					\"x\": " + index_01_r_rotation_x_start + ",
					\"y\": " + index_01_r_rotation_y_start + ",
					\"z\": " + index_01_r_rotation_z_start + ",
					\"w\": " + index_01_r_rotation_w_start + "
				},
				\"rotation_1\": {
					\"x\": " + index_01_r_rotation_x_end + ",
					\"y\": " + index_01_r_rotation_y_end + ",
					\"z\": " + index_01_r_rotation_z_end + ",
					\"w\": " + index_01_r_rotation_w_end + "
				}
			},
			{
				\"joint\": \"index_02_r\",
				\"translation\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0
				},
				\"rotation_0\": {
					\"x\": " + index_02_r_rotation_x_start + ",
					\"y\": " + index_02_r_rotation_y_start + ",
					\"z\": " + index_02_r_rotation_z_start + ",
					\"w\": " + index_02_r_rotation_w_start + "
				},
				\"rotation_1\": {
					\"x\": " + index_02_r_rotation_x_end + ",
					\"y\": " + index_02_r_rotation_y_end + ",
					\"z\": " + index_02_r_rotation_z_end + ",
					\"w\": " + index_02_r_rotation_w_end + "
				}
			},
			{
				\"joint\": \"index_03_r\",
				\"translation\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0
				},
				\"rotation_0\": {
					\"x\": " + index_03_r_rotation_x_start + ",
					\"y\": " + index_03_r_rotation_y_start + ",
					\"z\": " + index_03_r_rotation_z_start + ",
					\"w\": " + index_03_r_rotation_w_start + "
				},
				\"rotation_1\": {
					\"x\": " + index_03_r_rotation_x_end + ",
					\"y\": " + index_03_r_rotation_y_end + ",
					\"z\": " + index_03_r_rotation_z_end + ",
					\"w\": " + index_03_r_rotation_w_end + "
				}
			},
			{
				\"joint\": \"index_04_r\",
				\"translation\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0
				},
				\"rotation_0\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0,
					\"w\": 1
				},
				\"rotation_1\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0,
					\"w\": 1
				}
			}
		],
		\"middle\": [
			{
				\"joint\": \"middle_00_r\",
				\"translation\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0
				},
				\"rotation_0\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0,
					\"w\": 1
				},
				\"rotation_1\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0,
					\"w\": 1
				}
			},
			{
				\"joint\": \"middle_01_r\",
				\"translation\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0
				},
				\"rotation_0\": {
					\"x\": " + middle_01_r_rotation_x_start + ",
					\"y\": " + middle_01_r_rotation_y_start + ",
					\"z\": " + middle_01_r_rotation_z_start + ",
					\"w\": " + middle_01_r_rotation_w_start + "
				},
				\"rotation_1\": {
					\"x\": " + middle_01_r_rotation_x_end + ",
					\"y\": " + middle_01_r_rotation_y_end + ",
					\"z\": " + middle_01_r_rotation_z_end + ",
					\"w\": " + middle_01_r_rotation_w_end + "
				}
			},
			{
				\"joint\": \"middle_02_r\",
				\"translation\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0
				},
				\"rotation_0\": {
					\"x\": " + middle_02_r_rotation_x_start + ",
					\"y\": " + middle_02_r_rotation_y_start + ",
					\"z\": " + middle_02_r_rotation_z_start + ",
					\"w\": " + middle_02_r_rotation_w_start + "
				},
				\"rotation_1\": {
					\"x\": " + middle_02_r_rotation_x_end + ",
					\"y\": " + middle_02_r_rotation_y_end + ",
					\"z\": " + middle_02_r_rotation_z_end + ",
					\"w\": " + middle_02_r_rotation_w_end + "
				}
			},
			{
				\"joint\": \"middle_03_r\",
				\"translation\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0
				},
				\"rotation_0\": {
					\"x\": " + middle_03_r_rotation_x_start + ",
					\"y\": " + middle_03_r_rotation_y_start + ",
					\"z\": " + middle_03_r_rotation_z_start + ",
					\"w\": " + middle_03_r_rotation_w_start + "
				},
				\"rotation_1\": {
					\"x\": " + middle_03_r_rotation_x_end + ",
					\"y\": " + middle_03_r_rotation_y_end + ",
					\"z\": " + middle_03_r_rotation_z_end + ",
					\"w\": " + middle_03_r_rotation_w_end + "
				}
			},
			{
				\"joint\": \"middle_04_r\",
				\"translation\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0
				},
				\"rotation_0\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0,
					\"w\": 1
				},
				\"rotation_1\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0,
					\"w\": 1
				}
			}
		],
		\"ring\": [
			{
				\"joint\": \"ring_00_r\",
				\"translation\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0
				},
				\"rotation_0\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0,
					\"w\": 1
				},
				\"rotation_1\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0,
					\"w\": 1
				}
			},
			{
				\"joint\": \"ring_01_r\",
				\"translation\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0
				},
				\"rotation_0\": {
					\"x\": " + ring_01_r_rotation_x_start + ",
					\"y\": " + ring_01_r_rotation_y_start + ",
					\"z\": " + ring_01_r_rotation_z_start + ",
					\"w\": " + ring_01_r_rotation_w_start + "
				},
				\"rotation_1\": {
					\"x\": " + ring_01_r_rotation_x_end + ",
					\"y\": " + ring_01_r_rotation_y_end + ",
					\"z\": " + ring_01_r_rotation_z_end + ",
					\"w\": " + ring_01_r_rotation_w_end + "
				}
			},
			{
				\"joint\": \"ring_02_r\",
				\"translation\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0
				},
				\"rotation_0\": {
					\"x\": " + ring_02_r_rotation_x_start + ",
					\"y\": " + ring_02_r_rotation_y_start + ",
					\"z\": " + ring_02_r_rotation_z_start + ",
					\"w\": " + ring_02_r_rotation_w_start + "
				},
				\"rotation_1\": {
					\"x\": " + ring_02_r_rotation_x_end + ",
					\"y\": " + ring_02_r_rotation_y_end + ",
					\"z\": " + ring_02_r_rotation_z_end + ",
					\"w\": " + ring_02_r_rotation_w_end + "
				}
			},
			{
				\"joint\": \"ring_03_r\",
				\"translation\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0
				},
				\"rotation_0\": {
					\"x\": " + ring_03_r_rotation_x_start + ",
					\"y\": " + ring_03_r_rotation_y_start + ",
					\"z\": " + ring_03_r_rotation_z_start + ",
					\"w\": " + ring_03_r_rotation_w_start + "
				},
				\"rotation_1\": {
					\"x\": " + ring_03_r_rotation_x_end + ",
					\"y\": " + ring_03_r_rotation_y_end + ",
					\"z\": " + ring_03_r_rotation_z_end + ",
					\"w\": " + ring_03_r_rotation_w_end + "
				}
			},
			{
				\"joint\": \"ring_04_r\",
				\"translation\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0
				},
				\"rotation_0\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0,
					\"w\": 1
				},
				\"rotation_1\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0,
					\"w\": 1
				}
			}
		],
		\"pinky\": [
			{
				\"joint\": \"pinky_00_r\",
				\"translation\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0
				},
				\"rotation_0\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0,
					\"w\": 1
				},
				\"rotation_1\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0,
					\"w\": 1
				}
			},
			{
				\"joint\": \"pinky_01_r\",
				\"translation\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0
				},
				\"rotation_0\": {
					\"x\": " + pinky_01_r_rotation_x_start + ",
					\"y\": " + pinky_01_r_rotation_y_start + ",
					\"z\": " + pinky_01_r_rotation_z_start + ",
					\"w\": " + pinky_01_r_rotation_w_start + "
				},
				\"rotation_1\": {
					\"x\": " + pinky_01_r_rotation_x_end + ",
					\"y\": " + pinky_01_r_rotation_y_end + ",
					\"z\": " + pinky_01_r_rotation_z_end + ",
					\"w\": " + pinky_01_r_rotation_w_end + "
				}
			},
			{
				\"joint\": \"pinky_02_r\",
				\"translation\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0
				},
				\"rotation_0\": {
					\"x\": " + pinky_02_r_rotation_x_start + ",
					\"y\": " + pinky_02_r_rotation_y_start + ",
					\"z\": " + pinky_02_r_rotation_z_start + ",
					\"w\": " + pinky_02_r_rotation_w_start + "
				},
				\"rotation_1\": {
					\"x\": " + pinky_02_r_rotation_x_end + ",
					\"y\": " + pinky_02_r_rotation_y_end + ",
					\"z\": " + pinky_02_r_rotation_z_end + ",
					\"w\": " + pinky_02_r_rotation_w_end + "
				}
			},
			{
				\"joint\": \"pinky_03_r\",
				\"translation\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0
				},
				\"rotation_0\": {
					\"x\": " + pinky_03_r_rotation_x_start + ",
					\"y\": " + pinky_03_r_rotation_y_start + ",
					\"z\": " + pinky_03_r_rotation_z_start + ",
					\"w\": " + pinky_03_r_rotation_w_start + "
				},
				\"rotation_1\": {
					\"x\": " + pinky_03_r_rotation_x_end + ",
					\"y\": " + pinky_03_r_rotation_y_end + ",
					\"z\": " + pinky_03_r_rotation_z_end + ",
					\"w\": " + pinky_03_r_rotation_w_end + "
				}
			},
			{
				\"joint\": \"pinky_04_r\",
				\"translation\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0
				},
				\"rotation_0\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0,
					\"w\": 1
				},
				\"rotation_1\": {
					\"x\": 0,
					\"y\": 0,
					\"z\": 0,
					\"w\": 1
				}
			}
		]
	},
	\"iterations\": " + iterations_default + ",
	\"lowerArmLength\": " + conversion_array[2] + ",
	\"lowerNeckLength\": " + lower_neck_length_default + ",
	\"shoulderLength\": " + conversion_array[3] + ",
	\"upperArmLength\": " + conversion_array[1] + ",
	\"upperNeckLength\": " + upper_neck_length_default + ",
	\"upperNeckOffset\": {
		\"x\": " + upper_neck_offset_x_default + ",
		\"y\": " + upper_neck_offset_y_default + ",
		\"z\": " + upper_neck_offset_z_default + "
	}
}"
)

	fn fnJSON = (
		json =
"{
	\"profiles\": [
		{
			\"Left\": {
				\"index\": [
					{
						\"length\": 0.10236,
						\"rotation_0\": {
							\"w\": 1,
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						},
						\"rotation_1\": {
							\"w\": 1,
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						},
						\"translation\": {
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						}
					},
					{
						\"length\": 0.03978,
						\"rotation_0\": {
							\"w\": " + index_01_l_rotation_w_start + ",
							\"x\": " + index_01_l_rotation_x_start + ",
							\"y\": " + index_01_l_rotation_y_start + ",
							\"z\": " + index_01_l_rotation_z_start + "
						},
						\"rotation_1\": {
							\"w\": " + index_01_l_rotation_w_end + ",
							\"x\": " + index_01_l_rotation_x_end + ",
							\"y\": " + index_01_l_rotation_y_end + ",
							\"z\": " + index_01_l_rotation_z_end + "
						},
						\"translation\": {
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						}
					},
					{
						\"length\": 0.02238,
						\"rotation_0\": {
							\"w\": " + index_02_l_rotation_w_start + ",
							\"x\": " + index_02_l_rotation_x_start + ",
							\"y\": " + index_02_l_rotation_y_start + ",
							\"z\": " + index_02_l_rotation_z_start + "
						},
						\"rotation_1\": {
							\"w\": " + index_02_l_rotation_w_end + ",
							\"x\": " + index_02_l_rotation_x_end + ",
							\"y\": " + index_02_l_rotation_y_end + ",
							\"z\": " + index_02_l_rotation_z_end + "
						},
						\"translation\": {
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						}
					},
					{
						\"length\": 0.01966,
						\"rotation_0\": {
							\"w\": " + index_03_l_rotation_w_start + ",
							\"x\": " + index_03_l_rotation_x_start + ",
							\"y\": " + index_03_l_rotation_y_start + ",
							\"z\": " + index_03_l_rotation_z_start + "
						},
						\"rotation_1\": {
							\"w\": " + index_03_l_rotation_w_end + ",
							\"x\": " + index_03_l_rotation_x_end + ",
							\"y\": " + index_03_l_rotation_y_end + ",
							\"z\": " + index_03_l_rotation_z_end + "
						},
						\"translation\": {
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						}
					},
					{
						\"length\": 0.0,
						\"rotation_0\": {
							\"w\": 1,
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						},
						\"rotation_1\": {
							\"w\": 1,
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						},
						\"translation\": {
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						}
					}
				],
				\"middle\": [
					{
						\"length\": 0.09738,
						\"rotation_0\": {
							\"w\": 1,
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						},
						\"rotation_1\": {
							\"w\": 1,
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						},
						\"translation\": {
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						}
					},
					{
						\"length\": 0.04463,
						\"rotation_0\": {
							\"w\": " + middle_01_l_rotation_w_start + ",
							\"x\": " + middle_01_l_rotation_x_start + ",
							\"y\": " + middle_01_l_rotation_y_start + ",
							\"z\": " + middle_01_l_rotation_z_start + "
						},
						\"rotation_1\": {
							\"w\": " + middle_01_l_rotation_w_end + ",
							\"x\": " + middle_01_l_rotation_x_end + ",
							\"y\": " + middle_01_l_rotation_y_end + ",
							\"z\": " + middle_01_l_rotation_z_end + "
						},
						\"translation\": {
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						}
					},
					{
						\"length\": 0.02633,
						\"rotation_0\": {
							\"w\": " + middle_02_l_rotation_w_start + ",
							\"x\": " + middle_02_l_rotation_x_start + ",
							\"y\": " + middle_02_l_rotation_y_start + ",
							\"z\": " + middle_02_l_rotation_z_start + "
						},
						\"rotation_1\": {
							\"w\": " + middle_02_l_rotation_w_end + ",
							\"x\": " + middle_02_l_rotation_x_end + ",
							\"y\": " + middle_02_l_rotation_y_end + ",
							\"z\": " + middle_02_l_rotation_z_end + "
						},
						\"translation\": {
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						}
					},
					{
						\"length\": 0.02135,
						\"rotation_0\": {
							\"w\": " + middle_03_l_rotation_w_start + ",
							\"x\": " + middle_03_l_rotation_x_start + ",
							\"y\": " + middle_03_l_rotation_y_start + ",
							\"z\": " + middle_03_l_rotation_z_start + "
						},
						\"rotation_1\": {
							\"w\": " + middle_03_l_rotation_w_end + ",
							\"x\": " + middle_03_l_rotation_x_end + ",
							\"y\": " + middle_03_l_rotation_y_end + ",
							\"z\": " + middle_03_l_rotation_z_end + "
						},
						\"translation\": {
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						}
					},
					{
						\"length\": 0.0,
						\"rotation_0\": {
							\"w\": 1,
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						},
						\"rotation_1\": {
							\"w\": 1,
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						},
						\"translation\": {
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						}
					}
				],
				\"pinky\": [
					{
						\"length\": 0.08997,
						\"rotation_0\": {
							\"w\": 1,
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						},
						\"rotation_1\": {
							\"w\": 1,
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						},
						\"translation\": {
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						}
					},
					{
						\"length\": 0.03274,
						\"rotation_0\": {
							\"w\": " + pinky_01_l_rotation_w_start + ",
							\"x\": " + pinky_01_l_rotation_x_start + ",
							\"y\": " + pinky_01_l_rotation_y_start + ",
							\"z\": " + pinky_01_l_rotation_z_start + "
						},
						\"rotation_1\": {
							\"w\": " + pinky_01_l_rotation_w_end + ",
							\"x\": " + pinky_01_l_rotation_x_end + ",
							\"y\": " + pinky_01_l_rotation_y_end + ",
							\"z\": " + pinky_01_l_rotation_z_end + "
						},
						\"translation\": {
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						}
					},
					{
						\"length\": 0.01811,
						\"rotation_0\": {
							\"w\": " + pinky_02_l_rotation_w_start + ",
							\"x\": " + pinky_02_l_rotation_x_start + ",
							\"y\": " + pinky_02_l_rotation_y_start + ",
							\"z\": " + pinky_02_l_rotation_z_start + "
						},
						\"rotation_1\": {
							\"w\": " + pinky_02_l_rotation_w_end + ",
							\"x\": " + pinky_02_l_rotation_x_end + ",
							\"y\": " + pinky_02_l_rotation_y_end + ",
							\"z\": " + pinky_02_l_rotation_z_end + "
						},
						\"translation\": {
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						}
					},
					{
						\"length\": 0.01969,
						\"rotation_0\": {
							\"w\": " + pinky_03_l_rotation_w_start + ",
							\"x\": " + pinky_03_l_rotation_x_start + ",
							\"y\": " + pinky_03_l_rotation_y_start + ",
							\"z\": " + pinky_03_l_rotation_z_start + "
						},
						\"rotation_1\": {
							\"w\": " + pinky_03_l_rotation_w_end + ",
							\"x\": " + pinky_03_l_rotation_x_end + ",
							\"y\": " + pinky_03_l_rotation_y_end + ",
							\"z\": " + pinky_03_l_rotation_z_end + "
						},
						\"translation\": {
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						}
					},
					{
						\"length\": 0.0,
						\"rotation_0\": {
							\"w\": 1,
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						},
						\"rotation_1\": {
							\"w\": 1,
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						},
						\"translation\": {
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						}
					}
				],
				\"ring\": [
					{
						\"length\": 0.09172,
						\"rotation_0\": {
							\"w\": 1,
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						},
						\"rotation_1\": {
							\"w\": 1,
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						},
						\"translation\": {
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						}
					},
					{
						\"length\": 0.04137,
						\"rotation_0\": {
							\"w\": " + ring_01_l_rotation_w_start + ",
							\"x\": " + ring_01_l_rotation_x_start + ",
							\"y\": " + ring_01_l_rotation_y_start + ",
							\"z\": " + ring_01_l_rotation_z_start + "
						},
						\"rotation_1\": {
							\"w\": " + ring_01_l_rotation_w_end + ",
							\"x\": " + ring_01_l_rotation_x_end + ",
							\"y\": " + ring_01_l_rotation_y_end + ",
							\"z\": " + ring_01_l_rotation_z_end + "
						},
						\"translation\": {
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						}
					},
					{
						\"length\": 0.02565,
						\"rotation_0\": {
							\"w\": " + ring_02_l_rotation_w_start + ",
							\"x\": " + ring_02_l_rotation_x_start + ",
							\"y\": " + ring_02_l_rotation_y_start + ",
							\"z\": " + ring_02_l_rotation_z_start + "
						},
						\"rotation_1\": {
							\"w\": " + ring_02_l_rotation_w_end + ",
							\"x\": " + ring_02_l_rotation_x_end + ",
							\"y\": " + ring_02_l_rotation_y_end + ",
							\"z\": " + ring_02_l_rotation_z_end + "
						},
						\"translation\": {
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						}
					},
					{
						\"length\": 0.02125,
						\"rotation_0\": {
							\"w\": " + ring_03_l_rotation_w_start + ",
							\"x\": " + ring_03_l_rotation_x_start + ",
							\"y\": " + ring_03_l_rotation_y_start + ",
							\"z\": " + ring_03_l_rotation_z_start + "
						},
						\"rotation_1\": {
							\"w\": " + ring_03_l_rotation_w_end + ",
							\"x\": " + ring_03_l_rotation_x_end + ",
							\"y\": " + ring_03_l_rotation_y_end + ",
							\"z\": " + ring_03_l_rotation_z_end + "
						},
						\"translation\": {
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						}
					},
					{
						\"length\": 0.0,
						\"rotation_0\": {
							\"w\": 1,
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						},
						\"rotation_1\": {
							\"w\": 1,
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						},
						\"translation\": {
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						}
					}
				],
				\"thumb\": [
					{
						\"length\": 0.04249,
						\"rotation_0\": {
							\"w\": 1,
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						},
						\"rotation_1\": {
							\"w\": 1,
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						},
						\"translation\": {
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						}
					},
					{
						\"length\": 0.04622,
						\"rotation_0\": {
							\"w\": " + thumb_01_l_rotation_w_start + ",
							\"x\": " + thumb_01_l_rotation_x_start + ",
							\"y\": " + thumb_01_l_rotation_y_start + ",
							\"z\": " + thumb_01_l_rotation_z_start + "
						},
						\"rotation_1\": {
							\"w\": " + thumb_01_l_rotation_w_end + ",
							\"x\": " + thumb_01_l_rotation_x_end + ",
							\"y\": " + thumb_01_l_rotation_y_end + ",
							\"z\": " + thumb_01_l_rotation_z_end + "
						},
						\"translation\": {
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						}
					},
					{
						\"length\": 0.03157,
						\"rotation_0\": {
							\"w\": " + thumb_02_l_rotation_w_start + ",
							\"x\": " + thumb_02_l_rotation_x_start + ",
							\"y\": " + thumb_02_l_rotation_y_start + ",
							\"z\": " + thumb_02_l_rotation_z_start + "
						},
						\"rotation_1\": {
							\"w\": " + thumb_02_l_rotation_w_end + ",
							\"x\": " + thumb_02_l_rotation_x_end + ",
							\"y\": " + thumb_02_l_rotation_y_end + ",
							\"z\": " + thumb_02_l_rotation_z_end + "
						},
						\"translation\": {
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						}
					},
					{
						\"length\": 0.02734,
						\"rotation_0\": {
							\"w\": " + thumb_03_l_rotation_w_start + ",
							\"x\": " + thumb_03_l_rotation_x_start + ",
							\"y\": " + thumb_03_l_rotation_y_start + ",
							\"z\": " + thumb_03_l_rotation_z_start + "
						},
						\"rotation_1\": {
							\"w\": " + thumb_03_l_rotation_w_end + ",
							\"x\": " + thumb_03_l_rotation_x_end + ",
							\"y\": " + thumb_03_l_rotation_y_end + ",
							\"z\": " + thumb_03_l_rotation_z_end + "
						},
						\"translation\": {
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						}
					}
				],
				\"wrist\": [
					{
						\"length\": 0.084784,
						\"rotation_0\": {
							\"w\": " + wrist_l_rotation_w_start + ",
							\"x\": " + wrist_l_rotation_x_start + ",
							\"y\": " + wrist_l_rotation_y_start + ",
							\"z\": " + wrist_l_rotation_z_start + "
						},
						\"rotation_1\": {
							\"w\": 1,
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						},
						\"translation\": {
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						}
					}
				]
			},
			\"Right\": {
				\"index\": [
					{
						\"length\": 0.10236,
						\"rotation_0\": {
							\"w\": 1,
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						},
						\"rotation_1\": {
							\"w\": 1,
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						},
						\"translation\": {
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						}
					},
					{
						\"length\": 0.03978,
						\"rotation_0\": {
							\"w\": " + index_01_r_rotation_w_start + ",
							\"x\": " + index_01_r_rotation_x_start + ",
							\"y\": " + index_01_r_rotation_y_start + ",
							\"z\": " + index_01_r_rotation_z_start + "
						},
						\"rotation_1\": {
							\"w\": " + index_01_r_rotation_w_end + ",
							\"x\": " + index_01_r_rotation_x_end + ",
							\"y\": " + index_01_r_rotation_y_end + ",
							\"z\": " + index_01_r_rotation_z_end + "
						},
						\"translation\": {
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						}
					},
					{
						\"length\": 0.02238,
						\"rotation_0\": {
							\"w\": " + index_02_r_rotation_w_start + ",
							\"x\": " + index_02_r_rotation_x_start + ",
							\"y\": " + index_02_r_rotation_y_start + ",
							\"z\": " + index_02_r_rotation_z_start + "
						},
						\"rotation_1\": {
							\"w\": " + index_02_r_rotation_w_end + ",
							\"x\": " + index_02_r_rotation_x_end + ",
							\"y\": " + index_02_r_rotation_y_end + ",
							\"z\": " + index_02_r_rotation_z_end + "
						},
						\"translation\": {
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						}
					},
					{
						\"length\": 0.01966,
						\"rotation_0\": {
							\"w\": " + index_03_r_rotation_w_start + ",
							\"x\": " + index_03_r_rotation_x_start + ",
							\"y\": " + index_03_r_rotation_y_start + ",
							\"z\": " + index_03_r_rotation_z_start + "
						},
						\"rotation_1\": {
							\"w\": " + index_03_r_rotation_w_end + ",
							\"x\": " + index_03_r_rotation_x_end + ",
							\"y\": " + index_03_r_rotation_y_end + ",
							\"z\": " + index_03_r_rotation_z_end + "
						},
						\"translation\": {
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						}
					},
					{
						\"length\": 0.0,
						\"rotation_0\": {
							\"w\": 1,
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						},
						\"rotation_1\": {
							\"w\": 1,
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						},
						\"translation\": {
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						}
					}
				],
				\"middle\": [
					{
						\"length\": 0.09738,
						\"rotation_0\": {
							\"w\": 1,
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						},
						\"rotation_1\": {
							\"w\": 1,
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						},
						\"translation\": {
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						}
					},
					{
						\"length\": 0.04463,
						\"rotation_0\": {
							\"w\": " + middle_01_r_rotation_w_start + ",
							\"x\": " + middle_01_r_rotation_x_start + ",
							\"y\": " + middle_01_r_rotation_y_start + ",
							\"z\": " + middle_01_r_rotation_z_start + "
						},
						\"rotation_1\": {
							\"w\": " + middle_01_r_rotation_w_end + ",
							\"x\": " + middle_01_r_rotation_x_end + ",
							\"y\": " + middle_01_r_rotation_y_end + ",
							\"z\": " + middle_01_r_rotation_z_end + "
						},
						\"translation\": {
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						}
					},
					{
						\"length\": 0.02633,
						\"rotation_0\": {
							\"w\": " + middle_02_r_rotation_w_start + ",
							\"x\": " + middle_02_r_rotation_x_start + ",
							\"y\": " + middle_02_r_rotation_y_start + ",
							\"z\": " + middle_02_r_rotation_z_start + "
						},
						\"rotation_1\": {
							\"w\": " + middle_02_r_rotation_w_end + ",
							\"x\": " + middle_02_r_rotation_x_end + ",
							\"y\": " + middle_02_r_rotation_y_end + ",
							\"z\": " + middle_02_r_rotation_z_end + "
						},
						\"translation\": {
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						}
					},
					{
						\"length\": 0.02135,
						\"rotation_0\": {
							\"w\": " + middle_03_r_rotation_w_start + ",
							\"x\": " + middle_03_r_rotation_x_start + ",
							\"y\": " + middle_03_r_rotation_y_start + ",
							\"z\": " + middle_03_r_rotation_z_start + "
						},
						\"rotation_1\": {
							\"w\": " + middle_03_r_rotation_w_end + ",
							\"x\": " + middle_03_r_rotation_x_end + ",
							\"y\": " + middle_03_r_rotation_y_end + ",
							\"z\": " + middle_03_r_rotation_z_end + "
						},
						\"translation\": {
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						}
					},
					{
						\"length\": 0.0,
						\"rotation_0\": {
							\"w\": 1,
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						},
						\"rotation_1\": {
							\"w\": 1,
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						},
						\"translation\": {
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						}
					}
				],
				\"pinky\": [
					{
						\"length\": 0.08997,
						\"rotation_0\": {
							\"w\": 1,
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						},
						\"rotation_1\": {
							\"w\": 1,
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						},
						\"translation\": {
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						}
					},
					{
						\"length\": 0.03274,
						\"rotation_0\": {
							\"w\": " + pinky_01_r_rotation_w_start + ",
							\"x\": " + pinky_01_r_rotation_x_start + ",
							\"y\": " + pinky_01_r_rotation_y_start + ",
							\"z\": " + pinky_01_r_rotation_z_start + "
						},
						\"rotation_1\": {
							\"w\": " + pinky_01_r_rotation_w_end + ",
							\"x\": " + pinky_01_r_rotation_x_end + ",
							\"y\": " + pinky_01_r_rotation_y_end + ",
							\"z\": " + pinky_01_r_rotation_z_end + "
						},
						\"translation\": {
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						}
					},
					{
						\"length\": 0.01811,
						\"rotation_0\": {
							\"w\": " + pinky_02_r_rotation_w_start + ",
							\"x\": " + pinky_02_r_rotation_x_start + ",
							\"y\": " + pinky_02_r_rotation_y_start + ",
							\"z\": " + pinky_02_r_rotation_z_start + "
						},
						\"rotation_1\": {
							\"w\": " + pinky_02_r_rotation_w_end + ",
							\"x\": " + pinky_02_r_rotation_x_end + ",
							\"y\": " + pinky_02_r_rotation_y_end + ",
							\"z\": " + pinky_02_r_rotation_z_end + "
						},
						\"translation\": {
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						}
					},
					{
						\"length\": 0.01969,
						\"rotation_0\": {
							\"w\": " + pinky_03_r_rotation_w_start + ",
							\"x\": " + pinky_03_r_rotation_x_start + ",
							\"y\": " + pinky_03_r_rotation_y_start + ",
							\"z\": " + pinky_03_r_rotation_z_start + "
						},
						\"rotation_1\": {
							\"w\": " + pinky_03_r_rotation_w_end + ",
							\"x\": " + pinky_03_r_rotation_x_end + ",
							\"y\": " + pinky_03_r_rotation_y_end + ",
							\"z\": " + pinky_03_r_rotation_z_end + "
						},
						\"translation\": {
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						}
					},
					{
						\"length\": 0.0,
						\"rotation_0\": {
							\"w\": 1,
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						},
						\"rotation_1\": {
							\"w\": 1,
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						},
						\"translation\": {
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						}
					}
				],
				\"ring\": [
					{
						\"length\": 0.09172,
						\"rotation_0\": {
							\"w\": 1,
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						},
						\"rotation_1\": {
							\"w\": 1,
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						},
						\"translation\": {
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						}
					},
					{
						\"length\": 0.04137,
						\"rotation_0\": {
							\"w\": " + ring_01_r_rotation_w_start + ",
							\"x\": " + ring_01_r_rotation_x_start + ",
							\"y\": " + ring_01_r_rotation_y_start + ",
							\"z\": " + ring_01_r_rotation_z_start + "
						},
						\"rotation_1\": {
							\"w\": " + ring_01_r_rotation_w_end + ",
							\"x\": " + ring_01_r_rotation_x_end + ",
							\"y\": " + ring_01_r_rotation_y_end + ",
							\"z\": " + ring_01_r_rotation_z_end + "
						},
						\"translation\": {
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						}
					},
					{
						\"length\": 0.02565,
						\"rotation_0\": {
							\"w\": " + ring_02_r_rotation_w_start + ",
							\"x\": " + ring_02_r_rotation_x_start + ",
							\"y\": " + ring_02_r_rotation_y_start + ",
							\"z\": " + ring_02_r_rotation_z_start + "
						},
						\"rotation_1\": {
							\"w\": " + ring_02_r_rotation_w_end + ",
							\"x\": " + ring_02_r_rotation_x_end + ",
							\"y\": " + ring_02_r_rotation_y_end + ",
							\"z\": " + ring_02_r_rotation_z_end + "
						},
						\"translation\": {
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						}
					},
					{
						\"length\": 0.02125,
						\"rotation_0\": {
							\"w\": " + ring_03_r_rotation_w_start + ",
							\"x\": " + ring_03_r_rotation_x_start + ",
							\"y\": " + ring_03_r_rotation_y_start + ",
							\"z\": " + ring_03_r_rotation_z_start + "
						},
						\"rotation_1\": {
							\"w\": " + ring_03_r_rotation_w_end + ",
							\"x\": " + ring_03_r_rotation_x_end + ",
							\"y\": " + ring_03_r_rotation_y_end + ",
							\"z\": " + ring_03_r_rotation_z_end + "
						},
						\"translation\": {
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						}
					},
					{
						\"length\": 0.0,
						\"rotation_0\": {
							\"w\": 1,
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						},
						\"rotation_1\": {
							\"w\": 1,
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						},
						\"translation\": {
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						}
					}
				],
				\"thumb\": [
					{
						\"length\": 0.04249,
						\"rotation_0\": {
							\"w\": 1,
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						},
						\"rotation_1\": {
							\"w\": 1,
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						},
						\"translation\": {
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						}
					},
					{
						\"length\": 0.04622,
						\"rotation_0\": {
							\"w\": " + thumb_01_r_rotation_w_start + ",
							\"x\": " + thumb_01_r_rotation_x_start + ",
							\"y\": " + thumb_01_r_rotation_y_start + ",
							\"z\": " + thumb_01_r_rotation_z_start + "
						},
						\"rotation_1\": {
							\"w\": " + thumb_01_r_rotation_w_end + ",
							\"x\": " + thumb_01_r_rotation_x_end + ",
							\"y\": " + thumb_01_r_rotation_y_end + ",
							\"z\": " + thumb_01_r_rotation_z_end + "
						},
						\"translation\": {
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						}
					},
					{
						\"length\": 0.03157,
						\"rotation_0\": {
							\"w\": " + thumb_02_r_rotation_w_start + ",
							\"x\": " + thumb_02_r_rotation_x_start + ",
							\"y\": " + thumb_02_r_rotation_y_start + ",
							\"z\": " + thumb_02_r_rotation_z_start + "
						},
						\"rotation_1\": {
							\"w\": " + thumb_02_r_rotation_w_end + ",
							\"x\": " + thumb_02_r_rotation_x_end + ",
							\"y\": " + thumb_02_r_rotation_y_end + ",
							\"z\": " + thumb_02_r_rotation_z_end + "
						},
						\"translation\": {
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						}
					},
					{
						\"length\": 0.02734,
						\"rotation_0\": {
							\"w\": " + thumb_03_r_rotation_w_start + ",
							\"x\": " + thumb_03_r_rotation_x_start + ",
							\"y\": " + thumb_03_r_rotation_y_start + ",
							\"z\": " + thumb_03_r_rotation_z_start + "
						},
						\"rotation_1\": {
							\"w\": " + thumb_03_r_rotation_w_end + ",
							\"x\": " + thumb_03_r_rotation_x_end + ",
							\"y\": " + thumb_03_r_rotation_y_end + ",
							\"z\": " + thumb_03_r_rotation_z_end + "
						},
						\"translation\": {
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						}
					}
				],
				\"wrist\": [
					{
						\"length\": 0.084784,
						\"rotation_0\": {
							\"w\": " + wrist_r_rotation_w_start + ",
							\"x\": " + wrist_r_rotation_x_start + ",
							\"y\": " + wrist_r_rotation_y_start + ",
							\"z\": " + wrist_r_rotation_z_start + "
						},
						\"rotation_1\": {
							\"w\": 1,
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						},
						\"translation\": {
							\"x\": 0.0,
							\"y\": 0.0,
							\"z\": 0.0
						}
					}
				]
			},
			\"iterations\": " + iterations_default + ",
			\"lowerArmLength\": " + conversion_array[2] + ",
			\"lowerNeckLength\": " + lower_neck_length_default + ",
			\"name\": \"" + lbl_name.text + "\",
			\"shoulderLength\": " + conversion_array[3] + ",
			\"upperArmLength\": " + conversion_array[1] + ",
			\"upperNeckLength\": " + upper_neck_length_default + ",
			\"upperNeckOffset\": {
				\"x\": " + upper_neck_offset_x_default + ",
				\"y\": " + upper_neck_offset_y_default + ",
				\"z\": " + upper_neck_offset_z_default + "
			}
		}
	],
	\"version\": 2
}
"
)

	fn fnExport = (
		if bonesmissing == true then
		(
			messagebox "Not all required bones are found in the scene.
Use the default Manus VR bone system when exporting an animation file." title: " Not all required bones are found in the scene"
		)
		else
		(
			fnGetQuaternionsOpen()
			fnGetQuaternionsClosed()

			global iterations_default = "10"
			global lower_neck_length_default = "0.17"
			global upper_neck_length_default = "0.20"

			-- Calculate lengths
			global upper_arm_length_calculated = distance $upperarm_r $lowerarm_r
			global lower_arm_length_calculated = distance $lowerarm_r $hand_r
			global shoulder_length_calculated = distance $upperarm_r $upperarm_l
			global conversion_array = #(upper_arm_length_calculated, lower_arm_length_calculated, shoulder_length_calculated)

			units.DisplayType = #Metric
			units.MetricType = #meters

			for i = 1 to conversion_array.count do
			(
				conversion_array[i] = units.formatValue conversion_array[i]
				conversion_array[i] = (substring conversion_array[i] 1 (conversion_array[i].count - 1))
			)

			units.DisplayType = #Generic

			if chk_legacy.checked == true then (
				global upper_neck_offset_x_default = "0.0"
				global upper_neck_offset_y_default = "0.05"
				global upper_neck_offset_z_default = "0.16"

				fnJSONLegacy()
			)
			else (
				global upper_neck_offset_x_default = "0.0"
				global upper_neck_offset_y_default = "0.22"
				global upper_neck_offset_z_default = "0.16"
				
				fnJSON()
			)

			global export_file = systemTools.getEnvVariable("AppData") + "/ManusVR/body.json"

			global out_file = createfile ((export_file))
			format json to:out_file
			close out_file
		)
	)

	on ManusVRJSONTool open do
	(
		format "%\r" ManusVRJSONToolVersion

		lbl_name.text = fnDateTime datetime

		fnCheckBones()
	)

	on export_json pressed do
	(
		fnCheckBones()
		fnExport()
	)

	on chk_legacy changed legacy_state do
	(
		if legacy_state == true then
		(
			lbl_name.readOnly = true
			lbl_name.text = "  disabled in legacy  "
			lbl_name.bold = true
		)
		else
		(
			lbl_name.readOnly = false
			lbl_name.text = fnDateTime datetime
			lbl_name.bold = false
		)
	)
)

createDialog ManusVRJSONTool