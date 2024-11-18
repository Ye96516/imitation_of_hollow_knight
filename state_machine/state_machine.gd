class_name StateMachine extends Node

@export var current_scene:StateBase

func _ready() -> void:
	for i in get_children():
		if i is StateBase:
			i.state_machine=self
	current_scene.enter()

func _process(delta: float) -> void:
	current_scene.process_tick(delta)
	
func _physics_process(delta: float) -> void:
	current_scene.physicis_tick(delta)

func change_state(state_name:String):
	var target_state=get_node(state_name)
	if not target_state:
		printerr("目标节点为空，请检查状态名称是否正确")
	current_scene.exit()
	current_scene=target_state
	current_scene.enter()
