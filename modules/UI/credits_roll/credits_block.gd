#@tool
extends Resource
class_name CreditsBlock

enum Type {
	single,
	name_jobs,
}

@export var type: Type = Type.single
@export var title: String
@export var members: Array[CreditsMember]
