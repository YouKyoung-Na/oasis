db = {
    'user'     : 'root',
    'password' : 'abcd',
    'host'     : '127.0.0.1',
    'port'     : '3306',
    'database' : 'flask_test'
}

DB_URL = f"mysql+mysqlconnector://{db['user']}:{db['password']}@{db['host']}:{db['port']}/{db['database']}?charset=utf8"