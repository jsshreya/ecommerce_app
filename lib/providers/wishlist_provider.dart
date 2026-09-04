import 'package:flutter/material.dart';
import '../models/product.dart';

class WishlistProvider extends ChangeNotifier {
  List<Product> wishlist = [];

  void toggleWishlist(Product product) {
    if (wishlist.contains(product)) {
      wishlist.remove(product);
    } else {
      wishlist.add(product);
    }

    notifyListeners();
  }

  bool isWishlisted(Product product) {
    return wishlist.contains(product);
  }
}
