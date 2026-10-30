@tool
extends Resource
class_name CharacterDatabase

@export var characters: Array[CharacterData] = []

func get_character(id: StringName) -> CharacterData:
	for character in characters:
		if character.id == id:
			return character

	return null
