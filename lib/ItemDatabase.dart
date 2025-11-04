import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'ItemDAO.dart';
import 'Item.dart';
part 'ItemDatabase.g.dart';

@Database(version: 1, entities: [Item])
abstract class ItemDatabase extends FloorDatabase{
  ItemDAO get myItemDAO;

}