import 'package:flutter/material.dart';
import './product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get getFavoriteItems {
    return [..._items.where((data) => data.isFavorite == true)];
  }


  void addProduct(Product product) {
    Product _newProduct = Product(
      id: DateTime.now().toString(),
      title: product.title,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
    );
    // Insert sebagai list pertama
    _items.insert(0, _newProduct);

    //BERFUNGSI UNTUK MEMBERITAHUKAN BAHWA ADA DATA BARU SEHINGGA WIDGET AKAN DI RE-RENDER
    notifyListeners();
  }

  Product findById(String id) {
    return items.firstWhere((data) => data.id == id);
  }


  void editProduct(String id, Product product){
    if(id != null){
      var index = _items.indexWhere((data) => data.id == id);
      _items[index] = product;
      notifyListeners();
    }
  }


  void deleteProduct(String id){
    _items.removeWhere((data)=> data.id == id);
    notifyListeners();
  }


}