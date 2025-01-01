import 'package:drift/drift.dart';
import '../../data/db/app_database.dart';
import '../../models/local/local_liked_product.dart';
import '../../models/local/local_cart_item.dart';

class LocalProductRepository {
  final AppDatabase _db;

  LocalProductRepository(this._db);

  // For likes

  Future<void> addLikedProduct(LocalLikedProduct product) async {
    await _db.into(_db.likedProducts).insert(
      LikedProductsCompanion(
        productId: Value(product.productId),
        likedAt: Value(product.likedAt),
      ),
      mode: InsertMode.insertOrReplace,
    );
  }

  Future<List<LocalLikedProduct>> getLikedProducts() async {
    final rows = await _db.select(_db.likedProducts).get();
    return rows
        .map((row) => LocalLikedProduct(
      productId: row.productId,
      likedAt: row.likedAt,
    ))
        .toList();
  }

  Future<void> removeLikedProduct(String productId) async {
    await (_db.delete(_db.likedProducts)
      ..where((tbl) => tbl.productId.equals(productId)))
        .go();
  }

  Future<void> insertAllLikes(List<LocalLikedProduct> likes) async {
    final likeCompanions = likes.map((like) {
      return LikedProductsCompanion(
        productId: Value(like.productId),
        likedAt: Value(like.likedAt),
      );
    }).toList();

    await _db.batch((batch) {
      batch.insertAll(
        _db.likedProducts,
        likeCompanions,
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  Future<void> clearAllLikes() async {
    await _db.delete(_db.likedProducts).go();
  }

  // For the Cart Items

  Future<void> addCartItem(LocalCartItem item) async {
    await _db.into(_db.cartItems).insert(
      CartItemsCompanion(
        productId: Value(item.productId),
      ),
      mode: InsertMode.insertOrReplace,
    );
  }

  Future<List<LocalCartItem>> getCartItems() async {
    final rows = await _db.select(_db.cartItems).get();
    return rows
        .map((row) => LocalCartItem(
      productId: row.productId,
    ))
        .toList();
  }

  Future<void> removeCartItem(String productId) async {
    await (_db.delete(_db.cartItems)
      ..where((tbl) => tbl.productId.equals(productId)))
        .go();
  }

  Future<void> insertAllCartItems(List<LocalCartItem> cartItems) async {
    final cartItemCompanions = cartItems.map((item) {
      return CartItemsCompanion(
        productId: Value(item.productId),
      );
    }).toList();

    await _db.batch((batch) {
      batch.insertAll(
        _db.cartItems,
        cartItemCompanions,
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  Future<void> removeAllCartItems() async {
    await _db.delete(_db.cartItems).go();
  }

  Future<void> deleteAllLocalData() async {
    await _db.transaction(() async {
      await _db.delete(_db.likedProducts).go();
      await _db.delete(_db.cartItems).go();
    });
  }
}