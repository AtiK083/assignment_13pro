import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProductListScreen(),
    );
  }
}

class Product {
  String name;
  int price;
  int quantity;

  Product({required this.name, required this.price, this.quantity = 0});
}

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final List<Product> products = [
    Product(name: 'Pullover', price: 20),
    Product(name: 'T-Shirt', price: 30),
    Product(name: 'Sport Dress', price: 50),
  ];



  int getTotalAmount() {
    int total = 0;
    for (var product in products) {
      total += product.price * product.quantity;
    }
    return total;
  }

  void incrementQuantity(Product product) {
    setState(() {
      product.quantity++;
    });
  }

  void decrementQuantity(Product product) {
    setState(() {
      if (product.quantity > 0) {
        product.quantity--;
      }
    });
  }

  void showCheckoutSnackbar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Congratulations! Your order has been placed.'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('T-Shirt Product List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ListTile(
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network('https://tse4.mm.bing.net/th?id=OIP.8DYl8fGOYMDmvj57ViBEnQHaJ-&pid=Api&P=0&h=220',height: 80,width: 50,),
                        Text(product.name),

                      ],
                    ),
                    subtitle: Text('Price: \$${product.price}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () => decrementQuantity(product),
                        ),
                        Text('${product.quantity}'),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () => incrementQuantity(product),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Text(
              'Total: \$${getTotalAmount()}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => showCheckoutSnackbar(context),
              child: Text('CHECK OUT'),
            ),
          ],
        ),
      ),
    );
  }
}
