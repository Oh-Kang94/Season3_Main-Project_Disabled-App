import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home.dart';

class Mydrawer extends StatelessWidget {
  const Mydrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("assets/images/working.png"),
            ),
            accountName: Text('Dummy Id'),
            accountEmail: Text('Dummy Email'),
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40))),
          ),
          ListTile(
            onTap: (){
              Get.to(
                const Home(),
              );
            },
            leading: const Icon(Icons.home, color: Colors.black),
            title: const Text('Home'),
          ),
          ListTile(),
        ],
      ),
    );
  }
}