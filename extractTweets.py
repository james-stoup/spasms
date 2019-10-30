import json;
import re;

jsonFile = open('Tweets_1.json', 'r');
outputFile = open('extracted_tweets.txt','w');
for line in jsonFile.readlines():
	value = json.loads(line);
	text = value['text'];
	#remove all words starting with @ or #
	stripped_text = re.sub(r'\B[#@]\w+','',text);
	#remove all non UTF encodable characters
	text2 = ''.join(i for i in stripped_text if ord(i)<128);
	outputFile.write(text2);
jsonFile.close();
