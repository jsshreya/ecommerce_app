import '../providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/product_service.dart';
import '../providers/cart_provider.dart';
import '../providers/wishlist_provider.dart';

import 'product_details_screen.dart';
import 'cart_screen.dart';
import 'wishlist_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchText = "";
  String selectedCategory = "All";

  @override
  Widget build(BuildContext context) {
    final allProducts = ProductService.products;

    final products = allProducts.where((product) {
      final matchesSearch = product.name.toLowerCase().contains(
        searchText.toLowerCase(),
      );

      final matchesCategory =
          selectedCategory == "All" ||
          product.categories.contains(selectedCategory);

      return matchesSearch && matchesCategory;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.shopping_bag,
                color: Theme.of(context).colorScheme.onPrimary,
                size: 22,
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              "My Store",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
        actions: [
          // Dark Mode
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return IconButton(
                icon: Icon(
                  themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                ),
                onPressed: () {
                  themeProvider.toggleTheme();
                },
              );
            },
          ),

          // Wishlist
          Consumer<WishlistProvider>(
            builder: (context, wishlist, child) {
              return IconButton(
                icon: Icon(
                  wishlist.wishlist.isEmpty
                      ? Icons.favorite_border
                      : Icons.favorite,
                  color: wishlist.wishlist.isEmpty ? null : Colors.red,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WishlistScreen(),
                    ),
                  );
                },
              );
            },
          ),

          // Cart
          Consumer<CartProvider>(
            builder: (context, cart, child) {
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartScreen(),
                        ),
                      );
                    },
                  ),

                  if (cart.totalItems > 0)
                    Positioned(
                      right: 5,
                      top: 5,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          "${cart.totalItems}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),

      body: Column(
        children: [
          const SizedBox(height: 20),

          const Text(
            "Welcome to My Store!",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          const Text(
            "Featured Products",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          // Categories
          SizedBox(
            height: 42,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children:
                  [
                    "All",
                    "Men",
                    "Women",
                    "Clothing",
                    "Shoes",
                    "Watches",
                    "Accessories",
                  ].map((category) {
                    final isSelected = selectedCategory == category;

                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(
                          category,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: isSelected
                                ? Theme.of(context).colorScheme.onPrimary
                                : Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            selectedCategory = category;
                          });
                        },
                        selectedColor: Theme.of(context).colorScheme.primary,
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.surfaceContainerHighest,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: isSelected
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.outlineVariant,
                          ),
                        ),
                        showCheckmark: false,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),

          const SizedBox(height: 10),

          // Search
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search products...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
            ),
          ),

          // Products
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.52,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];

                return TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: Duration(milliseconds: 500 + (index * 100)),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, 30 * (1 - value)),
                        child: child,
                      ),
                    );
                  },

                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    clipBehavior: Clip.antiAlias,

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // PRODUCT IMAGE
                        Stack(
                          children: [
                            Hero(
                              tag: product.name,
                              child: Container(
                                height: 130,
                                width: double.infinity,
                                color: Theme.of(
                                  context,
                                ).colorScheme.surfaceContainerHighest,
                                child: Image.network(
                                  product.image,

                                  // IMPORTANT:
                                  // Shows the complete image
                                  // instead of cropping it.
                                  fit: BoxFit.contain,

                                  errorBuilder: (context, error, stackTrace) {
                                    return const Center(
                                      child: Icon(
                                        Icons.image_not_supported_outlined,
                                        size: 40,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),

                            // Wishlist button
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Consumer<WishlistProvider>(
                                  builder: (context, wishlist, child) {
                                    final isLiked = wishlist.isWishlisted(
                                      product,
                                    );

                                    return IconButton(
                                      icon: Icon(
                                        isLiked
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        size: 20,
                                        color: isLiked
                                            ? Colors.red
                                            : Theme.of(
                                                context,
                                              ).colorScheme.onSurface,
                                      ),
                                      onPressed: () {
                                        wishlist.toggleWishlist(product);
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Product name
                              Text(
                                product.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),

                              const SizedBox(height: 4),

                              // Rating
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    size: 16,
                                    color: Colors.amber,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    "${product.rating}",
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 4),

                              // Price
                              Text(
                                "₹${product.price.toStringAsFixed(0)}",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 6),

                              // Add to cart / Quantity
                              Consumer<CartProvider>(
                                builder: (context, cart, child) {
                                  final quantity = cart.cartItems[product] ?? 0;

                                  if (quantity == 0) {
                                    return SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          cart.addToCart(product);
                                        },
                                        child: const Text("Add to Cart"),
                                      ),
                                    );
                                  }

                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          cart.decreaseQuantity(product);
                                        },
                                        icon: const Icon(Icons.remove),
                                      ),

                                      Text(
                                        "$quantity",
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      IconButton(
                                        onPressed: () {
                                          cart.increaseQuantity(product);
                                        },
                                        icon: const Icon(Icons.add),
                                      ),
                                    ],
                                  );
                                },
                              ),

                              // View Details
                              SizedBox(
                                width: double.infinity,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder:
                                            (
                                              context,
                                              animation,
                                              secondaryAnimation,
                                            ) {
                                              return ProductDetailsScreen(
                                                product: product,
                                              );
                                            },
                                        transitionsBuilder:
                                            (
                                              context,
                                              animation,
                                              secondaryAnimation,
                                              child,
                                            ) {
                                              const begin = Offset(1.0, 0.0);

                                              const end = Offset.zero;

                                              const curve = Curves.easeInOut;

                                              final tween = Tween(
                                                begin: begin,
                                                end: end,
                                              ).chain(CurveTween(curve: curve));

                                              return SlideTransition(
                                                position: animation.drive(
                                                  tween,
                                                ),
                                                child: FadeTransition(
                                                  opacity: animation,
                                                  child: child,
                                                ),
                                              );
                                            },
                                      ),
                                    );
                                  },
                                  child: const Text("View Details"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
