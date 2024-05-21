import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:eshop_admin/config/configuration.dart';

class Sellerdetails extends StatelessWidget {
  const Sellerdetails({super.key});

  @override
  Widget build(BuildContext context) {
    final details =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final email = details['email'] ?? '';
    final phone = details['phone'] ?? '';
    final address = details['adress'] ?? '';
    final companyName = details['companyname'] ?? '';
    final description = details['description'] ?? '';
    final url = details['url'] ?? '';
    final isApproved = details['isapproved'] ?? '';

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
          'Seller Information',
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
                Information(title: 'Address', value: address),
                Information(title: 'Company', value: companyName),
                Information(title: 'Business Description', value: description),
                Information(title: 'Business URL', value: url),
                isApproved==false?
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.1,
                  child: StreamBuilder<QuerySnapshot>(
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
                ):const SizedBox()
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
