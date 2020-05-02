import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:server/model/tuition.dart';
import 'package:server/model/tutor.dart';
import 'package:server/model/user.dart';

class GetTutorController extends ResourceController {
  GetTutorController(this.context);

  final ManagedContext context;

  @Operation.get('id')
  Future<Response> getTutorByID(@Bind.path('id') int id) async {
    final tutorQuery = Query<Tutor>(context)
      ..where((h) => h.tutor.id).equalTo(id);    

    final tutor = await tutorQuery.fetchOne();
    print(tutor);
    if (tutor == null) {
      return Response.notFound();
    }
    return Response.ok(tutor);
  }
}

class GetTuitionController extends ResourceController {
  GetTuitionController(this.context);

  final ManagedContext context;

  @Operation.get()
  Future<Response> getAllTuition() async {
    final tutorQuery = Query<Tuition>(context);   

    final tuition = await tutorQuery.fetch();
    
    print(tuition);
    if (tuition == null) {
      return Response.notFound();
    }
    return Response.ok(tuition);
  }

  @Operation.get('id')
  Future<Response> getTutorByID(@Bind.path('id') int id) async {
    final tutorQuery = Query<Tuition>(context)
      ..where((h) => h.id).equalTo(id);    

    final tuition = await tutorQuery.fetchOne();
    print(tuition);
    if (tuition == null) {
      return Response.notFound();
    }
    return Response.ok(tuition);
  }
}

class GetAdminController extends ResourceController {
  GetAdminController(this.context);

  final ManagedContext context;

  @Operation.get('id')
  Future<Response> getAdminByID(@Bind.path('id') int id) async {
    final tutorQuery = Query<Tuition>(context)
      ..where((h) => h.admin.id).equalTo(id);

    final tuition = await tutorQuery.fetchOne();
    print(tuition);
    if (tuition == null) {
      return Response.notFound();
    }
    return Response.ok(tuition);
  }
}

class GetIDfromUsernameController extends ResourceController{
  GetIDfromUsernameController(this.context);

  final ManagedContext context;

  @Operation.get('username')
  Future<Response> getAdminByID(@Bind.path('username') String username) async {
    final tutorQuery = Query<User>(context)
      ..where((h) => h.username).equalTo(username);

    final tuition = await tutorQuery.fetchOne();

    if (tuition == null) {
      return Response.notFound();
    }
    return Response.ok(tuition);
  }

  // @Operation.post()
  // Future<Response> updateClassByID() async {
  //   final Map<String, dynamic> body = await request.body.decode();
  //   print('hello');
  //   final int id = body['userID'] as int;
  //   print(id);
  //   final int classID = body['classID'] as int;
  //   print(classID);

  //   final tutorQuery = Query<Tutor>(context)
  //     ..where((h) => h.tutor.id).equalTo(id)
  //     ..values.worksAt.id = classID;

  //   final tuition = await tutorQuery.updateOne();

  //   if (tuition == null) {
  //     return Response.notFound();
  //   }
  //   return Response.ok(tuition);
  // }
}

class AddClassController extends ResourceController {
  AddClassController(this.context);

  final ManagedContext context;

  @Operation.post()
  Future<Response> addClass() async {
    final Map<String, dynamic> body = await request.body.decode();

    final query = Query<Tuition>(context)
      ..values.name = body['name'] as String
      ..values.contact = body['contact'] as int
      ..values.street = body['street'] as String
      ..values.city = body['city'] as String
      ..values.state = body['state'] as String
      ..values.description = body['description'] as String
      ..values.admin.id = body['admin_id'] as int;

    final insertedProfile = await query.insert();

    return Response.ok(insertedProfile);
  }
}

class UpdateTutorController extends ResourceController {
  UpdateTutorController(this.context);

  final ManagedContext context;

  @Operation.post()
  Future<Response> updateClassByID() async {
    final Map<String, dynamic> body = await request.body.decode();
    print('hello');
    final int id = body['userID'] as int;
    print(id);
    final int classID = body['classID'] as int;
    print(classID);

    final tutorQuery = Query<Tutor>(context)
      ..where((h) => h.tutor.id).equalTo(id)
      ..values.worksAt.id = classID;

    final tuition = await tutorQuery.updateOne();

    if (tuition == null) {
      return Response.notFound();
    }
    return Response.ok(tuition);
  }
}

