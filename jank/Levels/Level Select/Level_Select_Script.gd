extends Node


func _on_button_pressed(level: String) -> void:
	print("level selected: " + level)
	get_tree().change_scene_to_file("res://Levels/Level " + level + "/Level_" + level + ".tscn")
