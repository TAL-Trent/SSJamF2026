extends Node


func _on_button_pressed(level: String) -> void:
	get_tree().change_scene_to_file("res://Levels/Level Select/Level_Select.tscn")
