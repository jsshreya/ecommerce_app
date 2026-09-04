import '../models/product.dart';

class ProductService {
  static List<Product> products = [
    // MEN
    Product(
      name: "Nike Air Max",
      price: 1499,
      image: "https://images.unsplash.com/photo-1542291026-7eec264c27ff",
      description: "Comfortable and stylish sneakers for everyday wear.",
      categories: ["Men", "Shoes"],
      rating: 4.5,
    ),

    Product(
      name: "Classic Men's T-Shirt",
      price: 799,
      image: "https://images.unsplash.com/photo-1521572163474-6864f9cf17ab",
      description: "Soft cotton t-shirt with a comfortable everyday fit.",
      categories: ["Men", "Clothing"],
      rating: 4.3,
    ),

    Product(
      name: "Denim Jeans",
      price: 1299,
      image: "https://images.unsplash.com/photo-1542272604-787c3835535d",
      description: "Classic denim jeans with a comfortable modern fit.",
      categories: ["Men", "Clothing"],
      rating: 4.4,
    ),

    Product(
      name: "Classic Men's Watch",
      price: 1999,
      image: "https://images.unsplash.com/photo-1524805444758-089113d48a6d",
      description: "Elegant watch suitable for both casual and formal outfits.",
      categories: ["Men", "Watches", "Accessories"],
      rating: 4.6,
    ),

    // WOMEN
    Product(
      name: "Women's Sneakers",
      price: 1599,
      image: "https://images.unsplash.com/photo-1543163521-1bf539c55dd2",
      description:
          "Trendy and comfortable sneakers designed for everyday style.",
      categories: ["Women", "Shoes"],
      rating: 4.7,
    ),

    Product(
      name: "Women's Casual Top",
      price: 899,
      image: "https://images.unsplash.com/photo-1485968579580-b6d095142e6e",
      description: "Stylish casual top made with soft and comfortable fabric.",
      categories: ["Women", "Clothing"],
      rating: 4.5,
    ),
    Product(
      name: "Women's Handbag",
      price: 1799,
      image: "https://images.unsplash.com/photo-1584917865442-de89df76afd3",
      description:
          "Elegant handbag that complements both casual and formal looks.",
      categories: ["Women", "Accessories"],
      rating: 4.6,
    ),

    Product(
      name: "Women's Watch",
      price: 2199,
      image: "https://images.unsplash.com/photo-1523170335258-f5ed11844a49",
      description: "Minimal and elegant watch for a modern everyday look.",
      categories: ["Women", "Watches", "Accessories"],
      rating: 4.7,
    ),

    // SHOES
    Product(
      name: "White Sneakers",
      price: 1299,
      image: "https://images.unsplash.com/photo-1525966222134-fcfa99b8ae77",
      description: "Clean white sneakers that go perfectly with any outfit.",
      categories: ["Men", "Women", "Shoes"],
      rating: 4.5,
    ),

    // ACCESSORIES
    Product(
      name: "Leather Wallet",
      price: 699,
      image: "https://images.unsplash.com/photo-1627123424574-724758594e93",
      description: "Compact leather wallet with a classic and premium design.",
      categories: ["Men", "Accessories"],
      rating: 4.4,
    ),
  ];
}
