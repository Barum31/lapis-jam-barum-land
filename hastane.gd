extends StaticBody3D

var tum_parcalar = []
var secili_mi = false

# --- SAĞ TARAFTA (INSPECTOR) ÇIKACAK KUTULAR ---
@export var bina_ozel_ismi : String = ""
@export_multiline var bina_detay_bilgisi : String = "Bu bina hakkında henüz bilgi girilmedi."
@export var parlama_rengi : Color = Color(1, 1, 1, 0.2) 

func _ready():
	add_to_group("binalar")
	input_ray_pickable = true
	tum_parcalar.clear()
	_derin_tarama(self)

func _derin_tarama(dugum):
	if dugum is MeshInstance3D:
		tum_parcalar.append(dugum)
	for child in dugum.get_children():
		_derin_tarama(child)

func _unhandled_input(event):
	var sol_menu = get_tree().get_first_node_in_group("sol_hub")
	if sol_menu and sol_menu.visible:
		return 

	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var ray_sonucu = _get_raycast_hit()
		
		if ray_sonucu and not ray_sonucu.is_empty():
			var carpan = ray_sonucu.get("collider")
			if carpan == self:
				get_viewport().set_input_as_handled()
				if secili_mi:
					sondur()
				else:
					get_tree().call_group("binalar", "sondur")
					parlat()
			elif carpan.is_in_group("binalar") and secili_mi:
				sondur()
		elif secili_mi:
			sondur()

func _get_raycast_hit():
	var mouse_pos = get_viewport().get_mouse_position()
	var camera = get_viewport().get_camera_3d()
	if not camera: return {}
	var ray_origin = camera.project_ray_origin(mouse_pos)
	var ray_end = ray_origin + camera.project_ray_normal(mouse_pos) * 2000
	var query = PhysicsRayQueryParameters3D.create(ray_origin, ray_end)
	return get_world_3d().direct_space_state.intersect_ray(query)

func parlat():
	secili_mi = true
	var mat = StandardMaterial3D.new()
	mat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	mat.albedo_color = parlama_rengi
	mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	
	for parca in tum_parcalar:
		parca.material_overlay = mat
	
	# SADECE "SELF" GÖNDERİYORUZ (Hatayı önleyen kısım)
	get_tree().call_group("sol_hub", "hub_ac", self)

func sondur():
	secili_mi = false
	for parca in tum_parcalar:
		parca.material_overlay = null
