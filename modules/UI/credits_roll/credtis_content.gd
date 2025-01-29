@tool
extends Resource
class_name CreditsContent

@export var sections: Array[CreditsBlock]

func is_empty() -> bool:
	return sections.is_empty()


func populate_bbtext(rtl: RichTextLabel) -> void:
	rtl.text = ""
	rtl.push_outline_color(Color.BLACK)
	rtl.push_outline_size(2)
	rtl.append_text("[center]")

	for block: CreditsBlock in sections:
		section(rtl, block)

	rtl.pop_all()


func section(rtl: RichTextLabel, block: CreditsBlock) -> void:
	title(rtl, block.title)
	for member: CreditsMember in block.members:
		rtl.push_context()
		rtl.push_font_size(18)
		rtl.append_text(member.name)
		rtl.append_text("\n")
		rtl.pop_context()
	rtl.append_text("\n".repeat(1))

func title(rtl: RichTextLabel, value: String) -> void:
	rtl.push_context()
	rtl.push_font_size(24)
	rtl.push_bold()
	rtl.append_text(value)
	rtl.append_text("\n")
	rtl.pop_context()
