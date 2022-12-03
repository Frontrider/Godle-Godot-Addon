tool
extends Reference

#dict keyed with task groups, the values are lists of the task names
var tasks = {}
var project_name = ""

func load_tasks(output:Array):
	print(output.size())
	skip_to_tasks(output)
	print(output.size())
	parse_tasks(output)
	print("project: "+project_name)
	print("loaded tasks:")
	for key in tasks.keys():
		print(key+":")
		for task in tasks[key]:
			print(task)
		pass
	pass

func build_tree(tree:Tree):
	var root = tree.create_item()
	root.set_text(0,project_name)
	for key in tasks.keys():
		var group = tree.create_item(root)
		group.set_text(0,key.strip_edges())
		group.collapsed = true
		for task in tasks[key]:
			var split = task.split("-")
			var task_node = tree.create_item(group)
			task_node.set_text(0,split[0].strip_edges())
			task_node.set_tooltip(0,split[1].strip_edges())
		pass
	pass

func skip_to_tasks(output:Array):
	var found_tasks = false

	while not found_tasks:
		if "Tasks runnable from root project " in output[0]:
			project_name = output[0].replace("Tasks runnable from root project ","").replace("'","")
			found_tasks = true
		output.pop_front()
	
	#pop the end of the log.
	for i in range(8):
		output.pop_back()
	pass

func parse_tasks(output:Array):
	var current_group = ""
	for line in output:
		if line.ends_with("Rules"):
			return
		if line.ends_with("tasks"):
			current_group = line
			tasks[current_group] = []
		elif not current_group.empty():
			if not "---" in line and not line.empty():
				tasks[current_group].append(line)
	pass
