import 'dart:async';
import 'package:aqueduct/aqueduct.dart';   

class Migration2 extends Migration { 
  @override
  Future upgrade() async {
   		database.createTable(SchemaTable("_Tuition", [SchemaColumn("id", ManagedPropertyType.bigInteger, isPrimaryKey: true, autoincrement: true, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("name", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("contact", ManagedPropertyType.integer, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false)]));
		database.addColumn("_Tuition", SchemaColumn.relationship("admin", ManagedPropertyType.bigInteger, relatedTableName: "_Tutor", relatedColumnName: "id", rule: DeleteRule.nullify, isNullable: true, isUnique: true));
		database.addColumn("_Tutor", SchemaColumn.relationship("worksAt", ManagedPropertyType.bigInteger, relatedTableName: "_Tuition", relatedColumnName: "id", rule: DeleteRule.nullify, isNullable: true, isUnique: false));
  }
  
  @override
  Future downgrade() async {}
  
  @override
  Future seed() async {}
}
    