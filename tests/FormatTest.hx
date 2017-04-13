package;

import tink.sql.Format;
import tink.sql.Info;
import tink.sql.drivers.MySql;
import tink.unit.Assert.assert;

using tink.CoreApi;

@:allow(tink.unit)
class FormatTest {
	
	var db:Db;
	var driver:MySql;
	
	public function new() {
		driver = new MySql({user: 'root', password: ''});
		db = new Db('test', driver);
	}
	
	@:variant(new FormatTest.FakeTable1(), 'CREATE TABLE `fake` (id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT, username VARCHAR(50) NOT NULL, admin BIT(1) NOT NULL, age INT(11) UNSIGNED NULL)')
	@:variant(target.db.User, 'CREATE TABLE `User` (email VARCHAR(50) NOT NULL, id INT(12) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, name VARCHAR(50) NOT NULL)')
	public function createTable(table:TableInfo<Dynamic>, sql:String) {
		// TODO: should separate out the sanitizer
		return assert(Format.createTable(table, new tink.sql.drivers.node.MySql.MySqlConnection(null, null)) == sql);
	}
}

class FakeTable1 extends FakeTable {
	
	override function getName():String
		return 'fake';
	
	override function getFields():Iterable<{>FieldType, name:String}>
		return [
			{name: 'id', nullable: false, type: DInt(11, false, true), key: None},
			{name: 'username', nullable: false, type: DString(50), key: None},
			{name: 'admin', nullable: false, type: DBool, key: None},
			{name: 'age', nullable: true, type: DInt(11, false, false), key: None},
		];
}

class FakeTable implements TableInfo<{}> {
	public function new() {}
	
	public function getName():String
		throw 'abstract';
		
	public function getFields():Iterable<{>FieldType, name:String}>
		throw 'abstract';
		
	public function fieldnames():Iterable<String>
		return [for(f in getFields()) f.name];
	
	public function sqlizeRow(row:Insert<{}>, val:Any->String):Array<String>
		return null;
}