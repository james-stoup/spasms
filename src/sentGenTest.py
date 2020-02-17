import sentenceGenerator
import psycopg2

conn = psycopg2.connect(
    database="spasms",
    user="postgres",
    password="wowarcraft12",
    host="/var/run/postgresql",
    port="5432",
)
print("Connected to database: spasms")


cur = conn.cursor()

sentence = sentenceGenerator.generateSentence(cur, "Trump", "pos")
print(sentence)
