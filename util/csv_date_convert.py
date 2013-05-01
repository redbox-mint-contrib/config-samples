#Basic cleaning script that reads a csv and converts the a field from one date format
# (dd/mm/yyyy) to the one we prefer in ReDBox (yyyy-mm-dd)

#The script takes three command line params:
#  - the input file
#  - the output filename
#  - a comma separated list of the date fields

# e.g. python csv_date_convert.py csvin.csv csvout.py date1,date2


#Why? See http://xkcd.com/1179/

#See http://docs.python.org/2/library/csv.html#module-csv

import csv
import sys
from datetime import datetime

input_file = sys.argv[1]
output_file = sys.argv[2]
date_fields = sys.argv[3].rstrip().split(',')

def writeheader(csvwriter, headers):
    if sys.version_info >= (2, 7):
        csvwriter.writeheader()
    else:
        tmpdict = {}
        for h in headers:
            tmpdict[h] = h
        csvwriter.writerow(tmpdict)

#First we need to read the first row to get the column names
with open(input_file, 'r') as f:
  headers = f.readline().rstrip().split(',')

#Now we can read in the file and prepare the output
with open(output_file, 'wb') as csvout:
    csvwriter = csv.DictWriter(csvout,headers)
    writeheader(csvwriter,headers)
        
    with open(input_file, 'rb') as csvin:
        csvreader = csv.DictReader(csvin)
        for row in csvreader:
            for col in date_fields:
                #Convert the date to the correct format
                newdate = datetime.strptime(row[col], "%d/%m/%Y")
                row[col] = newdate.strftime("%Y-%m-%d")
            csvwriter.writerow(row)
    