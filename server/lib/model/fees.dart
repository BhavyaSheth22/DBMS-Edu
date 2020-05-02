import 'package:server/server.dart';
import 'package:server/model/tuition.dart';

class Fees extends ManagedObject<_Fees> implements _Fees{

}

class _Fees{
  
  @primaryKey
  int id;

  String grade;
  int fees;

  @Relate(#fee)
  Tuition tuitionFee;
}