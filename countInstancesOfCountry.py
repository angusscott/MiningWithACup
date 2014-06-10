from nltk.tokenize import WhitespaceTokenizer
import re
#y = 0
#s =  [y+1 for x in open('worldcup.txt').read() if x == 'brazil']
corpus = WhitespaceTokenizer().tokenize(open('worldcup.txt').read())
#regex = '[a-z#]*korea[a-z]*'
#countBrazil = [word for word in corpus if re.match(regex, word.lower()) is not None]
#countBrazil = [word for word in corpus]

#for listBrazil in tweet.split() if listBrazil == 'brazil'])

#print countBrazil

countries = ['algeria', 'argentina', 'australia', 'belgium', 'bosnia', 'brazil',
'cameroon', 'chile', 'colombia', 'costa', 'croatia', 'ecuador', 'england',
'france','germany', 'ghana', 'greece', 'honduras', 'iran', 'italy', 'ivory', 'japan',
'holland', 'nigeria', 'portugal', 'russia', 'korea', 'spain', 'switzerland',
'usa', 'uruguay']


score = []
sum_ = 0
for country in countries:
	regex = '[a-z#]*'+country+'[a-z]*'
	count = len([word for word in corpus if re.match(regex, word.lower()) is not None])
	score.append(count)
	sum_ += count


score.append(sum_)

score = [x/float(sum_) for x in score]



print score


#Get list of countries, 
#Search for regex for each country and store countries counts
#Find probability fo each appearing