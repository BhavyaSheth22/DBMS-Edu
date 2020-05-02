import 'dart:async';
import 'package:aqueduct/aqueduct.dart';   

class Migration7 extends Migration { 
  @override
  Future upgrade() async {
   		database.addColumn("_User", SchemaColumn("type", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false), unencodedInitialValue: "'tutor'");
  }
  
  @override
  Future downgrade() async {}
  
  @override
  Future seed() async {}
}
    