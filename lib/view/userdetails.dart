import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:eshop_admin/config/configuration.dart';

class Userdetails extends StatelessWidget {
  const Userdetails({super.key});

  @override
  Widget build(BuildContext context) {
    final details =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final email = details['email'] ?? '';
    final phone = details['phone'] ?? '';
    final housename = details['housename'] ?? '';
    final district = details['district'] ?? '';
    final Steetadress = details['Steetadress'] ?? '';
    final pincode = details['pincode'] ?? '';


      void approveSeller(String email) async {
    
QuerySnapshot  snapshot = await  FirebaseFirestore.instance.collection("seller").where("email" , isEqualTo: email).get();
var sellerdoc = snapshot.docs.first;
sellerdoc.reference.update({"isapproved":true});
QuerySnapshot  adminsnapshot = await  FirebaseFirestore.instance.collection("adminrequests").where("email" , isEqualTo: email).get();
var admindoc = adminsnapshot.docs.first;
admindoc.reference.delete();

  }

    return Scaffold(
      appBar:
      AppBar(title: Text(
          'User Information',
          style: TextStyle(
            fontSize: MyConstants.screenHeight(context) * 0.033,
            fontWeight: FontWeight.bold,
          ),
                ),),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                
                
                Information(title: 'Email', value: email),
                Information(title: 'Phone', value: phone),
                Information(title: 'housename', value: housename),
                Information(title: 'district', value: district),
                Information(title: 'Steetadress', value: Steetadress),
                Information(title: 'pincode', value: pincode),
               
              ]),
        ));
  }
}

class Information extends StatelessWidget {
  final String title;
  final String value;
  const Information({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: MyConstants.screenHeight(context) * 0.02,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: MyConstants.screenHeight(context) * 0.0057),
        Text(
          value,
          style: TextStyle(
            fontSize: MyConstants.screenHeight(context) * 0.018,
          ),
        ),
        SizedBox(height: MyConstants.screenHeight(context) * 0.02),
        
      ],
    );
  }
}
