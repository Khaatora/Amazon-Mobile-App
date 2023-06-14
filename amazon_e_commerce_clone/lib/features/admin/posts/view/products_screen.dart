import 'package:amazon_e_commerce_clone/core/constants/app_routes.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ProductsView();
  }
}

class ProductsView extends StatefulWidget {
  const ProductsView({Key? key}) : super(key: key);

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(child: Text("Products"),),
      floatingActionButton: FloatingActionButton(onPressed: _navigateToAddProductsScreen,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
          tooltip: "Add Product",child: const Icon(Icons.add)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _navigateToAddProductsScreen() {
    Navigator.pushNamed(context, AppRoutes.addProductsScreen);
  }
}

