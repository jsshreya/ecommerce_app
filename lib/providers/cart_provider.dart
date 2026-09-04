import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/product.dart';
import '../services/product_service.dart';

class CartProvider extends ChangeNotifier {
  Map<Product, int> cartItems = {};

  CartProvider() {
    loadCart();
  }

  // ADD PRODUCT
  void addToCart(Product product) {
    if (cartItems.containsKey(product)) {
      cartItems[product] = cartItems[product]! + 1;
    } else {
      cartItems[product] = 1;
    }

    saveCart();
    notifyListeners();
  }

  // REMOVE PRODUCT
  void removeFromCart(Product product) {
    cartItems.remove(product);

    saveCart();
    notifyListeners();
  }

  // INCREASE QUANTITY
  void increaseQuantity(Product product) {
    cartItems[product] = cartItems[product]! + 1;

    saveCart();
    notifyListeners();
  }

  // DECREASE QUANTITY
  void decreaseQuantity(Product product) {
    if (cartItems[product]! > 1) {
      cartItems[product] = cartItems[product]! - 1;
    } else {
      cartItems.remove(product);
    }

    saveCart();
    notifyListeners();
  }

  // TOTAL ITEMS
  int get totalItems {
    int total = 0;

    for (int quantity in cartItems.values) {
      total = total + quantity;
    }

    return total;
  }

  // TOTAL PRICE
  double get totalPrice {
    double total = 0;

    for (var entry in cartItems.entries) {
      total = total + (entry.key.price * entry.value);
    }

    return total;
  }

  // SAVE CART
  Future<void> saveCart() async {
    final prefs = await SharedPreferences.getInstance();

    Map<String, String> cartData = {};

    for (var entry in cartItems.entries) {
      cartData[entry.key.name] = entry.value.toString();
    }

    await prefs.setString(
      "cart",
      cartData.entries.map((entry) => "${entry.key}:${entry.value}").join("|"),
    );
  }

  // LOAD CART
  Future<void> loadCart() async {
    final prefs = await SharedPreferences.getInstance();

    final savedCart = prefs.getString("cart");

    if (savedCart == null || savedCart.isEmpty) {
      return;
    }

    final items = savedCart.split("|");

    for (var item in items) {
      final parts = item.split(":");

      if (parts.length != 2) {
        continue;
      }

      final productName = parts[0];
      final quantity = int.tryParse(parts[1]);

      if (quantity == null) {
        continue;
      }

      for (var product in ProductService.products) {
        if (product.name == productName) {
          cartItems[product] = quantity;
          break;
        }
      }
    }

    notifyListeners();
  }
}
