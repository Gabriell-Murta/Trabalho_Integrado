const String DATABASE_NAME = "lists.db";
const String TABLE_NAME = "lists";
const String CREATE_LISTS_TABLE_SCRIPT =
    "CREATE TABLE lists(IdDevice INTEGER AUTO_INCREMENT PRIMARY KEY, Nick TEXT, IdClient INTEGER, Location TEXT)";