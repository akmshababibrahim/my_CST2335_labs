import 'package:floor/floor.dart';

@entity
class Item{
  static int ID = 1;

  @primaryKey
  final int id;
  String name;
  int quantity;

  Item(this.id, this.name, this.quantity){
    if (this.id > ID){
      ID = this.id + 1;
    }
  }
}