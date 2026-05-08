import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeCategory {
  const HomeCategory({
    required this.id,
    required this.label,
    required this.iconAsset,
  });

  final String id;
  final String label;
  final String iconAsset;
}

class FeaturedProduct {
  const FeaturedProduct({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.imageAsset,
    this.badge,
    this.discountText,
  });

  final String id;
  final String title;
  final String subtitle;
  final double price;
  final String imageAsset;
  final String? badge; // e.g. NEW
  final String? discountText; // e.g. -16%
}

final homeCategoriesProvider = Provider<List<HomeCategory>>((ref) {
  return const [
    HomeCategory(
      id: 'vegetables',
      label: 'Vegetables',
      iconAsset: 'assets/category/Group.png',
    ),
    HomeCategory(
      id: 'fruits',
      label: 'Fruits',
      iconAsset: 'assets/category/Group (1).png',
    ),
    HomeCategory(
      id: 'beverages',
      label: 'Beverages',
      iconAsset: 'assets/category/beverage 1.png',
    ),
    HomeCategory(
      id: 'grocery',
      label: 'Grocery',
      iconAsset: 'assets/category/Group (3).png',
    ),
    HomeCategory(
      id: 'edible_oil',
      label: 'Edible oil',
      iconAsset: 'assets/category/Group (3).png',
    ),
    HomeCategory(
      id: 'household',
      label: 'Household',
      iconAsset: 'assets/category/Group (4).png',
    ),
  ];
});

final featuredProductsProvider = Provider<List<FeaturedProduct>>((ref) {
  return const [
    FeaturedProduct(
      id: 'fresh_peach',
      title: 'Fresh Peach',
      subtitle: 'dozen',
      price: 8.00,
      imageAsset: 'assets/products/freshpeach.png',
    ),
    FeaturedProduct(
      id: 'avocado',
      title: 'Avocado',
      subtitle: '2.0 lbs',
      price: 7.00,
      imageAsset: 'assets/products/aocado-2 1.png',
      badge: 'NEW',
    ),
    FeaturedProduct(
      id: 'pineapple',
      title: 'Pineapple',
      subtitle: '1.50 lbs',
      price: 9.90,
      imageAsset: 'assets/products/pineapple-pieces.png',
    ),
    FeaturedProduct(
      id: 'black_grapes',
      title: 'Black Grapes',
      subtitle: '5.0 lbs',
      price: 7.05,
      imageAsset: 'assets/products/grapes-31.png',
      discountText: '-16%',
    ),
    FeaturedProduct(
      id: 'pomegranate',
      title: 'Pomegranate',
      subtitle: '1.50 lbs',
      price: 2.09,
      imageAsset: 'assets/products/pomegranate-11.png',
      badge: 'NEW',
    ),
    FeaturedProduct(
      id: 'fresh_broccoli',
      title: 'Fresh Broccoli',
      subtitle: '1 kg',
      price: 3.00,
      imageAsset: 'assets/products/green-fresh-broccoli.png',
    ),
  ];
});

final cartProvider = NotifierProvider<CartController, Map<String, int>>(
  CartController.new,
);

class CartController extends Notifier<Map<String, int>> {
  @override
  Map<String, int> build() => const {};

  int quantityOf(String productId) => state[productId] ?? 0;

  void add(String productId) {
    final current = state[productId] ?? 0;
    state = {...state, productId: current + 1};
  }

  void increment(String productId) => add(productId);

  void decrement(String productId) {
    final current = state[productId] ?? 0;
    if (current <= 1) {
      final next = {...state}..remove(productId);
      state = next;
      return;
    }
    state = {...state, productId: current - 1};
  }

  void clear() => state = const {};
}
