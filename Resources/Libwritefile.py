import csv
import datetime
import os


class Libwritefile:
    ROBOT_LIBRARY_SCOPE = 'TEST CASE'

    def write_file_to_csv(self, url, labData, responseTime):
        print(labData)

        filename = '../log_page_load_time.csv'
        date = datetime.datetime.now()

        if os.path.exists(filename):
            csv = open(filename, 'a')
            csv.write(url + "," + labData + "," + responseTime + "," + date.strftime("%m/%d/%Y %H:%M:%S") + "\n")
            csv.close()
        else:
             csv = open(filename, 'w')
             csv.write('URL, LAB DATA, RESPONSE TIME, DATE' + "\n")
             csv.write(url + "," + labData + "," + responseTime + "," + date.strftime("%m/%d/%Y %H:%M:%S") + "\n")
             csv.close()

    def hello(self, str):
        return str + "  hhhhhhh"


