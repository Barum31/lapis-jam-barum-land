# GameEvent.gd (Resource Sınıfın)
extends Resource
class_name GameEvent

@export var event_text: String
@export var secenek_yazisi: String

# Buradaki isimler Main scriptindeki "kaynaklar" anahtarlarıyla AYNI olmalı
@export var etkiler = {
	"para": 0,
	"yemek": 0,
	"moral": 0,
	"metal": 0,
	"ahsap": 0
}
