import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final product = {
    'name': 'Pedigree Chicken & Milk Puppy Dog Food 370G',
    'category': 'Food',
    'description':
        'Complete and balanced dog food for puppies. Contains chicken and milk for healthy growth.',
    'price': 12.0,
    'imageUrl':
        'https://m.media-amazon.com/images/I/71R2o5-U+JL.jpg', // Using a generic image URL for similar product
    'createdAt': FieldValue.serverTimestamp(),
    'vetId': 'system_generated',
  };

  try {
    await FirebaseFirestore.instance.collection('products').add(product);
    debugPrint('Product added successfully!');
  } catch (e) {
    debugPrint('Error adding product: $e');
  }
}
