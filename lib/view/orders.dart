
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:eshop_admin/config/configuration.dart';
import 'package:eshop_admin/config/routes.dart';


class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
       backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text(
          "O R D E R S",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
       body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection("orders").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = snapshot.data;
          return Padding(
            padding: EdgeInsets.symmetric(
                vertical: MyConstants.screenHeight(context) * 0.01),
            child: ListView.builder(
              itemCount: data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                final userData = data.docs[index];
                // final userId = userData.id;
                Map<String, dynamic> ordermap =
                    userData.data() as Map<String, dynamic>;
                return Card(
                  child: Padding(
                    padding:
                        EdgeInsets.all(MyConstants.screenHeight(context) * 0.01),
                    child: ListTile(
                      onTap: (){
                      Navigator.pushNamed(context, Routes.orderdetails,arguments:ordermap );
                      },
                      
                      leading: Image.network(ordermap["image"]),
                      title: Text("${ordermap["product name"]}"),
                      subtitle: Text(ordermap["buyer email"]),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}