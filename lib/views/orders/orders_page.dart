import 'package:flutter/material.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Your Orders'),
      ),
      body: Center(
        child: Container(
          child: Text('Orders page'),
        ),
      ),
    );
  }
}
