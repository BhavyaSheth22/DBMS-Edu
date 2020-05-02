import 'package:server/server.dart';
import 'package:server/model/store.dart';

class Product extends ManagedObject<_Product> implements _Product{}

class _Product{
  
  @primaryKey
  int id;

  String name;
  
  @Column(nullable: true)
  String author;

  String publisher;
  String description;
  String type;

  ManagedSet<Store> stores;
}