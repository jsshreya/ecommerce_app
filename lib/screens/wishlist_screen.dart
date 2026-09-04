import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/wishlist_provider.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wishlist = Provider.of<WishlistProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("My Wishlist")),

      body: wishlist.wishlist.isEmpty
          ? const Center(
              child: Text(
                "Your wishlist is empty ❤️",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: wishlist.wishlist.length,
              itemBuilder: (context, index) {
                final product = wishlist.wishlist[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10),

                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        product.image,
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),

                    title: Text(
                      product.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),

                    subtitle: Text("₹${product.price.toStringAsFixed(0)}"),

                    trailing: IconButton(
                      icon: const Icon(Icons.favorite, color: Colors.red),
                      onPressed: () {
                        wishlist.toggleWishlist(product);
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
