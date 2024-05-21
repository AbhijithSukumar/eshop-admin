import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop_admin/config/routes.dart';
import 'package:flutter/material.dart';

class Rating extends StatefulWidget {
  final String productID;
  const Rating({super.key,required this.productID});

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  dynamic product;

Future<Product?> fetchProductByProductId(String productId) async {
  final collectionRef = FirebaseFirestore.instance.collection('products');
  final querySnapshot = await collectionRef
      .where('productid', isEqualTo: productId)
      .get();

  if (querySnapshot.docs.isEmpty) {
    print('No product found for productid: $productId');
    return null;
  }

  final doc = querySnapshot.docs.first;
  return Product.fromMap(doc.data());
}

  double calculateOverallRating(List<Map<String, dynamic>> dataList) {
  if (dataList.isEmpty) {
    return 0.0; // Handle empty list case (optional)
  }

  // Check if all elements have a 'rating' key
  if (!dataList.every((item) => item.containsKey('rating'))) {
    throw Exception("Error: Not all elements have a 'rating' key");
  }

  // Extract ratings and calculate the average
  List<double> ratings = dataList.map((item) => item['rating'] as double).toList();
  double overallRating = ratings.reduce((a, b) => a + b) / ratings.length;

  return overallRating;
}
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProductByProductId(widget.productID).then((value){
      setState(() {
        product=value as Product;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if(product!=null)
    {
      double overallRating=product.ratingsAndFeedbacks!=null?calculateOverallRating(product.ratingsAndFeedbacks):0.0;
    return overallRating==0.0?
          const Padding(
            padding:  EdgeInsets.all(20),
            child: ListTile(
              tileColor: Colors.greenAccent,
                leading:  Text("Overall rating"),
                title:  Text("No rating yet"),
                // trailing: MaterialButton(
                //   onPressed: () {
                //     Navigator.pushNamed(context, Routes.ratings,arguments: ratingsAndFeedbacks);
                //   },
                //   child: const Text("see more"),
                // ),
              ),
          ):
          Padding(
            padding: const EdgeInsets.all(20),
            child: ListTile(
              tileColor: Colors.greenAccent,
                leading: const Text("Overall rating"),
                title: Text(overallRating.toString()),
                trailing: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.ratings,arguments: product.ratingsAndFeedbacks);
                  },
                  child: const Text("see more"),
                ),
              ),
          );
    }
    return const SizedBox();
  }
}

class Product {
  final List<Map<String, dynamic>>? ratingsAndFeedbacks;

  Product({
    this.ratingsAndFeedbacks,
  });

  factory Product.fromMap(Map<String, dynamic> data) => Product(
        ratingsAndFeedbacks: data.containsKey("ratingsAndFeedbacks")?(data['ratingsAndFeedbacks'] as List<dynamic>)
            .cast<Map<String, dynamic>>():null,
      );
}
