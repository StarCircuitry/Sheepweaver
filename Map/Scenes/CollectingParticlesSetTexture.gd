extends CPUParticles2D

@export var dyeCollectParticle : Texture2D
	
func _ready():
	self.texture = dyeCollectParticle
