import 'package:floor/floor.dart';

import 'Item.dart';

@dao
abstract class ItemDAO{

  @Query("SELECT * FROM Item")
  Future<List<Item>> getAllItems();

  @insert
  Future<void> insertItem(Item i);

  @delete
  Future<void> deleteItem(Item i);

  @update
  Future<void> updateItem(Item i);

}
