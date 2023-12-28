extends RigidBody3D

var mouse_sensitivity := 0.001
var twist_input := 0.0
var pitch_input := 0.0

#@onready var bullet_object := load("res://projectile.tscn")

@onready var twist_pivot := $TwistPivot
@onready var pitch_pivot := $TwistPivot/PitchPivot

var bullet_instance = load("res://projectile.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var input := Vector3.ZERO
	input.x = Input.get_axis("move_left","move_right")
	input.z = Input.get_axis("move_forward","move_back")
	
	apply_central_force( twist_pivot.basis * input * 1200.0 * delta )
	
	if Input.is_action_just_pressed("ui_cancel"):
		#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().quit()
	
	if Input.is_action_just_pressed("mouse_click"):
		var bullet_coppies = bullet_instance.instantiate()
		#bullet_coppies.set_rotation(twist_pivot.basis.x) 
		#bullet_coppies.basis.x = twist_pivot.basis.x
		#bullet_coppies.rotation.x = deg_to_rad(90)
		#bullet_coppies.rotation.y = - twist_pivot.rotation.y
		add_child(bullet_coppies)
		#bullet_coppies.basis(twist_pivot.get_parent().basis.get_rotation_quaternion())
		
		#.transform.basis(Vector3(0,0,0))
	
	twist_pivot.rotate_y(twist_input)
	pitch_pivot.rotate_x(pitch_input)
	pitch_pivot.rotation.x = clamp(pitch_pivot.rotation.x,
		deg_to_rad(-30),
		deg_to_rad(30)
	)
	twist_input = 0.0
	pitch_input = 0.0
	
	

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			twist_input = - event.relative.x * mouse_sensitivity
			pitch_input = - event.relative.y * mouse_sensitivity
