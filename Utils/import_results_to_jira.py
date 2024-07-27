import requests
import json
from datetime import datetime
from robot.api import ExecutionResult
from requests.auth import HTTPBasicAuth

##### POPULATE THE VARIABLE TODAY, TO GET THE OUTPUT XML #####
current_date = datetime.now()
today = current_date.strftime('%Y-%m-%d')

##### JIRA PROJECT VARIABLE #####
project_key = "your-project"
test_plan_key = "your-test-plan"

##### JIRA VARIABLES #####
JIRA = 'your-domain'
USER = 'your-email'
API_TOKEN = 'your-token'

##### XRAY VARIABLES #####
client_id = "your-client-id"
client_secret = "your-client-secret"

##### FILE PATHS (JSON AND XML) #####
file_path = f"/opt/robotframework/Results/{today}/output.json"
xml_path = f"/opt/robotframework/Results/{today}/output.xml"

data = {
    "info": {
        "project": f"{project_key}",
        "summary": f"Automatic: Robot Test Execution at {today}",
        "description": f"This execution is related to the project {project_key}, and realized at {today}",
        "testPlanKey": f"{test_plan_key}"
    },
    "tests": []
}

# ---------------------------------------------- #
#    AUTHENTICATE INTO XRAY, AND RETURN TOKEN    #
# ---------------------------------------------- #
def authenticate(client_id, client_secret):
    url = "https://xray.cloud.getxray.app/api/v2/authenticate"
    payload = json.dumps({
        "client_id": client_id,
        "client_secret": client_secret
    })
    headers = {
        "Content-Type": "application/json"
    }
    response = requests.post(url, headers=headers, data=payload)
    if response.status_code == 200:
        print("Authentication successful")
        return response.text.strip('"')
    else:
        raise Exception(f"Authentication failed: {response.text}")

# ---------------------------------------------- #
#             IMPORT JSON INTO XRAY              #
# ---------------------------------------------- #
def import_json(token, file_path):
    headers = {
        "Content-Type": "application/json",
        "Authorization": f"Bearer {token}"
    }
    with open(file_path, 'rb') as file:
        data = file.read()

    url = f"https://xray.cloud.getxray.app/api/v2/import/execution"
    response = requests.post(url, headers=headers, data=data)

    if response.status_code == 200:
        print("The import was succesfull!")
    else:
        print(f"Error: {response.status_code}")
        print(response.text)
        
# ---------------------------------------------- #
# GET TEST ID IN JIRA - SEARCH USING A JQL QUERY #
# ---------------------------------------------- #
def get_test_id_in_jira(test_name):
    search_for_test_url = f'https://{JIRA}/rest/api/2/search'

    jql = f'project = OTS AND summary ~ "\\"{test_name}\\""'

    auth = HTTPBasicAuth(USER, API_TOKEN)
    headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
    }
    params = {
        'jql': jql,
        'maxResults': 1,
        'fields': 'key'
    }

    response = requests.get(search_for_test_url, headers=headers, params=params, auth=auth)

    if response.status_code == 200:
        data = response.json()
        if  len(data['issues']) > 0:
            test_id = data['issues'][0]['key']
            print(f"Test ID found: {test_id}")
            return   test_id
        else:
            print('No test issues found.')
            raise KeyError(f"Error: Check you XML file and Jira. If it is necessary, run update_tests_to_jira. It is mandatory the test existence in jira before import the results.")
    else:
        print(f'Failed to Retrieve Data')
        print(f'Response: {response.text}')

# ---------------------------------------------- #
#         POPULATE THE IMPORT JSON FILE          #
# ---------------------------------------------- #
def write_into_json(testKey, status, file_path):
    test_case = {
        "testKey": f"{testKey}",
        "status": f"{status}"
    }
    with open(file_path, 'w') as file:
        json.dump(data, file, indent=4)
    data["tests"].append(test_case)
    
# ---------------------------------------------- #
#   CHECK THE OUTPUT XML AND MATCHES WITH JIRA   #
# ---------------------------------------------- #
def match_output_xml_with_jira(xml_path):
    def collect_tests(suite):
        for test in suite.tests:
            if test.status == 'PASS':
                id = get_test_id_in_jira(test.name)
                write_into_json(id, "PASSED", file_path)
            elif test.status == 'FAIL':
                id = get_test_id_in_jira(test.name)
                write_into_json(id, "FAILED", file_path)
        for sub_suite in suite.suites:
            collect_tests(sub_suite)
    collect_tests(xml_path.suite)
    write_into_json("last_execution", "FINAL", file_path)


result = ExecutionResult(xml_path)
match_output_xml_with_jira(result)
token = authenticate(client_id, client_secret)
import_json(token, file_path)