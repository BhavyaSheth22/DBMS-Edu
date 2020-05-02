import 'package:server/server.dart';
import 'package:server/model/product.dart';

class Store extends ManagedObject<_Store> implements _Store{
  @Serialize()
  String get address => "$street $city $state";

  @Serialize()
  set address(String full){
    street = full.split(",")[0];
    city = full.split(",")[1];
    state  = full.split(",")[2];
  }
}

class _Store{
  
  @primaryKey
  int id;

  String name;
  
  String city;
  String street;
  String state;

  String description;

  ManagedSet<ProdStore> products;
}

class ProdStore extends ManagedObject<_ProdStore> implements _ProdStore{}

class _ProdStore{
  @primaryKey
  int id;

  @Relate(#stores)
  Product prod;

  @Relate(#products)
  Store store;

  int quantity;
  int price;
}