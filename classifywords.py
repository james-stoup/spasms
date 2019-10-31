parts_of_speech = ["v","r","a"]

file = open("SentiWords_edited.txt","r")
outputfile = open("output.txt","w")
for sentence in file:

    list_of_words = sentence.split()
    word = list_of_words[0]
    senti_val = list_of_words[1]
    lemma = word[-1:]
    word = word[:-2]
    idval = 1
    if lemma in parts_of_speech:

        if lemma == parts_of_speech[0]:
            #outputFile.write("INSERT INTO locations VALUES ("+str(id)+",'"+city+"','"+state+"','"+country+"');\n");
            lemma = "verb"
            outputfile.write("INSERT INTO Words VALUES"+"('" +word+"',"+str(senti_val)+",'"+lemma+"');\n");
            print(word + " " + lemma)

        elif lemma == parts_of_speech[1]:
            lemma = "adverb"
            print(word + " " + lemma)
            #outputfile.write("INSERT INTO Words VALUES ("+word+",'"+str(senti_val)+"','"+lemma+"');\n");
            outputfile.write("INSERT INTO Words VALUES"+"('" +word+"',"+str(senti_val)+",'"+lemma+"');\n");
        elif lemma == parts_of_speech[2]:
            #do something adjective
            lemma = "adjective"
            print(word + " " + lemma)
            #outputfile.write("INSERT INTO Words VALUES ("+word+",'"+str(senti_val)+"','"+lemma+"');\n");
            outputfile.write("INSERT INTO Words VALUES"+"('" +word+"',"+str(senti_val)+",'"+lemma+"');\n");
