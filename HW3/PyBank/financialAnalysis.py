import os
import csv


#csvpath = os.path.join('\Resources', 'budget_data.csv')
csvpath = r'Resources\budget_data.csv'
financialCSV = csvpath
dataSet = dict() 
# Path to collect data from the Resources folder

# Read in the CSV file
with open(financialCSV, 'r') as csvfile:

    # Split the data on commas
    csvreader = csv.reader(csvfile, delimiter=',')
    header = next(csvreader)
    #keys = header
    for row in csvreader:
        date = row[0]
        amount = int(row[1])
        dataSet[date] = amount
print(dataSet)
#print(len(dataSet.keys()))
totalAmount = 0
for eachAmount in dataSet.values():
    totalAmount = totalAmount + eachAmount
transacts = [transact for transact in dataSet.values()]
#print(transacts)
diffDataSet = [(b - a) for a, b in zip(transacts[:-1], transacts[1:]) ]
diffAverage = sum(diffDataSet)/len(diffDataSet)
#print(diffAverage)
numTransactions = len(dataSet)
totalAverage = totalAmount/numTransactions
print(f"{numTransactions} transactions {totalAmount} {diffAverage} ")
    
