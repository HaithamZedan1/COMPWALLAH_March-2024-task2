import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {

  static Database? _db ;

  Future<Database?> get db async {
    if (_db == null){
      _db  = await intialDb() ;
      return _db ;
    }else {
      return _db ;
    }
  }


  intialDb() async {
    String databasepath = await getDatabasesPath() ;
    String path = join(databasepath , 'quiz.db') ;
    Database mydb = await openDatabase(path , onCreate: _onCreate , version: 1  , onUpgrade:_onUpgrade ) ;
    return mydb ;
  }

  void _onUpgrade(Database db, int oldversion, int newversion) async {
    print("onUpgrade =====================================");
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE "quiz" (
        "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 
        "question" TEXT NOT NULL,
        "answer_num" INTEGER,
        "answer1" TEXT NOT NULL,
        "answer2" TEXT NOT NULL,
        "answer3" TEXT NOT NULL,
        "answer4" TEXT NOT NULL
      )
    ''');

      // Add five initial questions and answers
      await db.insert('quiz', {
        'question': 'What is the capital city of France?',
        'answer_num': 3,
        'answer1': 'Paris',
        'answer2': 'London',
        'answer3': 'Baghdad',
        'answer4': 'Washington'
      });
      await db.insert('quiz', {
        'question': 'Who is the author of "Romeo and Juliet"?',
        'answer_num': 5,
        'answer1': 'John Milton',
        'answer2': 'Victor Hugo',
        'answer3': 'William Shakespeare',
        'answer4': 'Fyodor Dostoevsky'
      });
      await db.insert('quiz', {
        'question': 'What is the chemical symbol for water?',
        'answer_num': 4,
        'answer1': 'CO',
        'answer2': 'H2O',
        'answer3': 'HO',
        'answer4': 'HNe'
      });
      await db.insert('quiz', {
        'question': 'Who painted the Mona Lisa?',
        'answer_num': 3,
        'answer1': 'Leonardo da Vinci',
        'answer2': 'Michelangelo',
        'answer3': 'Rembrandt',
        'answer4': 'Claude Monet'
      });
      await db.insert('quiz', {
        'question': 'What is the largest planet in our solar system?',
        'answer_num': 6,
        'answer1': 'Saturn',
        'answer2': 'Mars',
        'answer3': 'Earth',
        'answer4': ' Jupiter'
      });

    print("onCreate =====================================");
  }


  Future<List<Map<String, dynamic>>> readData(String sql) async {
  Database? mydb = await db;
  List<Map<String, dynamic>> response = await mydb!.rawQuery(sql);
  return response;
  }




  Future<int> insert(String table, Map<String, Object?> values) async {
    Database? mydb = await db;
    int response = await mydb!.insert(table, values);
    return response;
  }
}
