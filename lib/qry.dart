import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class datahelp{

 Future<Database> Getdatabase() async {

    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'notebook.db');

    // open the database
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'create table notebook (id integer primary key autoincrement, title Text, descri Text)');
        });

    return database;

  }

  Future<void> inserdata(String title1, String descri1, Database database) async {

   String insertqry="insert into notebook (title,descri) values ('$title1','$descri1')";
       int cnt= await database.rawInsert(insertqry);
       print(cnt);
       
  }

 Future<List<Map>> viewdata(Database database) async {

   String viewdataqry="select * from notebook";
   List<Map> list =await  database.rawQuery(viewdataqry);
   print(list);
        return list;
  }

  void editdata(String title1, String descri1, Database database, int id,) {

    String updateqry="update notebook set title = '${title1}' , descri = '${descri1}' where id = '${id}' ";

    database.rawUpdate(updateqry);
  }

  void deletedata(Database database, int id) {

   String deleteqry="delete from notebook where id ='${id}' ";
   database.rawDelete(deleteqry);
  }


  

}