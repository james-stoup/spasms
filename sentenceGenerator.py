import psycopg2
import random

def generateSentence(cur, noun, sentim):

	cur.execute("SELECT fragment FROM sentence_frags")
	sentFragNum = cur.rowcount
	frag = cur.fetchall()
	randSentFragNum = random.randrange(0, sentFragNum, 1)
	frag = frag[randSentFragNum][0]

	if sentim == "pos":
		cur.execute("SELECT word FROM words WHERE (sentiment > 0) and (type = 'adjective')")
		numOfAdjectives = cur.rowcount
		adjectives = cur.fetchall()

		cur.execute("SELECT word FROM words WHERE (sentiment > 0) and (type = 'adverb')")
		numOfAdverbs = cur.rowcount
		adverbs = cur.fetchall()

		cur.execute("SELECT word FROM words WHERE (sentiment > 0) and (type = 'verb')")
		numOfVerbs = cur.rowcount
		verbs = cur.fetchall()
	elif sentim == "neg":
		cur.execute("SELECT word FROM words WHERE (sentiment < 0) and (type = 'adjective')")
		numOfAdjectives = cur.rowcount
		adjectives = cur.fetchall()

		cur.execute("SELECT word FROM words WHERE (sentiment < 0) and (type = 'adverb')")
		numOfAdverbs = cur.rowcount
		adverbs = cur.fetchall()

		cur.execute("SELECT word FROM words WHERE (sentiment < 0) and (type = 'Verb')")
		numOfVerbs = cur.rowcount
		verbs = cur.fetchall()

	fragSplit = frag.split(" ")
	for x in range(len(fragSplit)):
		if fragSplit[x] == '<noun>':
			fragSplit[x] = noun
		elif fragSplit[x] == '<adjective>':
			randAdjNum = random.randrange(0, numOfAdjectives, 1)
			fragSplit[x] = adjectives[randAdjNum][0]
		elif fragSplit[x] == '<adverb':
			randAdvNum = random.randrange(0, numOfAdverbs, 1)
			fragSplit[x] = adverbs[randAdvNum][0]
		elif fragSplit[x] == '<verb>':
			randVerbNum = random.randrange(0, numOfVerbs, 1)
			fragSplit[x] = verbs[randVerbNum][0]


	fragJoin = " ".join(fragSplit)
	return fragJoin