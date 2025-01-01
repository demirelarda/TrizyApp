import 'package:drift/drift.dart';

class LikedProducts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get productId => text().customConstraint('UNIQUE NOT NULL')();
  DateTimeColumn get likedAt => dateTime().nullable()();
}

class CartItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get productId => text().customConstraint('UNIQUE NOT NULL')();
}