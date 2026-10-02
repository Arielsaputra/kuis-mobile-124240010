import 'package:flutter/material.dart';

import '../models/data.dart';

class ShoeDetailPage extends StatefulWidget {
  const ShoeDetailPage({super.key, required this.shoe});

  final Shoe shoe;

  @override
  State<ShoeDetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<ShoeDetailPage> {
  int _quantity = 1;
  late int _likeCount;
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    _likeCount = widget.shoe.likes;
  }

  void _kurangQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  void _tambahQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _toggleLike() {
    setState(() {
      if (!_isLiked) {
        _likeCount++;
        _isLiked = true;
      } else {
        _likeCount--;
        _isLiked = false;
      }
      widget.shoe.likes = _likeCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    final shoe = widget.shoe;
    return Scaffold(
      appBar: AppBar(title: Text(shoe.shoeName)),
      body: ListView(
        children: [
          Image.network(
            shoe.image,
            height: 280,
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => Container(
              height: 280,
              color: const Color(0xFFF0EFEB),
              alignment: Alignment.center,
              child: const Icon(Icons.broken_image_outlined, size: 48),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(shoe.category),
                const SizedBox(height: 8),
                Text(
                  shoe.shoeName,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  shoe.price,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: const Color(0xFFC92836),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(shoe.description),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Stok: ${shoe.stock}  |  Disukai: $_likeCount'),
                    IconButton(
                      onPressed: _toggleLike,
                      icon: Icon(
                        _isLiked ? Icons.favorite : Icons.favorite_border,
                        color: _isLiked ? const Color(0xFFC92836) : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text('Ukuran tersedia: ${shoe.sizes.join(', ')}'),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text('Jumlah:'),
                    const SizedBox(width: 12),
                    IconButton(
                      onPressed: _kurangQuantity,
                      icon: const Icon(Icons.remove_circle_outline),
                    ),
                    Text(
                      '$_quantity',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    IconButton(
                      onPressed: _tambahQuantity,
                      icon: const Icon(Icons.add_circle_outline),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}