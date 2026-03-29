extends StaticBody3D

var tum_parcalar = []
var secili_mi = false

func _ready():
	add_to_group("binalar")
	# Tarama alanını genişletiyoruz: Scriptin olduğu yerin tüm hiyerarşisini tara
	tum_parcalar.clear()
	_derin_tarama(get_parent())
	# Eğer hala parlamıyorsa 'self' yerine 'get_parent()' deneyebilirsin

func _derin_tarama(dugum):
	if dugum is MeshInstance3D:
		# Küçük binaların yanmamasını istiyorsan buraya isim filtresi eklenebilir
		if not "kucuk" in dugum.name.to_lower():
			tum_parcalar.append(dugum)
			
	for child in dugum.get_children():
		_derin_tarama(child)

func _unhandled_input(event):
	# Eğer Sol Menü (Hub) açıksa, haritadaki tıklamaları engelle
	var hub = get_tree().get_first_node_in_group("sol_hub")
	if hub and hub.visible:
		return

	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var ray_sonucu = _get_raycast_hit()
		
		if ray_sonucu and not ray_sonucu.is_empty():
			var carpan_obje = ray_sonucu.get("collider")
			
			if carpan_obje == self:
				get_viewport().set_input_as_handled()
				
				if secili_mi:
					sondur()
				else:
					# Önce diğer her şeyi söndür (Hub dahil)
					get_tree().call_group("binalar", "sondur")
					parlat()
			
			elif carpan_obje and carpan_obje.is_in_group("binalar"):
				if secili_mi:
					sondur()
		else:
			if secili_mi:
				sondur()

func _get_raycast_hit():
	var mouse_pos = get_viewport().get_mouse_position()
	var camera = get_viewport().get_camera_3d()
	if not camera: return {}
	
	var ray_origin = camera.project_ray_origin(mouse_pos)
	var ray_end = ray_origin + camera.project_ray_normal(mouse_pos) * 2000
	var query = PhysicsRayQueryParameters3D.create(ray_origin, ray_end)
	query.collide_with_bodies = true
	
	var space_state = get_world_3d().direct_space_state
	return space_state.intersect_ray(query)
@export_placeholder("Binanın adını gir...") var bina_ozel_ismi : String = ""
@export_multiline var bina_detay_bilgisi : String = ""
func parlat():

	secili_mi = true
	print("Parlat fonskiyonu calisti, bulunan parca sayisi: ", tum_parcalar.size())
	
	for parca in tum_parcalar:
		if parca is MeshInstance3D:
			# Override material yerine overlay kullanmak daha garantidir
			var mat = StandardMaterial3D.new()
			mat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
			mat.albedo_color = Color(1, 1, 1, 0.3) # Beyazımsı şeffaf parlama
			mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
			
			parca.material_overlay = mat 
	
	get_tree().call_group("sol_hub", "hub_ac", self)

func sondur():
	secili_mi = false
	for parca in tum_parcalar:
		if parca is MeshInstance3D:
			parca.material_overlay = null
	
	get_tree().call_group("sol_hub", "hub_kapat")

func _on_game_tick_updated(value):
	print("!")
