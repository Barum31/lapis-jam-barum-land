extends Control

# Hazırladığın süslü butonu buraya tanıtıyoruz
const MY_BUTTON_SCENE = preload("res://EventButton.tscn") 

@onready var options_container = $secenekler
@onready var desc_label = $TextureRect/event_text
@onready var name_label = $TextureRect/speaker_label

# --- BURASI EKSİKTİ: Fonksiyonun başlangıcı ---
func display_event(data: GameEvent):
	# 1. Metinleri Resource'tan (GameEvent) çekip yazdır
	desc_label.text = data.event_text
	name_label.text = data.event_speaker
	
	# 2. Zamanı durdur (Main scriptindeki fonksiyonu çağırıyoruz)
	if get_parent().has_method("zamani_durdur"):
		get_parent().zamani_durdur()
	
	# 3. Önceki eventten kalan butonları temizle
	for child in options_container.get_children():
		child.queue_free()
	
	# 4. Verideki seçenek sayısı kadar senin süslü butonundan oluştur
	for i in range(data.options.size()):
		var btn = MY_BUTTON_SCENE.instantiate() # Senin assetin olan buton
		
		# Butonun içindeki Label'a ulaş ve metni yaz
		# (EĞER EventButton.tscn içindeki Label'ın adı farklıysa burayı düzelt)
		var btn_label = btn.get_node("Label") 
		btn_label.text = data.options[i]
		
		# Butonu VBoxContainer (secenekler) içine ekle
		options_container.add_child(btn)
		
		# Butona tıklandığında ne olacağını (etki paketini) bağla
		var current_effects = data.effects_list[i]
		btn.pressed.connect(_on_option_selected.bind(current_effects))
# --- Fonksiyonun sonu ---

func _on_option_selected(effects: Dictionary):
	# Main scriptindeki fonksiyonları tetikle
	if get_parent().has_method("apply_event_effects"):
		get_parent().apply_event_effects(effects)
	
	if get_parent().has_method("zamani_baslat"):
		get_parent().zamani_baslat()
		
	self.hide()
