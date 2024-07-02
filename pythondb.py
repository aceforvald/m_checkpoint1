import psycopg2
import psycopg2.extras

def db_connection():
    return psycopg2.connect(
        host = 'localhost',
        database = 'dictdb',
        port = '5432',
        user = 'postgres',
        password = 'anna'
)

def read_dict():
    dbconn = db_connection()
    cur = dbconn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    cur.execute("SELECT id, word, translation FROM dictionary;")
    rows = cur.fetchall()
    cur.close()
    dbconn.close()
    return rows

def add_dict(word, translation):
    dbconn = db_connection()
    cur = dbconn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    cur.execute('INSERT INTO dictionary (word, translation) VALUES (%s, %s);', (word, translation))
    cur.close()
    dbconn.close()
    print(f'you added {new_word}, translates to {translation}')


def delete_dict(word):
    dbconn = db_connection()
    cur = dbconn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    delete_script = 'DELETE FROM dictionary WHERE word = %s'
    delete_record = (word,)
    cur.execute(delete_script, delete_record)
    cur.close()
    dbconn.close()
    print(f'you deleted {word}')


while True: ## REPL - Read Execute Program Loop
    cmd = input("Command: ")

    if cmd == "list":
        print(read_dict())

    elif cmd == "add":
        new_word = input("English word to add: ")
        translation = input("Swedish translation: ")
        add_dict(new_word, translation)

    elif cmd == "delete":
        delete_word = input("English word to delete: ")
        delete_dict(delete_word)

    elif cmd == "quit":
        exit()
    else:
        print("error")