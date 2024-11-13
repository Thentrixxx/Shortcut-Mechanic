extends Node


# Dictionary that manages the entire game.
var shortcuts = {
	"Shortcut_Placeholder": {"Score": 0, "Priority": 1}
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
