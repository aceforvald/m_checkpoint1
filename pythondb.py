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

#read_dict()

while True: ## REPL - Read Execute Program Loop
    cmd = input("Command: ")

    if cmd == "list":
        print(read_dict())
    elif cmd == "quit":
        exit()
    else:
        print("error")