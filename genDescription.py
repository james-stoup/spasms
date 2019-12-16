import markovgen;

def generateDescription(numWords):
	file = open('textForMarkov.txt');
	markov = markovgen.Markov(file);
	return markov.generate_markov_text(numWords);
