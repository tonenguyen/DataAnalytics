#Author: Toan D Nguyen
#HW3 part B

import os
import csv
import collections

#csvpath = os.path.join('\Resources', 'budget_data.csv')
csvpath = r'Resources\election_data.csv'
electionCSV = csvpath
dataSet = collections.defaultdict(list) 
#dataSet = {string:list}

# Path to collect data from the Resources folder

keyWords = ['Candidate']
# Read in the CSV file
with open(electionCSV, 'r') as csvfile:

    # Split the data on commas
    csvreader = csv.reader(csvfile, delimiter=',')
    header = next(csvreader)
    
    #assumption of knowing the dataSet already
    #will be problematic if we do not know the real index
    for row in csvreader:
        candidate = row[2]
        county = row[1] 
        voterID = row[0]
        dataSet[candidate].append(((voterID), county))

    candidatesTotalVotes = dict()
    for candidate in dataSet.keys():
        eachCandidateVotes = len(list(dataSet[candidate]))
        #eachCandidateVotes = (count( [ votes[0] for votes in candidateVoteDetails]))
        candidatesTotalVotes[candidate] = eachCandidateVotes
    print(candidatesTotalVotes)


    #print(dataSet)
    
