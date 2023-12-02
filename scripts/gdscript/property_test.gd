@tool
extends Node3D
class_name PropertyTest

@export var holding_hammer = false:
	set(value):
		holding_hammer = value
		notify_property_list_changed()
var hammer_type = 0

func _get_property_list():
	# 默认情况下，`hammer_type` 在编辑器中不可见。
	var property_usage = PROPERTY_USAGE_NO_EDITOR

	if holding_hammer:
		property_usage = PROPERTY_USAGE_DEFAULT

	var properties = []
	properties.append({
		"name": "hammer_type",
		"type": TYPE_INT,
		"usage": property_usage, # 参见上面的赋值。
		"hint": PROPERTY_HINT_ENUM,
		"hint_string": "Wooden,Iron,Golden,Enchanted"
	})

	return properties
