extends CanvasLayer



func _ready():
	Global.GUI = self
	

func _physics_process(delta):
	lifeCheck()

func lifeCheck():
	if Global.lifeCount < 1:
		$Lifebar/Life_start.hide()
	elif Global.lifeCount < 2:
		$Lifebar/Life_mid1.hide()
	elif Global.lifeCount < 3:
		$Lifebar/Life_end.hide()
	else:
		$Lifebar/Life_start.show()
		$Lifebar/Life_mid1.show()
		$Lifebar/Life_end.show()

func setText(textFill):
	$InfoText.text = str(textFill)

func setText2(textFill):
	$InfoText2.text = str(textFill)
