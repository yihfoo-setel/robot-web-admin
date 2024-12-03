from pyswaggerapiwrap.http_client import HttpClient
from pyswaggerapiwrap.api_filter import APIDataFrameFilter

ENDPOINT = "https://petstore.swagger.io/v2"
AUTH_TOKEN = "special-key"

http_client = HttpClient(base_url=ENDPOINT, auth_token=AUTH_TOKEN)

routes_dict = http_client.get_routes_df(swagger_route="/swagger.json")

api_filter = APIDataFrameFilter(routes_dict)

print(routes_dict)
# Get request to /store/inventory
print(api_filter.store.get_inventory.run(http_client))
# Post request to /pet/{petId}
print(api_filter.pet.get_with_petId.run(http_client, petId=123))