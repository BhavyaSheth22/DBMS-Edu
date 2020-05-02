import 'package:server/server.dart';
import 'package:server/model/user.dart';
import 'package:server/model/tuition.dart';

class Tutor extends ManagedObject<_Tutor> implements _Tutor {}

class _Tutor {
  @primaryKey
  int id;

  @Relate(#tutors)
  User tutor;

  @Column()
  String name;

  ManagedSet<Subject> tutorSubs;

  ManagedSet<Qual> tutorQuals; 

  @Relate(#teachers)
  Tuition worksAt;

  Tuition adminOf;
}

class TutorSubject extends ManagedObject<_TutorSubject> implements _TutorSubject {}
class _TutorSubject {
  @primaryKey
  int id;  

  @Relate(#tutorSubs)
  Tutor tutor;

  @Relate(#tutorSubs)
  Subject subject;
}

class TutorQual extends ManagedObject<_TutorQual> implements _TutorQual {}
class _TutorQual {
  @primaryKey
  int id;  

  @Relate(#tutorQuals)
  Tutor tutor;

  @Relate(#tutorQuals)
  Qual qual;
}

class Subject extends ManagedObject<_Subject> implements _Subject {}

class _Subject {
  @primaryKey
  int id;

  String name;

  ManagedSet<TutorSubject> tutorSubs;
}

class Qual extends ManagedObject<_Qual> implements _Qual {}

class _Qual {
  @primaryKey
  int id;

  String name;

  ManagedSet<TutorQual> tutorQuals;
}