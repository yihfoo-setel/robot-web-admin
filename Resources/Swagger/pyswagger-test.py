import collections.abc
import sys

# Addresses incompatibility due to library moving from Python 3.10 to 3.11. Ref: https://stackoverflow.com/a/73293418/10779988
if sys.version_info.major == 3 and sys.version_info.minor >= 10:
    import collections
    setattr(collections, "MutableMapping", collections.abc.MutableMapping)
    setattr(collections, "Mapping", collections.abc.Mapping)

from pyswagger import App, Security
from pyswagger.contrib.client.requests import Client
from pyswagger.utils import jp_compose

# load Swagger resource file into App object
app = App._create_('http://petstore.swagger.io/v2/swagger.json')

auth = Security(app)
auth.update_with('api_key', '12312312312312312313q') # api key
auth.update_with('petstore_auth', '12334546556521123fsfss') # oauth2

# init swagger client
client = Client(auth)

# a dict is enough for representing a Model in Swagger
pet_Tom=dict(id=1, name='Tom', photoUrls=['http://test']) 
# a request to create a new pet
# Dec 2024: Just sends mock response. After add, cannot retrieve with getPetById
client.request(app.op['addPet'](body=pet_Tom))

# - access an Operation object via App.op when operationId is defined
# - a request to get the pet back
# petId 123 is one of the mock responses
req, resp = app.op['getPetById'](petId=123)
# prefer json as response
req.produce('application/json')
pet = client.request((req, resp)).data
print(f"Found a pet! Data: {pet}")
assert pet.id == 123
assert pet.name == 'doggie'

# new ways to get Operation object corresponding to 'getPetById'.
# 'jp_compose' stands for JSON-Pointer composition
req, resp = app.resolve(jp_compose('/pet/{petId}', base='#/paths')).get(petId=123)
req.produce('application/json')
pet = client.request((req, resp)).data
assert pet.id == 123