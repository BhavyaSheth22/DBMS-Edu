import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:server/model/student.dart';
import 'package:server/model/user.dart';
// import 'package:server/model/user.dart';

class AddProfileController extends ResourceController {
  AddProfileController(this.context);

  final ManagedContext context;

  @Operation.get()
  Future<Response> getAllHeroes() async {
    final heroQuery = Query<Student>(context);
    final heroes = await heroQuery.fetch();

    return Response.ok(heroes);
  }
  
  @Operation.post()
  Future<Response> createHero() async {
    final Map<String, dynamic> body = await request.body.decode();

    final query = Query<Student>(context)
      ..values.name = body['name'] as String
      ..values.dob = body['dob'] as int
      ..values.building = body['building'] as String
      ..values.street = body['street'] as String
      ..values.city = body['city'] as String
      ..values.state = body['state'] as String
      ..values.student.id = body['student_id'] as int;

    final insertedProfile = await query.insert();

    return Response.ok(insertedProfile);
  }
  
  @Operation.get('username')
  Future<Response> getTypeByUsername(@Bind.path('username') String username) async {
    final heroQuery = Query<User>(context)
      ..where((h) => h.username).equalTo(username);    

    final hero = await heroQuery.fetchOne();

    if (hero == null) {
      return Response.notFound();
    }
    return Response.ok(hero);
  }
}