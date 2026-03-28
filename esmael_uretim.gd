extends TextureButton

@export var bolge_ismi: String = "BÖLGE İSMİ BURAYA"
@export_multiline var bolge_detayi: String = "Bölge detayları..."

func _ready():
	pressed.connect(_bolgeye_tiklandi)

func _bolgeye_tiklandi():
	# --- KONTROL İÇİN TEST YAZISI ---
	print("TIKLANDI: ", bolge_ismi) 
	# --------------------------------
	
	%BolgeIsmi.text = bolge_ismi
	%BolgeDetayi.text = bolge_detayi
	%BilgiPaneli.show()
