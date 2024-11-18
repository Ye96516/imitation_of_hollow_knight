class_name StateMachine extends Node

@export var current_state:StateBase
var last_state:StateBase

func _ready() -> void:
	for i in get_children():
		if i is StateBase:
			i.state_machine=self
	await get_parent().ready
	current_state.enter()

func _process(delta: float) -> void:
	current_state.process_tick(delta)
	
func _physics_process(delta: float) -> void:
	current_state.physicis_tick(delta)

func change_state(state_name:String):
	var target_state=get_node(state_name)
	if not is_instance_valid(target_state):
		printerr("目标节点为空，请检查状态名称是否正确")
		return
	last_state=current_state
	current_state.exit()
	current_state=target_state
	current_state.enter()
