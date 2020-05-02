import 'package:server/server.dart';
import 'package:server/model/tutor.dart';
import 'package:server/model/fees.dart';

class Tuition extends ManagedObject<_Tuition> implements _Tuition {
  @Serialize()
  String get address => "$street, $city, $state";

  @Serialize()
  set address(String full){
    street = full.split(", ")[0];
    city = full.split(", ")[1];
    state  = full.split(", ")[2];
  }
}

class _Tuition{
  @primaryKey
  int id;

  String name;
  int contact;

  @Relate(#adminOf)
  Tutor admin;

  ManagedSet<Tutor> teachers;

  String city;
  String street;
  String state;

  @Column(nullable: true)
  int rating;

  ManagedSet<Fees> fee;

  String description;
}