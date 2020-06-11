import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shop/providers/chart_provider.dart';
import 'package:http/http.dart' as http;

class OrderItem {
  final String id;
  final double amount;
  final DateTime time;
  final List<ChartItem> chartItem;

  OrderItem(
      {@required this.id,
      @required this.amount,
      @required this.time,
      @required this.chartItem});
}

class OrdersProvider with ChangeNotifier {
  List<OrderItem> _order = [];

  List<OrderItem> get order {
    return [..._order];
  }



  Future<void> addOrder(List<ChartItem> chartItem, double total) async {

    const url = "https://flutter-shopapps.firebaseio.com/orders.json";
    final timestamp = DateTime.now();
    final response = await http.post(
      url,
      body: json.encode({
        'amount': total,
        'time': timestamp.toIso8601String(),
        'chartItem': chartItem.map((ci) => {
          'id': ci.id,
          'price': ci.price,
          'title': ci.title,
          'quantity' : ci.quantity,
        }).toList(),
      }),
    );
  
    _order.insert(
        0,
        OrderItem(
            id: json.decode(response.body)['name'],
            amount: total,
            chartItem: chartItem,
            time: DateTime.now()));
    notifyListeners();
  }
}
