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
    cur.execute("SELECT id, word, translation FROM dictionary;")
    rows = cur.fetchall()
    cur.close()
    dbconn.close()
    return rows

def delete_dict(word):
    pass

while True: ## REPL - Read Execute Program Loop
    cmd = input("Command: ")

    if cmd == "list":
        print(read_dict())

    elif cmd == "add":
        new_word = input("English word to add: ")
        translation = input("Swedish translation: ")
        print(f'you added {new_word}, translates to {translation}')

    elif cmd == "delete":
        delete_word = input("English word to delete: ")
        print(f'you want to delete {delete_word}')
    elif cmd == "quit":
        exit()
    else:
        print("error")