extends KinematicBody2D

export (int) var speed = 200
export (PackedScene) var Bullet
export (int) var health = 100
export (int) var oxygen_use_rate = 10

var oxygen_cooldown
var velocity = Vector2()

func _ready():
	oxygen_cooldown = 10 / oxygen_use_rate

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)

func _process(delta):
	oxygen_cooldown -= delta
	$HUD/Health.set_text(str(health))
	
	if (oxygen_cooldown < 0):
		oxygen_cooldown = 10 / oxygen_use_rate
		health -= 1

func get_input():
	$Sprite.look_at(get_global_mouse_position())
	$CollisionShape2D.look_at(get_global_mouse_position())
	$Sprite/Muzzle.look_at(get_global_mouse_position())
	velocity = Vector2()
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	velocity = velocity.normalized() * speed
		
	if Input.is_action_just_pressed("shoot"):
		shoot()

func shoot():
	var b = Bullet.instance()
	owner.add_child(b)
	b.transform = get_node("Sprite/Muzzle").global_transform
	health -= 1


