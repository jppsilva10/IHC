extends RigidBody2D

var newDeltaX = 0
var newDeltaY = 0
var deltaX = 0
var deltaY = 0
var touchPos = Vector2()
var areaEnt = false
var index = -1

onready var sprite = get_node("icon5")

var touched = false

func _on_TouchScreenButton_pressed():
	areaEnt = true
	

func _on_TouchScreenButton_released():
	areaEnt = false
	
func _input(event):
	if true:
		if event is InputEventScreenTouch and event.is_pressed():
			
			if event.index == index:
				touchPos = event.get_position()
				deltaX = touchPos.x - position.x
				deltaY = touchPos.y - position.y
			
		elif event is InputEventScreenDrag:
			if event.index == index:
				print(position)
				touchPos = event.get_position()
				newDeltaX = touchPos.x - deltaX
				newDeltaY  = touchPos.y - deltaY
				set_position(Vector2(newDeltaX, newDeltaY))
				touched = true
			

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _integrate_forces(delta):
	if touched:
		global_transform.origin = Vector2(newDeltaX, newDeltaY)
		#set_position(Vector2(newDeltaX, newDeltaY))
		touched = false
	
# Called when the node enters the scene tree for the first time.
func _ready():
	print(sprite)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _unhandled_input(event):
	#print(index)
	
	var region_rect 
	if(sprite!=null):
		region_rect = sprite.get_rect()
	#print(get_rect().size)
		if event is InputEventScreenTouch and event.pressed:
			if event.position.x > position.x - region_rect.size.x/2 and event.position.x < position.x + region_rect.size.x/2:
				if event.position.y > position.y - region_rect.size.y/2 and event.position.y < position.y + region_rect.size.y/2:
				#print(event)
					print("lalalala")
					index = event.index
		elif event is InputEventScreenDrag and index == event.index:
			if event.position.x > position.x - region_rect.size.x/2 and event.position.x < position.x + region_rect.size.x/2:
				if event.position.y > position.y - region_rect.size.y/2 and event.position.y < position.y + region_rect.size.y/2:
				#print(event)
					index = event.index
		elif event is InputEventScreenTouch and not event.pressed and index == event.index:
			index = -1


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventScreenTouch:
		print("aaaa")
		print(event)
		var c = get_node("../Sb")
		c.text = str(event)
	if event is InputEventScreenTouch and event.pressed:
	#if event is InputEventScreenTouch and event.is_pressed():
		index = event.index
	elif event is InputEventScreenDrag:
	#elif event is InputEventMouseMotion:
		index = event.index	

