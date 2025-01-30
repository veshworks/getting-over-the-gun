@tool
extends Resource
class_name CreditsContent

@export var sections: Array[CreditsBlock]

func is_empty() -> bool:
	return sections.is_empty()


func populate_bbtext(rtl: RichTextLabel) -> void:
	rtl.text = ""
	rtl.push_outline_color(Color.from_hsv(0,0,0.1,0.8))
	rtl.push_outline_size(4)
	rtl.push_font_size(18)
	rtl.append_text("[center]")

	for block: CreditsBlock in sections:
		section(rtl, block)

	rtl.pop_all()


func section(rtl: RichTextLabel, block: CreditsBlock) -> void:
	title(rtl, block.title)
	match block.type:
		CreditsBlock.Type.single:
			for member: CreditsMember in block.members:
				rtl.push_context()
				rtl.append_text(member.name)
				rtl.append_text("\n")
				rtl.pop_context()
		CreditsBlock.Type.name_jobs:
			rtl.push_context()
			rtl.push_table(3)
			for member: CreditsMember in block.members:
				push_cell(rtl, member.name, 'right')
				push_cell(rtl, '   ')
				push_cell(rtl, member.jobs.front(), 'left')
				
				for job in member.jobs.slice(1):
					push_cell(rtl, '')
					push_cell(rtl, '')
					push_cell(rtl, job, 'left')
				
				if member != block.members.back():
					push_cell(rtl, ' ')
					push_cell(rtl, ' ')
					push_cell(rtl, ' ')
			rtl.pop_context()
	rtl.append_text("\n".repeat(3))

func title(rtl: RichTextLabel, value: String) -> void:
	rtl.push_context()
	rtl.push_font_size(24)
	rtl.push_underline()
	rtl.append_text(value)
	rtl.append_text("\n".repeat(2))
	rtl.pop_context()

func push_cell(rtl: RichTextLabel, text: String, align: String = ''):
	rtl.push_cell()
	match align:
		'left':
			rtl.push_paragraph(HORIZONTAL_ALIGNMENT_LEFT)
		'right':
			rtl.push_paragraph(HORIZONTAL_ALIGNMENT_RIGHT)
		_:
			rtl.push_paragraph(HORIZONTAL_ALIGNMENT_CENTER)
	rtl.append_text(text)
	rtl.pop()
	rtl.pop()
	
