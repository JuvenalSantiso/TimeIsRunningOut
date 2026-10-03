extends Resource
class_name CharacterData

@export var id: StringName
@export var display_name: String

@export_group("Neutral")
@export var neutral_portrait: Texture2D

@export_group("Happy")
@export var happy_portrait: Texture2D

@export_group("Sad")
@export var sad_portrait: Texture2D

@export_group("Angry")
@export var angry_portrait: Texture2D

@export_group("Thinking")
@export var thinking_portrait: Texture2D
