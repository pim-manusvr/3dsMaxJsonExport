rollout unnamedRollout "Manus VR - Export Hand Poses 0.2 (2018-03-08)" width:456 height:952
(
	editText 'edtName' "Name: " pos:[8,8] width:440 height:16 align:#left
	button 'btnExportJSON' "Export Hand Poses" pos:[8,32] width:440 height:64 align:#left
	pickButton 'btnUseCustomBoneNames' "Use Custom Bone Names" pos:[8,104] width:440 height:24 align:#left
	-- Left group
	groupBox 'grpL' 			" Left " pos:[8,136] width:216 height:808 align:#left enabled:false
	groupBox 	'grpArmL' 		" Arm " pos:[16,152] width:200 height:88 align:#left enabled:false
	pickButton 	'btnShoulderL' 	"Shoulder" pos:[24,168] width:64 height:16 align:#left enabled:false
	editText 	'edtShoulderL' 	"" pos:[96,168] width:112 height:16 align:#left enabled:false
	pickButton 	'btnElbowL' 	"Elbow" pos:[24,192] width:64 height:16 align:#left enabled:false
	editText 	'edtElbowL' 	"" pos:[96,192] width:112 height:16 align:#left enabled:false
	pickButton 	'btnHandL' 		"Hand" pos:[24,216] width:64 height:16 align:#left enabled:false
	editText 	'edtHandL' 		"" pos:[96,216] width:112 height:16 align:#left enabled:false

	groupBox 	'grpThumbL' 	" Thumb " pos:[16,248] width:200 height:112 align:#left enabled:false
	pickButton 	'btnThumbCMCL' 	"Thumb CMC" pos:[24,264] width:64 height:16 align:#left enabled:false
	editText 	'edtThumbCMCL' 	"" pos:[96,264] width:112 height:16 align:#left enabled:false
	pickButton 	'btnThumbMPL' 	"Thumb MP" pos:[24,288] width:64 height:16 align:#left enabled:false
	editText 	'edtThumbMPL' 	"" pos:[96,288] width:112 height:16 align:#left enabled:false
	pickButton 	'btnThumbIPL' 	"Thumb IP" pos:[25,312] width:64 height:16 align:#left enabled:false
	editText 	'edtThumbIPL' 	"" pos:[96,312] width:112 height:16 align:#left enabled:false
	pickButton 	'btnThumbTipL' 	"Thumb Tip" pos:[24,336] width:64 height:16 align:#left enabled:false
	editText 	'edtThumbTipL' 	"" pos:[96,336] width:112 height:16 align:#left enabled:false
		
	groupBox 	'grpIndexL' 	" Index " pos:[16,368] width:200 height:136 align:#left enabled:false
	pickButton 	'btnIndexCMCL' 	"Index CMC" pos:[24,384] width:64 height:16 align:#left enabled:false
	editText 	'edtIndexCMCL' 	"" pos:[96,384] width:112 height:16 align:#left enabled:false
	pickButton 	'btnIndexMCPL' 	"Index MCP" pos:[24,408] width:64 height:16 align:#left enabled:false
	editText 	'edtIndexMCPL' 	"" pos:[96,408] width:112 height:16 align:#left enabled:false
	pickButton 	'btnIndexPIPL' 	"Index PIP" pos:[24,432] width:64 height:16 align:#left enabled:false
	editText 	'edtIndexPIPL' 	"" pos:[96,432] width:112 height:16 align:#left enabled:false
	pickButton 	'btnIndexDIPL' 	"Index DIP" pos:[24,456] width:64 height:16 align:#left enabled:false
	editText 	'edtIndexDIPL' 	"" pos:[96,456] width:112 height:16 align:#left enabled:false
	pickButton 	'btnIndexTipL' 	"Index Tip" pos:[24,480] width:64 height:16 align:#left enabled:false
	editText 	'edtIndexTipL' 	"" pos:[96,480] width:112 height:16 align:#left enabled:false
	
	groupBox 	'grpMiddleL' 	" Middle " pos:[16,512] width:200 height:136 align:#left enabled:false
	pickButton 	'btnMiddleCMCL' "Middle CMC" pos:[24,528] width:64 height:16 align:#left enabled:false
	editText 	'edtMiddleCMCL' "" pos:[96,528] width:112 height:16 align:#left enabled:false
	pickButton 	'btnMiddleMCPL' "Middle MCP" pos:[24,552] width:64 height:16 align:#left enabled:false
	editText 	'edtMiddleMCPL' "" pos:[96,552] width:112 height:16 align:#left enabled:false
	pickButton 	'btnMiddlePIPL' "Middle PIP" pos:[24,576] width:64 height:16 align:#left enabled:false
	editText 	'edtMiddlePIPL' "" pos:[96,576] width:112 height:16 align:#left enabled:false
	pickButton 	'btnMiddleDIPL' "Middle DIP" pos:[24,600] width:64 height:16 align:#left enabled:false
	editText 	'edtMiddleDIPL' "" pos:[96,600] width:112 height:16 align:#left enabled:false
	pickButton 	'btnMiddleTipL' "Middle Tip" pos:[24,624] width:64 height:16 align:#left enabled:false
	editText 	'edtMiddleTipL' "" pos:[96,624] width:112 height:16 align:#left enabled:false

	groupBox 	'grpRingL' 		" Ring " pos:[16,656] width:200 height:136 align:#left enabled:false
	pickButton 	'btnRingCMCL' 	"Ring CMC" pos:[24,672] width:64 height:16 align:#left enabled:false
	editText 	'edtRingCMCL' 	"" pos:[96,672] width:112 height:16 align:#left enabled:false
	pickButton 	'btnRingMCPL' 	"Ring MCP" pos:[24,696] width:64 height:16 align:#left enabled:false
	editText 	'edtRingMCPL' 	"" pos:[96,696] width:112 height:16 align:#left enabled:false
	pickButton 	'btnRingDIPL' 	"Ring DIP" pos:[24,744] width:64 height:16 align:#left enabled:false
	editText 	'edtRingDIPL' 	"" pos:[96,744] width:112 height:16 align:#left enabled:false
	pickButton 	'btnRingPIPL' 	"Ring PIP" pos:[24,720] width:64 height:16 align:#left enabled:false
	editText 	'edtRingPIPL' 	"" pos:[96,720] width:112 height:16 align:#left enabled:false
	pickButton 	'btnRingTipL' 	"Ring Tip" pos:[24,768] width:64 height:16 align:#left enabled:false
	editText 	'edtRingTipL' 	"" pos:[96,768] width:112 height:16 align:#left enabled:false

	groupBox 	'grpPinkyL' 	" Pinky " pos:[16,800] width:200 height:136 align:#left enabled:false
	pickButton 	'btnPinkyCMCL' 	"Pinky CMC" pos:[24,816] width:64 height:16 align:#left enabled:false
	editText 	'edtPinkyCMCL' 	"" pos:[96,816] width:112 height:16 align:#left enabled:false
	pickButton 	'btnPinkyMCPL' 	"Pinky MCP" pos:[24,840] width:64 height:16 align:#left enabled:false
	editText 	'edtPinkyMCPL' 	"" pos:[96,840] width:112 height:16 align:#left enabled:false
	pickButton 	'btnPinkyDIPL' 	"Pinky DIP" pos:[24,888] width:64 height:16 align:#left enabled:false
	editText 	'edtPinkyDIPL' 	"" pos:[96,864] width:112 height:16 align:#left enabled:false
	pickButton 	'btnPinkyPIPL' 	"Pinky PIP" pos:[24,864] width:64 height:16 align:#left enabled:false
	editText 	'edtPinkyPIPL' 	"" pos:[96,888] width:112 height:16 align:#left enabled:false
	pickButton 	'btnPinkyTipL' 	"Pinky Tip" pos:[24,912] width:64 height:16 align:#left enabled:false
	editText 	'edtPinkyTipL' 	"" pos:[96,912] width:112 height:16 align:#left enabled:false

	--

	-- Right group
	groupBox 'grpR' 			" Right " pos:[232,136] width:216 height:808 align:#left enabled:false
	groupBox 	'grpArmR' 		" Arm " pos:[240,152] width:200 height:88 align:#left enabled:false
	pickButton 	'btnShoulderR' 	"Shoulder" pos:[248,168] width:64 height:16 align:#left enabled:false
	editText 	'edtShoulderR' 	"" pos:[320,168] width:112 height:16 align:#left enabled:false
	pickButton 	'btnElbowR' 	"Elbow" pos:[248,192] width:64 height:16 align:#left enabled:false
	editText 	'edtElbowR' 	"" pos:[320,192] width:112 height:16 align:#left enabled:false
	pickButton 	'btnHandR' 		"Hand" pos:[248,216] width:64 height:16 align:#left enabled:false
	editText 	'edtHandR' 		"" pos:[320,216] width:112 height:16 align:#left enabled:false

	groupBox 	'grpThumbR' 	" Thumb " pos:[240,248] width:200 height:112 align:#left enabled:false
	pickButton 	'btnThumbCMCR' 	"Thumb CMC" pos:[248,264] width:64 height:16 align:#left enabled:false
	editText 	'edtThumbCMCR' 	"" pos:[320,264] width:112 height:16 align:#left enabled:false
	pickButton 	'btnThumbMPR' 	"Thumb MP" pos:[248,288] width:64 height:16 align:#left enabled:false
	editText 	'edtThumbMPR' 	"" pos:[320,288] width:112 height:16 align:#left enabled:false
	pickButton 	'btnThumbIPR' 	"Thumb IP" pos:[25,312] width:64 height:16 align:#left enabled:false
	editText 	'edtThumbIPR' 	"" pos:[320,312] width:112 height:16 align:#left enabled:false
	pickButton 	'btnThumbTipR' 	"Thumb Tip" pos:[248,336] width:64 height:16 align:#left enabled:false
	editText 	'edtThumbTipR' 	"" pos:[320,336] width:112 height:16 align:#left enabled:false
		
	groupBox 	'grpIndexR' 	" Index " pos:[240,368] width:200 height:136 align:#left enabled:false
	pickButton 	'btnIndexCMCR' 	"Index CMC" pos:[248,384] width:64 height:16 align:#left enabled:false
	editText 	'edtIndexCMCR' 	"" pos:[320,384] width:112 height:16 align:#left enabled:false
	pickButton 	'btnIndexMCPR' 	"Index MCP" pos:[248,408] width:64 height:16 align:#left enabled:false
	editText 	'edtIndexMCPR' 	"" pos:[320,408] width:112 height:16 align:#left enabled:false
	pickButton 	'btnIndexPIPR' 	"Index PIP" pos:[248,432] width:64 height:16 align:#left enabled:false
	editText 	'edtIndexPIPR' 	"" pos:[320,432] width:112 height:16 align:#left enabled:false
	pickButton 	'btnIndexDIPR' 	"Index DIP" pos:[248,456] width:64 height:16 align:#left enabled:false
	editText 	'edtIndexDIPR' 	"" pos:[320,456] width:112 height:16 align:#left enabled:false
	pickButton 	'btnIndexTipR' 	"Index Tip" pos:[248,480] width:64 height:16 align:#left enabled:false
	editText 	'edtIndexTipR' 	"" pos:[320,480] width:112 height:16 align:#left enabled:false
	
	groupBox 	'grpMiddleR' 	" Middle " pos:[240,512] width:200 height:136 align:#left enabled:false
	pickButton 	'btnMiddleCMCR' "Middle CMC" pos:[248,528] width:64 height:16 align:#left enabled:false
	editText 	'edtMiddleCMCR' "" pos:[320,528] width:112 height:16 align:#left enabled:false
	pickButton 	'btnMiddleMCPR' "Middle MCP" pos:[248,552] width:64 height:16 align:#left enabled:false
	editText 	'edtMiddleMCPR' "" pos:[320,552] width:112 height:16 align:#left enabled:false
	pickButton 	'btnMiddlePIPR' "Middle PIP" pos:[248,576] width:64 height:16 align:#left enabled:false
	editText 	'edtMiddlePIPR' "" pos:[320,576] width:112 height:16 align:#left enabled:false
	pickButton 	'btnMiddleDIPR' "Middle DIP" pos:[248,600] width:64 height:16 align:#left enabled:false
	editText 	'edtMiddleDIPR' "" pos:[320,600] width:112 height:16 align:#left enabled:false
	pickButton 	'btnMiddleTipR' "Middle Tip" pos:[248,624] width:64 height:16 align:#left enabled:false
	editText 	'edtMiddleTipR' "" pos:[320,624] width:112 height:16 align:#left enabled:false

	groupBox 	'grpRingR' 		" Ring " pos:[240,656] width:200 height:136 align:#left enabled:false
	pickButton 	'btnRingCMCR' 	"Ring CMC" pos:[248,672] width:64 height:16 align:#left enabled:false
	editText 	'edtRingCMCR' 	"" pos:[320,672] width:112 height:16 align:#left enabled:false
	pickButton 	'btnRingMCPR' 	"Ring MCP" pos:[248,696] width:64 height:16 align:#left enabled:false
	editText 	'edtRingMCPR' 	"" pos:[320,696] width:112 height:16 align:#left enabled:false
	pickButton 	'btnRingDIPR' 	"Ring DIP" pos:[248,744] width:64 height:16 align:#left enabled:false
	editText 	'edtRingDIPR' 	"" pos:[320,744] width:112 height:16 align:#left enabled:false
	pickButton 	'btnRingPIPR' 	"Ring PIP" pos:[248,720] width:64 height:16 align:#left enabled:false
	editText 	'edtRingPIPR' 	"" pos:[320,720] width:112 height:16 align:#left enabled:false
	pickButton 	'btnRingTipR' 	"Ring Tip" pos:[248,768] width:64 height:16 align:#left enabled:false
	editText 	'edtRingTipR' 	"" pos:[320,768] width:112 height:16 align:#left enabled:false

	groupBox 	'grpPinkyR' 	" Pinky " pos:[240,800] width:200 height:136 align:#left enabled:false
	pickButton 	'btnPinkyCMCR' 	"Pinky CMC" pos:[248,816] width:64 height:16 align:#left enabled:false
	editText 	'edtPinkyCMCR' 	"" pos:[320,816] width:112 height:16 align:#left enabled:false
	pickButton 	'btnPinkyMCPR' 	"Pinky MCP" pos:[248,840] width:64 height:16 align:#left enabled:false
	editText 	'edtPinkyMCPR' 	"" pos:[320,840] width:112 height:16 align:#left enabled:false
	pickButton 	'btnPinkyDIPR' 	"Pinky DIP" pos:[248,888] width:64 height:16 align:#left enabled:false
	editText 	'edtPinkyDIPR' 	"" pos:[320,864] width:112 height:16 align:#left enabled:false
	pickButton 	'btnPinkyPIPR' 	"Pinky PIP" pos:[248,864] width:64 height:16 align:#left enabled:false
	editText 	'edtPinkyPIPR' 	"" pos:[320,888] width:112 height:16 align:#left enabled:false
	pickButton 	'btnPinkyTipR' 	"Pinky Tip" pos:[248,912] width:64 height:16 align:#left enabled:false
	editText 	'edtPinkyTipR' 	"" pos:[320,912] width:112 height:16 align:#left enabled:false

)

createDialog unnamedRollout