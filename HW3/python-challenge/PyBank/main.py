# Author: Toan D Nguyen
# HW3 part A
# Calculate all the transactions 

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
#print(dataSet)
#print(len(dataSet.keys()))
totalAmount = sum(dataSet.values())
transacts = list(dataSet.values())
#print(transacts)
diffDataSet = [(b - a) for a, b in zip(transacts[:-1], transacts[1:]) ]
diffAverage = sum(diffDataSet)/len(diffDataSet)
#print(diffAverage)
numTransactions = len(dataSet)
totalAverage = totalAmount/numTransactions

print(" Financial Analysis ")
print(" ---------------------------- " )
print(f" Total months {numTransactions} \n Total: ${totalAmount} \n Avg Change: {diffAverage:.2f} ")

# find the key greatIn/Decrease through determining index of min/max values from dataSet.values()
greatDecreaseKey = list(dataSet.keys())[transacts.index(min(transacts))]
greatIncreaseKey = list(dataSet.keys())[transacts.index(max(transacts))]

print(f" Great Decrease in Profit: {greatDecreaseKey} (${dataSet[greatDecreaseKey]})")
print(f" Great Increase in Profit: {greatIncreaseKey} (${dataSet[greatIncreaseKey]}) ")

    
