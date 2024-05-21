import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop_admin/widgets/rating.dart';
import 'package:flutter/material.dart';

class Ordersdetals extends StatefulWidget {
  
  const Ordersdetals({super.key});

  @override
  State<Ordersdetals> createState() => _OrdersdetalsState();
}

class _OrdersdetalsState extends State<Ordersdetals> {
  @override
  Widget build(BuildContext context) {
    final ordermap =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    print("product id : ${ordermap["product id"]}");

   

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          " O R D E R S D E T A I L S",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(
                  ordermap["product name"],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "₹ ${ordermap["price"]} ",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Image.network(ordermap["image"]),
              ),
            ),
            Text("seller : ${ordermap["seller email"]}"),
            const Divider(),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Shipping Address",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: FutureBuilder(
                future: getBuyerAddress(ordermap["buyer email"]),
                builder: (BuildContext context,
                    AsyncSnapshot<dynamic> addressSnapshot) {
                  if (addressSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (addressSnapshot.hasError) {
                    return Center(
                        child: Text('Error: ${addressSnapshot.error}'));
                  }
                  final buyerAddress =
                      addressSnapshot.data as Map<String, dynamic>;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name: ${buyerAddress["username"]}"),
                      Text("Phone: ${buyerAddress["phone"]}"),
                      Text("House Name: ${buyerAddress["housename"]}"),
                      Text("Street Address: ${buyerAddress["Steetadress"]}"),
                      Text("District: ${buyerAddress["district"]}"),
                      Text("State: ${buyerAddress["state"]}"),
                      Text("Pincode: ${buyerAddress["pincode"]}"),
                    ],
                  );
                },
              ),
            ),
            const Divider(),
            ListTile(
              title: const Text("order shipped"),
              trailing: ordermap["order shipped"]
                  ? const Icon(Icons.done)
                  : const SizedBox(),
            ),
            ListTile(
              title: const Text("out for delivery"),
              trailing: ordermap["out for delivery"]
                  ? const Icon(Icons.done)
                  : const SizedBox(),
            ),
            ListTile(
              title: const Text("order delivered"),
              trailing: ordermap["order delivered"]
                  ? const Icon(Icons.done)
                  : const SizedBox(),
            ),
            const Divider(),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.15,
              child: Rating(productID: ordermap["product id"]),
            )
          ],
        ),
      ),
    );
  }
}

Future<dynamic> getBuyerAddress(buyerEmail) async {
  final snapshot = await FirebaseFirestore.instance
      .collection("users")
      .where("email", isEqualTo: buyerEmail)
      .get();
  final doc = snapshot.docs.first;
  return doc.data();
}


