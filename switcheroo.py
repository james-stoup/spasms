#!/usr/bin/env python

"""
Author : James Stoup
"""


# ewww, global variables! I'm only doing this as an example. Please don't use GVs in your program
verbs = 0
adverbs = 0
adjectives = 0

# here is our word specific functions
def verb_func():
    # lemma = "verb"
    # outputfile.write("INSERT INTO Words VALUES"+"('" +word+"',"+str(senti_val)+",'"+lemma+"');\n");
    # print(word + " " + lemma)
    global verbs
    verbs += 1
    return "VERB"


def adverb_func():
    # lemma = "adverb"
    # print(word + " " + lemma)
    # outputfile.write("INSERT INTO Words VALUES"+"('" +word+"',"+str(senti_val)+",'"+lemma+"');\n");
    global adverbs
    adverbs += 1
    return "ADVERB"


def adjective_func():
    # lemma = "adjective"
    # print(word + " " + lemma)
    # outputfile.write("INSERT INTO Words VALUES"+"('" +word+"',"+str(senti_val)+",'"+lemma+"');\n");
    global adjectives
    adjectives += 1
    return "ADJECTIVE"


# And here is our switcher function
def word_switcher(word):
    # so we spell out what case hits what function
    switcher = {"verb": verb_func, "adverb": adverb_func, "adjective": adjective_func}

    # hit the dictionary, optionally we can pass in a default response if the word isn't found
    func = switcher.get(word, lambda: "INVALID WORD!!!")
    return func()


def main():

    print("===================")
    print("TESTING LAMBDAS")
    print("===================")
    print("")

    # for testing
    words = [
        ("run", "verb"),
        ("quickly", "adverb"),
        ("sandwich", "noun"),
        ("harsh", "adjective"),
        ("squirt", "verb"),
        ("lovely", "adjective"),
        ("eat", "verb"),
        ("of", "preposition"),
        ("hungry", "adjective"),
        ("eagerly", "adverb"),
        ("noisily", "adverb"),
        ("hat", "noun"),
        ("killer", "noun"),
        ("kill", "verb"),
        ("sleep", "verb"),
        ("vape", "verb"),
        ("loser", "adjective"),
    ]

    # sort the words and then go through them one at a time
    words.sort(key=lambda tup: tup[1])
    for (word, speech_part) in words:
        print("%15s   %s" % (word, word_switcher(speech_part)))

    # print some stats
    print("")
    print("verbs      : %s" % verbs)
    print("adverbs    : %s" % adverbs)
    print("adjectives : %s" % adjectives)


if __name__ == "__main__":
    main()
