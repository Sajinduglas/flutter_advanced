import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/auth_provider.dart';
import '../provider/counter_provider.dart';

void main() {
  runApp(MaterialApp(
    home: MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => count_provider()),
        ChangeNotifierProvider(create: (context) => Auth_provider()),
      ],
      child: Multi_Providerr(),
    ),
  ));
}

class Multi_Providerr extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Counter Value",
              style: TextStyle(fontSize: 20),
            ),
            ElevatedButton(
                onPressed: () {
                  Provider.of<count_provider>(context, listen: false)
                      .incriment();
                },
                child: const Text("Increment Counter")),
            Text(
              "Count value :${Provider.of<count_provider>(context).count}",
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Auth Details",
              style: TextStyle(fontSize: 20),
            ),
            ElevatedButton(
                onPressed: () {
                  Provider.of<Auth_provider>(context,listen: false).login
                      ? Provider.of<Auth_provider>(context,listen: false).loggedout()
                      : Provider.of<Auth_provider>(context,listen: false).loggedin();
                },
                child: const Text("Switch Login")),
            Consumer<Auth_provider>(builder: (context, authprovider, child) {
              return Text(
                  "User is ${authprovider.login ? "Logged In" : "Logged Out"}");
            })
          ],
        ),
      ),
    );
  }
}