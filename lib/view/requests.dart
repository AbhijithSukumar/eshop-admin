// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:eshop_admin/config/configuration.dart';
//aimport 'package:eshop_admin/config/routes.dart';

class Requests extends StatefulWidget {
  const Requests({super.key});

  @override
  State<Requests> createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  void approveSeller(String email) async {
    
QuerySnapshot  snapshot = await  FirebaseFirestore.instance.collection("seller").where("email" , isEqualTo: email).get();
var sellerdoc = snapshot.docs.first;
sellerdoc.reference.update({"isapproved":true});
QuerySnapshot  adminsnapshot = await  FirebaseFirestore.instance.collection("adminrequests").where("email" , isEqualTo: email).get();
var admindoc = adminsnapshot.docs.first;
admindoc.reference.delete();

  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("R E Q U E S T S"),
       
      
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection("adminrequests").snapshots(),
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
                final userId = userData.id;
                Map<String, dynamic> sellermap =
                    userData.data() as Map<String, dynamic>;
                return Card(
                  child: Padding(
                    padding:
                        EdgeInsets.all(MyConstants.screenHeight(context) * 0.01),
                    child: ListTile(
                     
                      title: Text("${sellermap["companyname"]}"),
                      subtitle: Text(sellermap["email"]),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              approveSeller(
                                sellermap["email"] as String,
                              );
                            },
                            icon: const Icon(Icons.done),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            onPressed: () async {
                              await FirebaseFirestore.instance
                                  .collection("denied requests")
                                  .add({
                                "email": sellermap["email"],
                                "password": sellermap["password"],
                                "companyname": sellermap["companyname"],
                                "phone": sellermap["phone"],
                                "adress": sellermap["adress"],
                                "description": sellermap["description"],
                                "url": sellermap["url"],
                              });
                              await FirebaseFirestore.instance
                                  .collection("adminrequests")
                                  .doc(userId)
                                  .delete();
                              print("User deleted");
                            },
                            icon: const Icon(Icons.close),
                          ),
                        ],
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
