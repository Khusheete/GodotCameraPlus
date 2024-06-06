# Copyright (c) 2024 Souchet Ferdinand (@Khusheete)
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
# the Software, and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
# FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
# IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

class_name CameraPlus2D
extends Camera2D


var shake_tween: Tween


## Shakes the camera by some amount on each coordinate.
## it will shake for `time` seconds doing `shake_per_seconds`.
## shakes every second. 
func shake(
		amount: float, time: float = 0.15,
		x_axis := Vector2(1.0, 0.0), y_axis := Vector2(0.0, 1.0),
		shake_per_seconds: float = 60.0
	) -> void:
	if shake_tween:
		shake_tween.kill()
	
	shake_tween = create_tween()
	
	var shake_count: float = shake_per_seconds * time
	
	var single_shake_time: float = 1.0 / shake_per_seconds
	
	# Do the shake
	for _i in roundi(shake_count):
		var shake_offset: Vector2
		shake_offset = amount * Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0))
		shake_offset = x_axis * shake_offset.x + y_axis * shake_offset.y
		shake_tween.tween_property(self, ^"offset", shake_offset, single_shake_time)
	
	shake_tween.tween_property(self, ^"offset", Vector2.ZERO, single_shake_time)


## Returns whether the camera is currently shaking or not 
func is_shaking() -> bool:
	if not shake_tween:
		return false
	return shake_tween.is_running()
