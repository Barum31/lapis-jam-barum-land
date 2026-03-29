extends TextureRect

@onready var isim_etiketi = $Panel/BinaIsmi
@onready var bilgi_etiketi = $Panel/BinaBilgi

func _ready():
	add_to_group("sol_hub")
	visible = false
	if has_node("KapatButonu"):
		$KapatButonu.pressed.connect(_on_kapat_pressed)

func hub_ac(bina_objesi):
	visible = true
	
	# HATA KONTROLÜ: Gelen şey bir obje mi ve içinde o değişkenler var mı?
	if bina_objesi is Object and "bina_ozel_ismi" in bina_objesi:
		if bina_objesi.bina_ozel_ismi != "":
			isim_etiketi.text = bina_objesi.bina_ozel_ismi
		else:
			isim_etiketi.text = bina_objesi.name.capitalize()
		
		bilgi_etiketi.text = bina_objesi.bina_detay_bilgisi
	else:
		# Eğer bina eski koddaysa veya değişkenler yoksa:
		isim_etiketi.text = str(bina_objesi.name).capitalize() if bina_objesi is Object else str(bina_objesi)
		bilgi_etiketi.text = "Bu binanın kodunda @export değişkenleri eksik!"

func _on_kapat_pressed():
	hide()
	var ana_ui = get_tree().root.find_child("UI", true, false)
	if ana_ui:
		ana_ui.mouse_filter = Control.MOUSE_FILTER_STOP
	get_tree().call_group("binalar", "sondur")
