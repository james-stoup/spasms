import psycopg2
import random

def generateSentence(cur, noun, sentim):

	cur.execute("SELECT fragment FROM sentence_frags")
	sentFragNum = cur.rowcount
	frag = cur.fetchall()
	randSentFragNum = random.randrange(0, sentFragNum, 1)
	frag = frag[randSentFragNum][0]
	
	minSentim = -1.01;
	maxSentim = 1.01;
	if sentim == "pos":
		minSentim = 0;
	elif sentim == "neg":
		maxSentim = 0;

	cur.execute("SELECT word FROM words WHERE (sentiment > %s and sentiment < %s) and (type = 'adjective')", (minSentim,maxSentim))
	numOfAdjectives = cur.rowcount
	adjectives = cur.fetchall()

	cur.execute("SELECT word FROM words WHERE (sentiment > %s and sentiment < %s) and (type = 'adverb')", (minSentim,maxSentim))
	numOfAdverbs = cur.rowcount
	adverbs = cur.fetchall()

	cur.execute("SELECT word FROM words WHERE (sentiment > %s and sentiment < %s) and (type = 'verb')", (minSentim,maxSentim))
	numOfVerbs = cur.rowcount
	verbs = cur.fetchall()
	
	fragSplit = frag.split(" ")
	for x in range(len(fragSplit)):
		if "<noun>" in fragSplit[x]:
			fragSplit[x] = fragSplit[x].replace("<noun>", noun)
		elif "<adjective>" in fragSplit[x]:
			randAdjNum = random.randrange(0, numOfAdjectives, 1)
			fragSplit[x] = fragSplit[x].replace("<adjective>", adjectives[randAdjNum][0])
		elif "<adverb>" in fragSplit[x]:
			randAdvNum = random.randrange(0, numOfAdverbs, 1)
			fragSplit[x] = fragSplit[x].replace("<adverb>", adverbs[randAdvNum][0])
		elif "<verb>" in fragSplit[x]:
			randVerbNum = random.randrange(0, numOfVerbs, 1)
			fragSplit[x] = fragSplit[x].replace("<verb>", verbs[randVerbNum][0])


	fragJoin = " ".join(fragSplit)
	return fragJoin
