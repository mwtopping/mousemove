extends Node2D


var emit
var rotspeed = 1
var angle = 0
var radius = 100
var lifetime = radius/100*5
var scl = 0.01
var emitpoints = PackedVector2Array()


# Called when the node enters the scene tree for the first time.
func _ready():
	self.emit = get_node("CPUParticles2D")
	var a = 0;
	var Npoints = 16
	for ii in Npoints:
		emitpoints.append(Vector2(self.radius*sin(a), self.radius*cos(a)))
		a += 2*PI/Npoints

	self.emit.emission_points = emitpoints
	self.emit.lifetime=self.lifetime

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.angle += rotspeed*delta
	self.emit.rotation=self.angle
	
	self.rotation = -2*self.angle
	if self.scl < 1:
		self.scl += 3*delta
		
		#self.emit.radial_accel_min = amin/(1-self.scl)
		#self.emit.radial_accel_max = amax/(1-self.scl)
		
		
		self.scale = Vector2(self.scl, self.scl)
		self.emit.scale_amount_min = 2*self.scl
		self.emit.scale_amount_max = 2*self.scl
		

