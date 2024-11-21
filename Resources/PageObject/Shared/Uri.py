import os

# SetelApiBaseEnv = os.environ['setelAPI.baseEnv'] if os.environ['setelAPI.baseEnv'] else "staging"
BaseEnv = "staging"

# BASE_URI by service environment
Dev_SetelApi = "https://api-dev.setel.com"
Dev_SetelAdminPortal = "https://dev-admin.setel.my"
Dev_SetelDashboardPortal = "https://dev-dashboard.setel.my" 
Staging_SetelApi = "https://api-staging.setel.com"
Staging_SetelAdminPortal = "https://staging-admin.setel.my"
Staging_SetelDashboardPortal = "https://staging-dashboard.setel.my" 

def get_base_uri_for_api():
	if  BaseEnv == "dev":
		return Dev_SetelApi
	if  BaseEnv == "staging":
		return Staging_SetelApi

def get_uri_for_web_admin():
	if  BaseEnv == "dev":
		return Dev_SetelAdminPortal
	if  BaseEnv == "staging":
		return Staging_SetelAdminPortal

# api-accounts, formerly api-idp
API_URI = "api/idp"
USER_ID = "userId"

AUTH_LOGIN_URI = "https://api-staging.setel.com/api/idp/admin/auth/login"
# AUTH_LOGIN_URI = f'{get_base_uri_for_api()}/{API_URI}/admin/auth/login'
AUTH_LOGOUT_URI = f'{get_base_uri_for_api()}/{API_URI}/admin/auth/logout'