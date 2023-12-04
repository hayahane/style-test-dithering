extends Node

@export var wind_curve: Curve
@export var speed: float
@export var wind_vector: Vector3

var current_state: float = 0.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	current_state += delta * speed
	current_state -= floor(current_state) 
	RenderingServer.global_shader_parameter_set("wind_vector",
		wind_curve.sample(current_state) * wind_vector)
