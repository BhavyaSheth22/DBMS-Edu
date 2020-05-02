import 'dart:async';
import 'package:aqueduct/aqueduct.dart';   

class Migration6 extends Migration { 
  @override
  Future upgrade() async {
   		database.addColumn("_Tutor", SchemaColumn("name", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false));
		database.deleteColumn("_Tutor", "firstName");
		database.deleteColumn("_Tutor", "lastName");
  }
  
  @override
  Future downgrade() async {}
  
  @override
  Future seed() async {}
}
    