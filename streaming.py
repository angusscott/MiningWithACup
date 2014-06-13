import tweepy
from tweepy import Stream
from tweepy import OAuthHandler
from tweepy.streaming import StreamListener
import time, codecs, sys


#Keys and tokens
consumer_key = "ijsMDE7smzdpNiemqlZ3wag8Q"
consumer_secret = "OXijwNVnrh7kwA5tcGhXrTFASKVGKY7h9kk02kv6drt4FW6Kh3"
access_token = "2548779734-vnxwlRh0pBwiUpirh8pRBYlqDGrzFpi0giQVTyU"
access_token_secret = "uUK62VMPuGQ7ggD8GilQLBoKiMImE8RIy5Z2RXwWj9opo"

#OAuth
auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_token_secret)

# If the authentication was successful, you should
# see the name of the account print out
api = tweepy.API(auth)
print 'Authenticated using account ' + api.me().name

#Setting up the stream
class listener(StreamListener):
    """A listener handles tweets received from the stream.
    This is a basic listener that just prints received tweets
    """
    def __init__(self,api=None):
        super(listener,self).__init__()
        self.num_tweets=0
        
    def on_status(self, status):
        try:
            feed = status.text.encode('utf-8')
            text = feed.replace('\n',' ') #replace line breaks with spaces
            #created = status.created_at #this isn't used right now
            self.num_tweets+=1 #count the tweets
            print str(self.num_tweets) + '. ' + text
            #save data to file
            saveThis = text
            if self.num_tweets<10000: #maximum number of tweets
                saveFile = open('worldcup.txt','a')
#               saveFile = codecs.open('encoding_test.txt','a',"utf-8")
                saveFile.write(saveThis)
                saveFile.write('\n')
                saveFile.close()
                return True
            else:                
                sys.exit()          #quit; we're done!
        except BaseException, e:    #in case of 404 or d/c
            print 'failed ondata,', str(e)
            time.sleep(5)           #avoids constantly reconnecting
    def on_error(self, status):
        print status

#Activating the stream
searchFor = "#WorldCup" #pick a keyword! can also be a list (remove [] below)
print 'Mining tweets containing "' + searchFor + '"...'
twitterStream = Stream(auth, listener())
twitterStream.filter(track=[searchFor],languages = ['en'])



