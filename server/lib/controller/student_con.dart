import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:server/model/student.dart';
import 'package:server/model/tuition.dart';
import 'package:server/model/tutor.dart';
import 'package:server/model/user.dart';

class GetStudentByIDController extends ResourceController {
  GetStudentByIDController(this.context);

  final ManagedContext context;

  @Operation.get('id')
  Future<Response> getStudentByID(@Bind.path('id') int id) async {
    final studentQuery = Query<Student>(context)
      ..where((h) => h.student.id).equalTo(id);    

    final student = await studentQuery.fetchOne();
    
    print(student);
    
    if (student == null) {
      return Response.notFound();
    }
    return Response.ok(student);
  }
}

class GetTutorFromTuition extends ResourceController {
  GetTutorFromTuition(this.context);

  final ManagedContext context;

  @Operation.get('id')
  Future<Response> getTutor(@Bind.path('id') int id) async {
    final studentQuery = Query<Tutor>(context)
      ..where((h) => h.worksAt.id).equalTo(id);    

    final student = await studentQuery.fetch();
    
    print(student);
    
    if (student == null) {
      return Response.notFound();
    }
    return Response.ok(student);
  }
}

class GetAllTuitions extends ResourceController{
  GetAllTuitions(this.context);

  final ManagedContext context;

  @Operation.get()
  Future<Response> getStudentByID() async {
    final tuitionQuery = Query<Tuition>(context);   

    final tuition = await tuitionQuery.fetch();
    
    print(tuition);
    
    if (tuition == null) {
      return Response.notFound();
    }
    return Response.ok(tuition);
  } 
}