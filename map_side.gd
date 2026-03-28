extends TextureRect

# Sadece bir üst düğüme (UI) çıkıyoruz
@onready var ana_ui = $".."

# İki üst düğüme çıkıp HaritaEkrani'ni buluyoruz (Seninkinde bir tane ../ eksikti)
@onready var harita_ekrani = $"../../HaritaEkrani"

# Tıklamaları algılayan Godot'nun ana fonksiyonu (İsmi tam olarak böyle olmalı)
func _gui_input(event):
	# Sadece farenin sol tıkına basıldığında çalışsın
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		
		ana_ui.hide() # Arayüzü gizle
		
		harita_ekrani.show() # Haritayı tam ekran aç (Sadece visible=true yazarsan hata olur)
		
		accept_event()
