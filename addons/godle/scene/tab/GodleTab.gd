tool
extends VBoxContainer

var TaskParser = preload("res://addons/godle/GradleTaskParser.gd")
var task_parser = TaskParser.new()

func _ready():
	
	$Panel/HBoxContainer/Refresh.icon = get_icon("Reload", "EditorIcons")
	import()
	pass

func import():
	run_gradle_on_thread("gradle_import",null)
	pass

func run_gradle_on_thread(function,arg):
	var thread = Thread.new()
	thread.start(self, function,arg)

func gradle_import(arg):
	var output = run_task("tasks")
	task_parser.load_tasks(output)
	task_parser.build_tree($ScrollContainer/Tree)

func run_task(task)->Array:
	var output = []
	var offline_mode = not $Panel/HBoxContainer/Online.pressed
	
	if(OS.get_name() == "Windows"):
		var args = ["/C","./gradlew.bat"]
		if task != null:
			args.append(task)
		if offline_mode:
			args.append("--offline")
		OS.execute("CMD.exe", args,true, output)
	else:
		var args = []
		if task != null:
			args.append(task)
		if offline_mode:
			args.append("--offline")
		OS.execute("./gradlew",[task],true,output)
	var lines = output[0].split("\n") as Array
	lines.pop_front()
	for line in lines:
		print(line)
	return lines
	pass

	pass

func _exit_tree():
	pass

func _on_Tree_item_activated():
	var selected = $ScrollContainer/Tree.get_selected()
	var task_name = selected.get_text(0)
	print("Executing gradle task "+task_name+"!")
	run_gradle_on_thread("run_task",task_name)
	
	pass # Replace with function body.
