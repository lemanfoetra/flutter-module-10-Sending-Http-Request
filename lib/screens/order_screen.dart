import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders_provider.dart' show OrdersProvider;
import '../widgets/order_item.dart';

class OrdersScreeen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrdersScreeenState createState() => _OrdersScreeenState();
}

class _OrdersScreeenState extends State<OrdersScreeen> {
  bool _isload = false;
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        _isload = true;
      });
      final orderProviderObj =
          Provider.of<OrdersProvider>(context, listen: false);
      await orderProviderObj.getOrderData();
      setState(() {
        _isload = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var ordersData = Provider.of<OrdersProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Your Order')),
      body: _isload
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: ordersData.order.length,
              itemBuilder: (ctx, i) => OrderItem(ordersData.order[i]),
            ),
    );
  }
}
