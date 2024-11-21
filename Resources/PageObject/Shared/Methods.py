import json

def convert_dictionary_to_json_string(dict):
	json_object = json.dumps(dict, indent = 4) 

	# Print JSON object
	print(json_object)
	return str(json_object);
	