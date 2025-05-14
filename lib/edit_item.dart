import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quicklens/item_model.dart';

class EditItemScreen extends StatefulWidget {
  final Item item;

  const EditItemScreen({super.key, required this.item});

  @override
  State<EditItemScreen> createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameCtrl;
  late TextEditingController categoryCtrl;
  late TextEditingController sizeCtrl;
  late TextEditingController colorCtrl;
  late TextEditingController stockDateCtrl;
  late TextEditingController quantityCtrl;
  late TextEditingController lowStockCtrl;
  late TextEditingController purchaseCtrl;
  late TextEditingController salesCtrl;
  late TextEditingController expiryCtrl;

  @override
  void initState() {
    super.initState();
    nameCtrl = TextEditingController(text: widget.item.name);
    categoryCtrl = TextEditingController(text: widget.item.category);
    sizeCtrl = TextEditingController(text: widget.item.size);
    colorCtrl = TextEditingController(text: widget.item.color);
    stockDateCtrl = TextEditingController(text: widget.item.stockDate);
    quantityCtrl = TextEditingController(text: widget.item.quantity.toString());
    lowStockCtrl = TextEditingController(
      text: widget.item.lowStockAlert.toString(),
    );
    purchaseCtrl = TextEditingController(text: widget.item.purchasePrice);
    salesCtrl = TextEditingController(text: widget.item.salesPrice);
    expiryCtrl = TextEditingController(text: widget.item.expiryDate);
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    categoryCtrl.dispose();
    sizeCtrl.dispose();
    colorCtrl.dispose();
    stockDateCtrl.dispose();
    quantityCtrl.dispose();
    lowStockCtrl.dispose();
    purchaseCtrl.dispose();
    salesCtrl.dispose();
    expiryCtrl.dispose();
    super.dispose();
  }

  Future<void> updateItem() async {
    final snapshot =
        await FirebaseFirestore.instance
            .collection('Items')
            .where('name', isEqualTo: widget.item.name)
            // .where('imageUrl', isEqualTo: widget.item.imageUrl)
            .get();

    if (snapshot.docs.isNotEmpty) {
      final doc = snapshot.docs.first.reference;

      await doc.update({
        'name': nameCtrl.text,
        'category': categoryCtrl.text,
        'size': sizeCtrl.text,
        'color': colorCtrl.text,
        'stockDate': stockDateCtrl.text,
        'quantity': int.tryParse(quantityCtrl.text) ?? 0,
        'lowStockAlert': int.tryParse(lowStockCtrl.text) ?? 0,
        'purchasePrice': purchaseCtrl.text,
        'salesPrice': salesCtrl.text,
        'expiryDate': expiryCtrl.text,
      });

      Navigator.pop(context); // رجوع بعد الحفظ
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Item')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              buildField('Name', nameCtrl),
              buildField('Category', categoryCtrl),
              buildField('Size', sizeCtrl),
              buildField('Color', colorCtrl),
              buildField('Stock Date', stockDateCtrl),
              buildField('Quantity', quantityCtrl, isNumber: true),
              buildField('Low Stock Alert', lowStockCtrl, isNumber: true),
              buildField('Purchase Price', purchaseCtrl),
              buildField('Sales Price', salesCtrl),
              buildField('Expiry Date', expiryCtrl),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: updateItem,
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildField(
    String label,
    TextEditingController controller, {
    bool isNumber = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
