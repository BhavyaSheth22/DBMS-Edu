import 'package:server/server.dart';
import 'package:server/model/user.dart';

// import 'package:aqueduct/managed_auth.dart';

// import 'package:heroes/heroes.dart';
// import 'package:heroes/model/hero.dart';

class Student extends ManagedObject<_Student> implements _Student {}

class _Student {
  @primaryKey
  int id;

  @Relate(#students)
  User student;

  @Column()
  String name;

  //String email;
  int dob;
  String building;
  String street;
  String city;
  String state;
}