// ignore_for_file: use_build_context_synchronously, avoid_print
import 'package:eshop_admin/config/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacementNamed(context, Routes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("H O M E"),
        backgroundColor: Theme.of(context).colorScheme.background,
        actions: [
          IconButton(onPressed: logout, icon: const Icon(Icons.logout))
        ],
      ),
      body:Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  onTap: () => Navigator.pushNamed(context, Routes.allReqSellers),
                 
                  leading: const Icon(Icons.request_page_sharp),
                  title:Text("Requests",style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height*0.03
                  ),),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  onTap: () => Navigator.pushNamed(context, Routes.orders),
              
                  leading: const Icon(Icons.local_shipping),
                  title:Text("orders",style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height*0.03
                  ),),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                                onTap: () => Navigator.pushNamed(context, Routes.allsellers),
                   
                  leading: const Icon(Icons.sell),
                  title:Text("sellers",style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height*0.03
                  ),),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                                onTap: () => Navigator.pushNamed(context, Routes.allUsers),
                   
                  leading: const Icon(Icons.supervised_user_circle),
                  title:Text("Users",style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height*0.03
                  ),),
                ),
              ),
            ),
          )
        ],
      )
    );
  }
}
