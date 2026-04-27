extends Node

var tokens = 6
var fragments = []
var xp = {
    "fantasy": 0,
    "tech": 0,
    "prehistoric": 0,
    "heaven": 0,
    "earth": 0
}
var medal_unlocked = false

func add_fragment(world_name):
    if world_name not in fragments:
        fragments.append(world_name)

func use_token():
    if tokens > 0:
        tokens -= 1
        return true
    return false

func gain_xp(world_name, amount):
    xp[world_name] += amount
