import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReviewDialog extends StatefulWidget {
  final QueryDocumentSnapshot order;

  const ReviewDialog({super.key, required this.order});

  @override
  State<ReviewDialog> createState() => _ReviewDialogState();
}

class _ReviewDialogState extends State<ReviewDialog> {
  double _rating = 5.0;
  final _commentController = TextEditingController();
  bool _isLoading = false;

  Future<void> _submitReview() async {
    setState(() => _isLoading = true);
    final data = widget.order.data() as Map<String, dynamic>;
    final productId = data['productId'];
    final userId = data['userId'];

    if (productId != null) {
      try {
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get();
        String userName = 'Anonymous';
        if (userDoc.exists) {
          final userData = userDoc.data();
          if (userData != null && userData.containsKey('name')) {
            userName = userData['name'] ?? 'Anonymous';
          }
        }

        final review = {
          'rating': _rating,
          'comment': _commentController.text.trim(),
          'userId': userId,
          'userName': userName,
          'timestamp': DateTime.now().toIso8601String(),
        };

        // Update Product with Review
        await FirebaseFirestore.instance
            .collection('products')
            .doc(productId)
            .update({
              'reviews': FieldValue.arrayUnion([review]),
            });

        // Update Order Status to Reviewed
        await FirebaseFirestore.instance
            .collection('orders')
            .doc(widget.order.id)
            .update({'status': 'Reviewed'});

        if (mounted) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Review submitted successfully!')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error submitting review: $e')),
          );
        }
      }
    }
    if (!mounted) return;
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Leave a Review',
        style: GoogleFonts.dmSans(fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('How was your product?', style: GoogleFonts.dmSans()),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return IconButton(
                onPressed: () => setState(() => _rating = index + 1.0),
                icon: Icon(
                  index < _rating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 32,
                ),
              );
            }),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _commentController,
            decoration: InputDecoration(
              hintText: 'Write your experience...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            maxLines: 3,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _submitReview,
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
          ),
          child: _isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Text('Submit'),
        ),
      ],
    );
  }
}
