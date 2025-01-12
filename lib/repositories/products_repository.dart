import 'package:trizy_app/models/like/get_liked_products_response.dart';
import 'package:trizy_app/models/local/local_cart_item.dart';
import 'package:trizy_app/models/product/like_response.dart';
import 'package:trizy_app/models/product/products_response.dart';
import 'package:trizy_app/models/product/single_product_response.dart';
import 'package:trizy_app/models/trendingsearch/trending_search_response.dart';
import 'package:trizy_app/services/local/local_product_service.dart';
import 'package:trizy_app/services/products_api_service.dart';
import '../di/locator.dart';
import '../models/local/local_liked_product.dart';
import '../models/product/product_query_params.dart';
//import '../services/analytics_service.dart';

class ProductsRepository {
  final ProductsApiService productsApiService;
  //final analyticsService = getIt<AnalyticsService>();
  final LocalProductService localProductService = getIt<LocalProductService>();
  ProductsRepository(this.productsApiService);


  Future<ProductsResponse> getProductsByCategory({
    required String categoryId,
    required int page,
    ProductQueryParams? queryParams,
  }) async {
    try {
      final ProductsResponse response = await productsApiService.getProductsByCategory(
        categoryId: categoryId,
        page: page,
        queryParameters: queryParams,
      );
      return response;
    } catch (e) {
      throw Exception('Failed to fetch products by category: $e');
    }
  }

  Future<ProductsResponse> searchProducts({
    required String query,
    String? categoryId,
    required int page,
    ProductQueryParams? queryParams,
  }) async {
    try {
      //analyticsService.logSearch(query);
      final ProductsResponse response = await productsApiService.searchProducts(
        query: query,
        page: page,
        categoryId: categoryId,
        queryParameters: queryParams,
      );
      return response;
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }

  Future<SingleProductResponse> getSingleProduct({required String productId}) async {
    try {
      //analyticsService.logProductView(productId);
      final SingleProductResponse response = await productsApiService.getSingleProduct(productId: productId);
      return response;
    } catch (e) {
      throw Exception('Failed to fetch deals: $e');
    }
  }



  Future<ProductsResponse> getLikedProducts({required int page}) async {
    try {
      final ProductsResponse response = await productsApiService.getLikedProducts(page: page);
      final likedProducts = response.products.map((product) {
        return LocalLikedProduct(
          productId: product.id,
          likedAt: DateTime.now(),
        );
      }).toList();

      await localProductService.insertAllLikes(likedProducts);
      return response;
    } catch (e) {
      throw Exception('Failed to fetch liked products: $e');
    }
  }


  Future<ProductsResponse> getBestOfProducts({required String period}) async {
    try {
      final ProductsResponse response = await productsApiService.getBestOfProducts(period: period);
      return response;
    } catch (e) {
      throw Exception('Failed to fetch best of products: $e');
    }
  }



  Future<LikeResponse> likeProduct({required String productId}) async {
    try {
      final LikeResponse response = await productsApiService.likeProduct(productId: productId);

      await localProductService.likeProduct(productId);

      return response;
    } catch (e) {
      throw Exception('Failed to like product: $e');
    }
  }

  Future<GetLikedProductsResponse> getLikedProductIdsAndSaveToLocal() async {
    try {
      final GetLikedProductsResponse response = await productsApiService.getLikedProductIds();

      final List<String> severLikedProductIds = response.likedProductIds;

      final List<LocalLikedProduct> localLikedProducts = severLikedProductIds.map((id) {
        return LocalLikedProduct(productId: id, likedAt: DateTime.now());
      }).toList();

      if(severLikedProductIds.isNotEmpty){
        await localProductService.clearLikesAndInsertAllLikes(localLikedProducts);
      }
      else{
        await localProductService.clearAllLikes();
      }

      return response;
    } catch (e) {
      throw Exception('Failed to like product: $e');
    }
  }

  Future<LikeResponse> removeLike({required String productId}) async {
    try {
      final LikeResponse response = await productsApiService.removeLike(productId: productId);

      await localProductService.unlikeProduct(productId);

      return response;
    } catch (e) {
      throw Exception('Failed to unlike product: $e');
    }
  }


  Future<TrendingSearchResponse> getTrendingSearches() async {
    try {
      final TrendingSearchResponse response = await productsApiService.getTrendingSearches();
      return response;
    } catch (e) {
      throw Exception('Failed to fetch trending searches: $e');
    }
  }



  Future<List<LocalLikedProduct>> fetchLikedProducts() async {
    return await localProductService.fetchLikedProducts();
  }

  Future<List<LocalCartItem>> fetchItemsInCart() async {
    return await localProductService.fetchCartItems();
  }

}