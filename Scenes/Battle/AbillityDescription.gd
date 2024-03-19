extends TextureRect








func _ready():
	M.AbiInfoCont = self
	pass

func set_info(id):
	var abi = M.Abilities_Data[id]
	if abi.Type == "Attack":
		$AP_Lab.text = str(abi.AP)
	else :
		$AP_Lab.text = "--"
	$Acc_Lab.text = str(abi.Acc) + "%"
	if not abi.has("Desc"):
		var desc = ""
		if abi.Type == "Attack":
			if abi["AP"] >= 21:
				desc += "A very powerful " + abi["Element"] + " Attack"
			elif abi["AP"] >= 16:
				desc += "Powerful " + abi["Element"] + " Attack"
			elif abi["AP"] >= 11:
				desc += "Strong " + abi["Element"] + " Attack"
			else :
				desc += "Basic " + abi["Element"] + " Attack"
			if abi.has("Times"):
				desc += " That hit for " + str(abi["Times"])
			pass
		elif abi.Type == "Buff" or abi.Type == "Debuff":
			if abi.Type == "Buff":
				desc += "Raises your "
			else :
				desc += "Decreases your opponent "
			var and_added = false
			for element in abi.Element:
				if "p" in element:
					desc += "Physical "
					and_added = true
					if and_added:
						desc += "and "
				else :
					desc += "Elemental "
					and_added = true
					if and_added:
						desc += "and "
			for element in abi.Element:
				if "a" in element:
					desc += "Attack "
					break
				elif "d" in element:
					desc += "Defence "
					break
			desc += "by " + str(abi.AP)
		elif abi.Type == "Heal":
			desc = "Heal by " + str(abi["AP"])
		elif abi.Type == "Negate":
			desc = "Removes " + str(abi["Element"] + " Advantage")
		elif abi.Type == "Poison":
			desc = "Poisoning your foe by " + str(abi["Turns"]) + " With " + str(abi["AP"]) + " Ap"
		elif abi.Type == "Dot":
			desc = "Doting your foe by " + str(abi["Turns"]) + " With " + str(abi["AP"]) + " Ap"
		elif abi.Type == "Sleep":
			desc = "Put your foe into sleep by " + str(abi["AP"]) + " Turns"
		elif abi.Type == "Confuse":
			desc = "Put your foe into Confuse by " + str(abi["AP"]) + " Turns"
		$Desc.text = desc if desc != "" else "Decription not added yet"
		



