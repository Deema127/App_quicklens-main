import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Item {
  final String name, category, imageUrl, size, color, stockDate, expiryDate;
  final int quantity, lowStockAlert;
  final String purchasePrice, salesPrice;

  Item({
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.size,
    required this.color,
    required this.stockDate,
    required this.quantity,
    required this.lowStockAlert,
    required this.purchasePrice,
    required this.salesPrice,
    required this.expiryDate,
  });

  factory Item.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Item(
      name: data['name'],
      category: data['category'],
      imageUrl: data['imageUrl'],
      size: data['size'] ?? '',
      color: data['color'] ?? '',
      stockDate: data['stockDate'],
      quantity: data['quantity'],
      lowStockAlert: data['lowStockAlert'],
      purchasePrice: data['purchasePrice'],
      salesPrice: data['salesPrice'],
      expiryDate: data['expiryDate'] ?? '',
    );
  }
}

Stream<List<Item>> fetchItems() {
  final currentUserId = FirebaseAuth.instance.currentUser?.uid;
  return FirebaseFirestore.instance
      .collection('Items')
      // .where('userId', isEqualTo: currentUserId)
      .snapshots()
      .map(
        (snapshot) =>
            snapshot.docs.map((doc) => Item.fromFirestore(doc)).toList(),
      );
}
