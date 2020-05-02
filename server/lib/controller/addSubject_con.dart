import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:server/model/tutor.dart';


class AddSubjectController extends ResourceController {
  AddSubjectController(this.context);

  final ManagedContext context;

  @Operation.get()
  Future<Response> getAllHeroes() async {
    final heroQuery = Query<Subject>(context);
    final heroes = await heroQuery.fetch();

    return Response.ok(heroes);
  }
  
  @Operation.post()
  Future<Response> createHero() async {
    final Map<String, dynamic> body = await request.body.decode();
    final query = Query<Subject>(context)
      ..values.name = body['name'] as String;
      

    final insertedHero = await query.insert();

    return Response.ok(insertedHero);
  }
}