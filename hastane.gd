extends StaticBody3D

var tum_parcalar = []
var secili_mi = false

# Parlama ayarı (İstediğin rengi ve gücü buradan ayarla)
@export var parlama_rengi : Color = Color(1, 1, 1, 0.2) 

func _ready():
	# 1. Gruba ekle
	add_to_group("binalar")
	# 2. Tıklanabilirliği kodla açalım (Garanti olsun)
	input_ray_pickable = true
	
	# 3. Derinlemesine tarama: Klasörlerin en dibindeki Mesh'leri bulur
	tum_parcalar.clear()
	_derin_tarama(self)
	
	# Çıktı panelinde kaç parça bulduğunu kontrol et
	print(name, " içinde bulunan görsel parça sayısı: ", tum_parcalar.size())

# Bu fonksiyon, modelin içindeki kilitli veya alt klasördeki her şeyi bulur
func _derin_tarama(dugum):
	if dugum is MeshInstance3D:
		tum_parcalar.append(dugum)
	for child in dugum.get_children():
		_derin_tarama(child)

func _unhandled_input(event):
	# Sol tık yapıldığında
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var ray_sonucu = _get_raycast_hit()
		
		if ray_sonucu and not ray_sonucu.is_empty():
			var çarpan = ray_sonucu.get("collider")
			
			# Eğer tıklanan bu hastane ise
			if çarpan == self:
				get_viewport().set_input_as_handled()
				if secili_mi:
					sondur()
				else:
					# Önce gruptaki diğer her şeyi söndür, sonra bunu parlat
					get_tree().call_group("binalar", "sondur")
					parlat()
			# Başka bir binaya tıklandıysa bunu söndür
			elif çarpan.is_in_group("binalar") and secili_mi:
				sondur()
		# Boşluğa tıklandıysa söndür
		elif secili_mi:
			sondur()

# Fare pozisyonundan lazer (Raycast) gönderen sistem
func _get_raycast_hit():
	var mouse_pos = get_viewport().get_mouse_position()
	var camera = get_viewport().get_camera_3d()
	if not camera: return {}
	
	var ray_origin = camera.project_ray_origin(mouse_pos)
	var ray_end = ray_origin + camera.project_ray_normal(mouse_pos) * 2000
	var query = PhysicsRayQueryParameters3D.create(ray_origin, ray_end)
	
	var space_state = get_world_3d().direct_space_state
	return space_state.intersect_ray(query)

func parlat():
	secili_mi = true
	for parca in tum_parcalar:
		# En sorunsuz parlama yöntemi: Overlay
		var mat = StandardMaterial3D.new()
		mat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
		mat.albedo_color = parlama_rengi
		mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
		
		parca.material_overlay = mat

func sondur():
	secili_mi = false
	for parca in tum_parcalar:
		parca.material_overlay = null
