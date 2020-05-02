import 'package:server/model/student.dart';
import 'package:server/model/tutor.dart';
import 'package:server/server.dart';
import 'package:aqueduct/managed_auth.dart';

class User extends ManagedObject<_User> implements _User, ManagedAuthResourceOwner<_User> {
  @Serialize(input: true, output: false)
  String password;
}

class _User extends ResourceOwnerTableDefinition {
  @Column(unique: true)
  String email;

  ManagedSet<Student> students;
  ManagedSet<Tutor> tutors;

  String type;
}
