import '../../models/local/local_liked_product.dart';
import '../../models/local/local_cart_item.dart';
import '../../repositories/local/local_product_repository.dart';

class LocalProductService {
  final LocalProductRepository _repository;

  LocalProductService(this._repository);

  Future<void> likeProduct(String productId) async {
    final likedProduct = LocalLikedProduct(productId: productId, likedAt: DateTime.now());
    await _repository.addLikedProduct(likedProduct);
  }

  Future<void> unlikeProduct(String productId) async {
    await _repository.removeLikedProduct(productId);
  }

  Future<List<LocalLikedProduct>> fetchLikedProducts() async {
    return await _repository.getLikedProducts();
  }

  Future<void> insertAllLikes(List<LocalLikedProduct> likes) async {
    await _repository.insertAllLikes(likes);
  }

  Future<void> addToCart(String productId) async {
    final cartItem = LocalCartItem(productId: productId);
    await _repository.addCartItem(cartItem);
  }

  Future<void> removeFromCart(String productId) async {
    await _repository.removeCartItem(productId);
  }

  Future<List<LocalCartItem>> fetchCartItems() async {
    return await _repository.getCartItems();
  }

  Future<void> clearCartAndInsertAllCartItems(List<LocalCartItem> cartItems) async {
    await clearCart();
    await _repository.insertAllCartItems(cartItems);
  }

  Future<void> clearLikesAndInsertAllLikes(List<LocalLikedProduct> likedProducts) async {
    await clearAllLikes();
    await _repository.insertAllLikes(likedProducts);
  }

  Future<void> clearCart() async {
    await _repository.removeAllCartItems();
  }

  Future<void> clearAllLikes() async {
    await _repository.clearAllLikes();
  }

  Future<void> deleteAllLocalData() async {
    await _repository.deleteAllLocalData();
  }
}