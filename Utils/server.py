import os, time
import glob
from influxdb_client import InfluxDBClient, Point, WritePrecision, DeleteApi
from influxdb_client.client.write_api import SYNCHRONOUS
from influxdb_client.rest import ApiException
from robot.api import ExecutionResult
from datetime import datetime, timedelta, timezone

directory = 'yout-path-to-result-folder'  #Path to the Robot Framework Results folder

#Measurements related to the last execution
measurement_1 = "last_passed_tests"
measurement_2 = "last_failed_tests"
measurement_3 = "last_time_to_run_tests"

#Measurements related to all executions
measurement_4 = "all_passed_tests"
measurement_5 = "all_failed_tests"
measurement_6 = "all_time_to_run_tests"

#Number of tests 
measurement_7 = "number_of_tests"

#Pass Ratio
measurement_8 = "pass_test_ratio"

#Total executed tests
measurement_9 = "number_of_tests_executed"

#Delta, last two execution time
measurement_10 = "delta_execution_time"

#Last execution, percentage pass ratio
measurement_11 = "last_perc_p_ratio"

#Last execution, percentage pass ratio
measurement_12 = "all_perc_p_ratio"

#All, executed tests per day
measurement_13 = "all_executed_tests_p_day"

#All, time spent with automation
measurement_14 = "all_executed_time"

#Number of execution
measurement_15 = "execution_count"

total_tests = 0
total_pass = 0
total_time = 0
number_of_execution = 0
old_execution_time = 0

#InfluxDB configuration
url = "http://localhost:8086"
token = "3e6a5f96b27fc69d5b5005f62ef57009d8b0e96a2fb1f06a2ac1a3d3d79b9d5a"
org = "orange"
bucket = "telegraf"

# ---------------------------------------------- #
#          Write data into influx DB             #
# ---------------------------------------------- #
def write(measurement, value, timestamp):
    #InfluxDB client
    client = InfluxDBClient(url=url, token=token, org=org)

    #Create a Point with specified timestamp and value
    point = Point(measurement) \
        .time(timestamp, WritePrecision.NS) \
        .field("value", value)

    #Write point to InfluxDB
    try:
        write_api = client.write_api(write_options=SYNCHRONOUS)
        write_api.write(bucket=bucket, record=point)

        print(f"Successfully sent value {value} to InfluxDB")
        print(f"Timestamp: {timestamp.isoformat()}, Value: {value}")

    except ApiException as e:
        print(f"Error during write operation: ({e.status})")
        print(f"Reason: {e.reason}")
        if hasattr(e, 'body'):
            print(f"HTTP response body: {e.body}")

    #Close connection
    finally:
        client.close()

# ---------------------------------------------- #
#     Delete all values from a measurement       #
# ---------------------------------------------- #
def drop_measurement(measurement_name):
    #InfluxDB client
    client = InfluxDBClient(url=url, token=token, org=org)

    try:
        #Initialize DeleteApi
        delete_api = DeleteApi(client)
        time = datetime.now(timezone.utc)

        #Delete all the values in measurement
        delete_api.delete('1970-01-01T00:00:00Z', time, org=org, bucket=bucket, predicate=f'_measurement="{measurement_name}"')

        print(f"Measurement '{measurement_name}' dropped successfully.")

    except Exception as e:
        print(f"Error dropping measurement '{measurement_name}': {e}")

    #Close connection
    finally:
        client.close()

# ---------------------------------------------- #
#   Count the number of tests passed and failed  #
# ---------------------------------------------- #
def test_result(xml_file):
    passed_tests = 0
    failed_tests = 0

    #Count the number of tests passed and failed
    def collect_tests(suite):
        nonlocal passed_tests, failed_tests
        for test in suite.tests:
            if test.status == 'PASS':
                passed_tests += 1
            elif test.status == 'FAIL':
                failed_tests += 1
        for sub_suite in suite.suites:
            collect_tests(sub_suite)

    collect_tests(xml_file.suite)

    #Return the number of tests passed and failed
    return passed_tests, failed_tests


