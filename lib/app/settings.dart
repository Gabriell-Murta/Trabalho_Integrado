const String DATABASE_NAME = "lists.db";
const String TABLE_NAME = "lists";
const String CREATE_LISTS_TABLE_SCRIPT =
    "CREATE TABLE lists(id INTEGER PRIMARY KEY, nome TEXT, concluido BIT, duedate DATETIME)";
