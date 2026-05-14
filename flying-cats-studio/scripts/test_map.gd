extends Node2D

@onready var player: CharacterBody2D = %Player
@onready var enemy: CharacterBody2D = %Enemy

var currently_equipped : Item = null

func _ready():
	HotBar.current_scene = self
	
