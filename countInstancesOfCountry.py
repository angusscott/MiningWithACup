from nltk.tokenize import WhitespaceTokenizer
import re
import csv

corpus = WhitespaceTokenizer().tokenize(open('worldcup.txt').read())

countries = ['algeria', 'argentina', 'australia', 'belgium', 'bosnia', 'brazil',
'cameroon', 'chile', 'colombia', 'costa', 'croatia', 'ecuador', 'england',
'france','germany', 'ghana', 'greece', 'honduras', 'iran', 'italy', 'ivory', 'japan',
'holland', 'mexico', 'nigeria', 'portugal', 'russia', 'korea', 'spain', 'switzerland',
'usa', 'uruguay']

score = []
sum_ = 0
for country in countries:
	regex = '[a-z#]*'+country+'[a-z]*'
	count = len([word for word in corpus if re.match(regex, word.lower()) is not None])
	score.append(count)
	sum_ += count

# score.append(sum_)
# countries.append('all')


myfile = open('data.csv', 'wb')
wr = csv.writer(myfile)
wr.writerow(['country', 'frequency'])
for country, count in zip(countries, score):
	wr.writerow([country, count])


#Get list of countries, 
#Search for regex for each country and store countries counts
#Find probability fo each appearing