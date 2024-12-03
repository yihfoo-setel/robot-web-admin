import json
import os
import yaml
import json
from dotenv import load_dotenv
load_dotenv()

THISFILEDIR = os.path.dirname(__file__)

with open(os.path.join(THISFILEDIR, 'Uri.yaml'), 'r') as f:
    Uri = yaml.load(f, Loader=yaml.SafeLoader)
with open(os.path.join(THISFILEDIR, 'Users.yaml'), 'r') as f:
    Users = yaml.load(f, Loader=yaml.SafeLoader)

Base_Env = os.environ['base_env'] if os.environ['base_env'] else "staging"

def get_current_env():
	return Base_Env

def get_base_uri_for_api():
	return Uri["base_uri"]["api"][Base_Env]

def get_base_uri_for_web_admin():
	return Uri["base_uri"]["web_admin"][Base_Env]

def get_uri_by_api_and_endpoint(api, endpoint):
	return Uri["base_uri"]["api"][Base_Env] + "/" + Uri[api][endpoint]

def get_user_info(username):
	return Users[username]

def convert_dictionary_to_json_string(dict):
	json_object = json.dumps(dict, indent = 4) 

	# Print JSON object
	print(json_object)
	return str(json_object);
	