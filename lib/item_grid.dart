import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:quicklens/item_detail.dart';
import 'package:quicklens/item_model.dart';

class ItemGridScreen extends StatelessWidget {
  const ItemGridScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Items')),
      body: ItemGrid(), // The widget you already wrote
    );
  }
}

class ItemGrid extends StatelessWidget {
  const ItemGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Item>>(
      stream: fetchItems(),
      builder: (context, snapshot) {
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        if (!snapshot.hasData) return CircularProgressIndicator();

        final Items = snapshot.data!;
        return GridView.builder(
          padding: EdgeInsets.all(8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
          ),
          itemCount: Items.length,
          itemBuilder: (context, index) {
            final item = Items[index];
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ItemDetailsScreen(item: item),
                  ),
                );
              },
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: CachedNetworkImage(
                        imageUrl: item.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text('${item.name} - ${item.category}'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text('${item.quantity} pieces'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
