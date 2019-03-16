#Author: Toan D Nguyen
#HW3 part B
#

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
	#A default dict with key being candidate and a list of  tuple 
	#of each voter(voterID, county) who voted for that candidate
	
    for row in csvreader:
        candidate = row[2]
        county = row[1] 
        voterID = row[0]
        dataSet[candidate].append(((voterID), county))

    candidatesTotalVotes = dict()
	
    for candidate in dataSet.keys():
        eachCandidateVotes = len(list(dataSet[candidate]))
        candidatesTotalVotes[candidate] = eachCandidateVotes
    print(candidatesTotalVotes.values())

# get the total votes of the election
electionTotalVotes  = sum(list(candidatesTotalVotes.values()))

print("\nElection Results")
print("-------------------------")
print(f"Total Votes: {electionTotalVotes}")
print(f"-------------------------")
#create a tuple of  eachcandidate, % percentage vote, total Vote for that candidate
candidateVotesOutput = cVO = [(candidate, candidatesTotalVotes[candidate]/electionTotalVotes, candidatesTotalVotes[candidate] ) for candidate in candidatesTotalVotes.keys()]
#print(candidateVotesOutput)
candidateWinningVotes = [candidateinfo[2] for candidateinfo in candidateVotesOutput]
electionWinner = candidateWinningVotes.index(max(candidateWinningVotes))
#print(electionWinner)
for each in candidateVotesOutput:
	percentage = '{:.2%}'.format(each[1])
	print(f"{each[0]}: {percentage} ({each[2]})") 
print(f"-------------------------")
print(f"Winner: {cVO[electionWinner][0]}")
print(f"-------------------------")


