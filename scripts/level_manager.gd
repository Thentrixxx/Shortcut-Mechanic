extends Node

var next_level_selected

# Dictionary that manages the entire game.
var shortcuts = {
	"Shortcut_Placeholder": {"Score": 0, "Priority": 0}
}

# Function on startup for testing.
func _ready():
	pass

# Function that adds a shortcut to the dictionary "shortcuts"
func add_shortcut(shortcut: String, score: int, priority: int):
	# Checking if the shortcut doesn't exist yet.
	var has_shortcut = false
	for i in shortcuts:
		if i == shortcut:
			has_shortcut = true
	
	# If the shortcut doesn't exist yet, create it.
	if has_shortcut == false:
		shortcuts[shortcut] = {
			"Score": score,
			"Priority": priority,
		}


# Function for removing a dictionary entry.
func remove_shortcut(shortcut: String):
	shortcuts.erase(str(shortcut))


# Function for Adding Score to a specific shortcut.
func add_score(shortcut: String, amount: int):
	var score = clampi(shortcuts[shortcut]["Score"] + amount, 0, 500)
	shortcuts[shortcut]["Score"] = score


# Function for Adding Score to a specific shortcut.
func subtract_score(shortcut: String, amount: int):
	var score = clampi(shortcuts[shortcut]["Score"] - amount, 0, 500)
	shortcuts[shortcut]["Score"] = score


# Function that prints all entries of the dictionary "shortcuts".
func print_shortcuts():
	print("----------------------")
	for i in shortcuts:
		print(str(i) + ": ")
		for x in shortcuts[i]:
			print(str(x) + ": " + str(shortcuts[i][x]))
		print()
	print("----------------------")
	

# Function responsible for giving the player a level based on the dictionary.
func give_level():
	var next_level_level = 26
	for i in shortcuts:
		var is_priority = false
		var shortcut = i
		var score: int
		var priority: int
		
		for x in shortcuts[i]:
			if is_priority == false:
				score = shortcuts[i][x]
				is_priority = true
			elif is_priority == true:
				priority = shortcuts[i][x]
				is_priority = false
		
		print(str(shortcut))
		print(str(score))
		print(str(priority))
		
		var level = 999
		
		if priority == 0:
			level = 999
		
		elif priority == 1:
			if score <= 99:
				level = 1
			elif score <= 199:
				level = 2
			elif score <= 299:
				level = 4
			elif score <= 399:
				level = 7
			elif score <= 499:
				level = 11
			else:
				pass
			
		elif priority == 2:
			if score <= 99:
				level = 3
			elif score <= 199:
				level = 5
			elif score <= 299:
				level = 8
			elif score <= 399:
				level = 12
			elif score <= 499:
				level = 16
			else:
				pass
			
		elif priority == 3:
			if score <= 99:
				level = 6
			elif score <= 199:
				level = 9
			elif score <= 299:
				level = 13
			elif score <= 399:
				level = 17
			elif score <= 499:
				level = 20
			else:
				pass
			
		elif priority == 4:
			if score <= 99:
				level = 10
			elif score <= 199:
				level = 14
			elif score <= 299:
				level = 18
			elif score <= 399:
				level = 21
			elif score <= 499:
				level = 23
			else:
				pass
			
		elif priority == 5:
			if score <= 99:
				level = 15
			elif score <= 199:
				level = 19
			elif score <= 299:
				level = 22
			elif score <= 399:
				level = 24
			elif score <= 499:
				level = 25
			else:
				pass
		
		print(str(level))
		# If this level's level is lower than the current one, select this one instead.
		if next_level_level > level:
			next_level_selected = shortcut
			next_level_level = level
	
	print(str(next_level_selected))
