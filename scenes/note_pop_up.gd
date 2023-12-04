extends Area3D

@export var pop_up_note: Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pop_up_note.visible = false;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if (body.name == "CharacterBody3D"):
		pop_up_note.visible = true


func _on_body_exited(body):
	if (body.name == "CharacterBody3D"):
		pop_up_note.visible = false
