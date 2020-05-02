import 'dart:async';
import 'dart:math';
import 'package:aqueduct/aqueduct.dart';
import 'package:server/model/tutor.dart';
// import 'package:server/model/user.dart';

class AddTutorProfileController extends ResourceController {
  // print('hey');
  AddTutorProfileController(this.context);

  final ManagedContext context;

  @Operation.get()
  Future<Response> getAllTutors() async {
    final heroQuery = Query<Tutor>(context);
    final heroes = await heroQuery.fetch();

    return Response.ok(heroes);
  }
  
  @Operation.post()
  Future<Response> createTutorProfile() async {
    final Map<String, dynamic> body = await request.body.decode();

    final subQuery = Query<Subject>(context);
    final List<Subject> allSubjects = await subQuery.fetch();
    final rand = allSubjects[Random().nextInt(allSubjects.length)];
    final subj = rand['id'];

    final qualQuery = Query<Qual>(context);
    final List<Qual> allQuals = await qualQuery.fetch();
    final random = allQuals[Random().nextInt(allQuals.length)];
    final qual = rand['id'];

    final query = Query<Tutor>(context)
      ..values.name = body['name'] as String
      ..values.tutor.id = body['tutor_id'] as int;

    final insertedProfile = await query.insert();

    final newQuery = Query<TutorSubject>(context)
      ..values.tutor.id = insertedProfile['id'] as int
      ..values.subject.id = subj as int;

    final lastQuery = Query<TutorQual>(context)
      ..values.tutor.id = insertedProfile['id'] as int
      ..values.qual.id = subj as int;

    
    final insertedTutSubj = await newQuery.insert();
    final insertedTutQual = await lastQuery.insert();

    print(insertedTutSubj);
    print(insertedTutQual);

    return Response.ok(insertedProfile);
  }
}