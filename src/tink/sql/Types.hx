package tink.sql;

import tink.sql.Expr;

typedef Blob<@:const L> = haxe.io.Bytes;

typedef DateTime = Date;
typedef Timestamp = Date;

typedef TinyInt = Int;
typedef SmallInt = Int;
typedef MediumInt = Int;
// typedef BigInt = Int;

typedef Text = String;
typedef LongText = String;
typedef MediumText = String;
typedef TinyText = String;
typedef VarChar<@:const L> = String;

typedef Point = geojson.Point;
typedef LineString = geojson.LineString;
typedef Polygon = geojson.Polygon;
typedef MultiPoint = geojson.MultiPoint;
typedef MultiLineString = geojson.MultiLineString;
typedef MultiPolygon = geojson.MultiPolygon;
typedef Geometry = geojson.Geometry;

abstract Id<T>(Int) to Int {

  public inline function new(v)
    this = v;

  @:from static inline function ofStringly<T>(s:tink.Stringly):Id<T>
    return new Id(s);

  @:from static inline function ofInt<T>(i:Int):Id<T>
    return new Id(i);

  @:to public inline function toString()
    return Std.string(this);

  @:to public function toExpr():Expr<Id<T>>
    return tink.sql.Expr.ExprData.EValue(new Id(this), cast VInt);

  #if tink_json
  @:from static inline function ofRep<T>(r:tink.json.Representation<Int>):Id<T>
    return new Id(r.get());

  @:to inline function toRep():tink.json.Representation<Int>
    return new tink.json.Representation(this);
  #end

  @:op(A>B) static function gt<T>(a:Id<T>, b:Id<T>):Bool;
  @:op(A<B) static function lt<T>(a:Id<T>, b:Id<T>):Bool;
  @:op(A>=B) static function gte<T>(a:Id<T>, b:Id<T>):Bool;
  @:op(A>=B) static function lte<T>(a:Id<T>, b:Id<T>):Bool;
  @:op(A==B) static function eq<T>(a:Id<T>, b:Id<T>):Bool;
  @:op(A!=B) static function neq<T>(a:Id<T>, b:Id<T>):Bool;

}








