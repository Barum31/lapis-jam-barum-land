class_name GameEvent
extends Resource

@export var event_title: String
@export_multiline var event_description: String

# Artık her seçim kendi içinde metnini, sonucunu ve 5 bedelini taşıyor
@export var choices: Array[EventChoice] = []
