import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter1/services/auth/auth_service.dart';
import 'package:flutter1/pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
   void logout (){
    final auth = AuthService();
    auth.signOut();
  }

  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(
                height: 250,
                  child: Center(
                child: Icon(
                  Icons.message,
                  color: Theme.of(context).colorScheme.primary,
                  size: 40,
                ),
              )),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: Text("H O M E", style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary)),
                  leading: Icon(Icons.home, color: Theme.of(context).colorScheme.inversePrimary,),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: Text("S E T T I N G S", style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),),
                  leading: Icon(Icons.settings, color: Theme.of(context).colorScheme.inversePrimary),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 25.0),
            child: ListTile(
              title: Text("L O G O U T", style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary)),
              leading: Icon(Icons.logout, color: Theme.of(context).colorScheme.inversePrimary),
              onTap: logout,
            ),
          )
        ],
      ),
    );
  }
}