# ---------------------------------------------- #
#       Get total time and the start time        #
# ---------------------------------------------- #
def execution_time(xml_file):
    result = ExecutionResult(xml_file)
    total_duration = timedelta()
    start_times = []
    
    #Get the total time spend in each test, and in each suite
    def iterate_suites(suite):
        nonlocal total_duration
        
        for test in suite.tests:
            start_time = test.starttime
            end_time = test.endtime
            
            #Convert to datetime objects
            start_dt = datetime.strptime(start_time, '%Y%m%d %H:%M:%S.%f')
            end_dt = datetime.strptime(end_time, '%Y%m%d %H:%M:%S.%f')
            duration = end_dt - start_dt
            total_duration += duration
            start_times.append(start_dt)
            
        for subsuite in suite.suites:
            iterate_suites(subsuite)
    
    iterate_suites(result.suite)
    
    #Get the initial time at the first execution
    test_run_date = min(start_times).date() if start_times else None
    
    #Get the total time spend in each test, and in each suite
    return total_duration, test_run_date

# ---------------------------------------------- #
#    Timestamp with only day, month and year     #
# ---------------------------------------------- #
def my_timestamp():
    timestamp = datetime.now(timezone.utc)
    year = timestamp.year
    month = timestamp.month
    day = timestamp.day
    time_to_return = datetime(year, month, day)
    return time_to_return

# ---------------------------------------------- #
#    Find all output.xml in a given folder       #
# ---------------------------------------------- #
def find_output_xml_files(directory):
    """Find all output.xml files in the given directory and its subdirectories."""
    return glob.glob(os.path.join(directory, '**', 'output.xml'), recursive=True)

############################################################################
############################################################################
############################################################################
#######################      SCRIPT       ##################################
############################################################################
############################################################################
############################################################################

#Drop all measurements
measurements = [measurement_1, measurement_2, measurement_3, measurement_4, measurement_5, measurement_6, measurement_7, measurement_8, measurement_9, measurement_10, measurement_11, measurement_12, measurement_13, measurement_14, measurement_15]
for measurement in measurements:
    drop_measurement(measurement)

#Finding all output.xml files
output_xml_files = find_output_xml_files(directory)
for xml_file in output_xml_files:
    if number_of_execution > 1:
        old_execution_time = total_time_spent.seconds
    total_time_spent, test_run_date = execution_time(xml_file)
    print("----------")
    print(xml_file)
    print(f"Total time spent to run all tests: {total_time_spent}")
    print(f"Test run date: {test_run_date}")
    result = ExecutionResult(xml_file)
    passed, failed = test_result(result)

    test_run_datetime = datetime.combine(test_run_date, datetime.min.time())

    #Variable to calculate the retention
    timestamp = my_timestamp()

    days_diff = (timestamp - test_run_datetime).days
    if days_diff < 30 and total_time_spent.seconds > 0:
        number_of_execution = number_of_execution + 1
        print(total_pass)
        result = ExecutionResult(xml_file)
        passed, failed = test_result(result)
        write(measurement_4, passed, test_run_datetime)
        write(measurement_5, failed, test_run_datetime)
        print(f"Total time spend in seconds: {total_time_spent.seconds}")
        write(measurement_6, total_time_spent.seconds, test_run_datetime)
        total_tests = total_tests + passed + failed
        total_pass = total_pass + passed
        total_time = total_time + total_time_spent.seconds
        write(measurement_9, total_tests, test_run_datetime)
        pass_ratio_overtime = total_pass / total_tests
        write(measurement_12, pass_ratio_overtime, test_run_datetime)
        write(measurement_13, total_tests, test_run_datetime)
        print(total_pass)
    else:
        print("Old test: Wll not be considered due to influxdb Retention")

#Set the last test passed, failed and duration
write(measurement_1, passed, test_run_datetime)
write(measurement_2, failed, test_run_datetime)
write(measurement_3, total_time_spent.seconds, timestamp)

#Total number of tests
print(f"The total number of tests is: {total_tests}")
write(measurement_7, total_tests, timestamp)


#Delta time last two execution
if number_of_execution > 1:
    #Pass ratio
    pass_ratio = total_pass / total_tests
    print(f"The pass ratio is: {pass_ratio}")
    write(measurement_8, pass_ratio, timestamp)

    delta = total_time_spent.seconds / old_execution_time
    write(measurement_10, delta, test_run_datetime)
    #Last Pass ratio
    pass_ratio_last = passed  / (passed + failed)
    write(measurement_11, pass_ratio_last, timestamp)

    #Total time spent running tests during the retention period
    write(measurement_14, total_time, test_run_datetime)

    #Number of executions
    write(measurement_15, number_of_execution, test_run_datetime)
