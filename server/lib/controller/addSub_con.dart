import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:server/model/tutor.dart';

class GetSubjectController extends ResourceController {
  GetSubjectController(this.context);

  final ManagedContext context;

  @Operation.get()
  Future<Response> getAllHeroes() async {
    final subQuery = Query<Subject>(context);
    final heroes = await subQuery.fetch();

    return Response.ok(heroes);
  }
}

class GetQualController extends ResourceController {
  GetQualController(this.context);

  final ManagedContext context;

  @Operation.get()
  Future<Response> getAllHeroes() async {
    final qualQuery = Query<Qual>(context);
    final heroes = await qualQuery.fetch();

    return Response.ok(heroes);
  }
}