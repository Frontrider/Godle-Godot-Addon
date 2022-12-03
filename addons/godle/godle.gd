tool
extends EditorPlugin

var TaskParser = preload("res://addons/godle/GradleTaskParser.gd")
var task_parser = TaskParser.new()
var TabScene = preload("res://addons/godle/scene/tab/GodleTab.tscn")

var tab = TabScene.instance()

func _enter_tree():
	tab.task_parser = task_parser
	tab.name= "Gradle"
	add_control_to_dock(EditorPlugin.DOCK_SLOT_RIGHT_UL,tab)
	pass


func _exit_tree():
	remove_control_from_docks(tab)
	tab.queue_free()

	pass
