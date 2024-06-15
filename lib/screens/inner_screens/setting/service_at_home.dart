import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ServiceAtHomeScreen extends StatefulWidget {
  const ServiceAtHomeScreen({super.key});

  @override
  State<ServiceAtHomeScreen> createState() => _ServiceAtHomeScreenState();
}

class _ServiceAtHomeScreenState extends State<ServiceAtHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back)
        ),
        title: const Text(
          "Service At Home",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500
          ),
        ),
      ) ,
      body: const Center(child: Text("Coming Soon")),
    );
  }
}
