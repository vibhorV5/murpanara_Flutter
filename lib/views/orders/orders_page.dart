import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:murpanara/models/user_orders.dart';
import 'package:murpanara/services/database_services.dart';

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
          child: StreamBuilder(
            stream: DatabaseServices().userOrdersStream(),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                List<UserOrders> data = snapshot.data! as List<UserOrders>;
                print('DATA HAI = ${data}');
                return Column(
                  children: [
                    Text(data.length.toString()),
                    Text(data[0].orderedProducts.first.name)
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('Error');
              } else {
                return Text('no data found');
              }
            }),
          ),
        ),
      ),
    );
  }
}
