# GameEvent.gd (Resource Sınıfın)
extends Resource
class_name GameEvent

@export var event_speaker: String
@export var event_text: String
@export var options: Array[String] = ["Seçenek 1", "Seçenek 2"] # Kaç yazı varsa o kadar buton olur

# Her seçenek için ayrı etkiler (Dictionary dizisi)
@export var effects_list: Array[Dictionary] = [
	{"para": 10, "moral": -5}, # 1. seçeneğin etkisi
	{"para": -10, "moral": 5}   # 2. seçeneğin etkisi
]
# Buradaki isimler Main scriptindeki "kaynaklar" anahtarlarıyla AYNI olmalı
@export var etkiler = {
	"para": 0,
	"yemek": 0,
	"moral": 0,
	"metal": 0,
	"ahsap": 0
}
