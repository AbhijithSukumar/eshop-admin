import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop_admin/config/configuration.dart';
import 'package:eshop_admin/config/routes.dart';
import 'package:flutter/material.dart';


class Allsellers extends StatefulWidget {
  const Allsellers({super.key});

  @override
  State<Allsellers> createState() => _AllsellersState();
}

class _AllsellersState extends State<Allsellers> {
  @override
  Widget build(BuildContext context) {
  return Scaffold(
       backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text(
          "S E L L E R S",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      
      ),
       body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection("seller").where("isapproved",isEqualTo: true).snapshots(),
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
                Map<String, dynamic> sellermap =
                    userData.data() as Map<String, dynamic>;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Padding(
                      padding:
                          EdgeInsets.all(MyConstants.screenHeight(context) * 0.01),
                      child: ListTile(
                      
                                    onTap: () => Navigator.pushNamed(context, Routes.sellersdetails,arguments: sellermap),
                    
                        
                       
                        
                        title: Text("${sellermap["companyname"]}"),
                        subtitle: Text(sellermap["email"]),
                      ),
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