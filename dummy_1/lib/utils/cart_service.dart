import 'dart:convert';

import 'package:dummy_1/models/product_model.dart';
import 'package:dummy_1/utils/app_data.dart';
import 'package:dummy_1/utils/exports.dart';

class CartService {
  static List<CartProduct> get cartList {
    List<String>? cartListJson = AppData.cartList;
    return cartListJson.map((jsonString) {
      Map<String, dynamic> json = jsonDecode(jsonString);
      return CartProduct.fromJson(json);
    }).toList();
  }

  static set cartList(List<CartProduct> value) {
    List<String> cartListJson =
        value.map((product) => jsonEncode(product.toJson())).toList();
    AppData.cartList = cartListJson;
  }

  static void addToCart(CartProduct product) {
    List<CartProduct> currentCartList =
        List.from(cartList); // Create a new list
    if (currentCartList.any((element) => ((element.name == product.name) &&
        (element.isHalf == product.isHalf)))) {
      Get.dialog(
        AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          title: const Text('Alert'),
          content: const Text('Product Already Exists in the list.'),
          actions: [
            MaterialButton(
              child: const Text('Ok'),
              onPressed: () {
                Get.back();
                Get.focusScope?.unfocus();
              },
            )
          ],
        ),
        barrierDismissible: false,
      );
    } else {
      currentCartList.add(product);
    }

    cartList = currentCartList;
  }

  static void removeFromCart(int index) {
    List<CartProduct> currentCartList =
        List.from(cartList); // Create a new list
    currentCartList.removeAt(index);
    cartList = currentCartList;
  }

  static void updateCartItem(int index, CartProduct updatedProduct) {
    List<CartProduct> currentCartList =
        List.from(cartList); // Create a new list
    currentCartList[index] = updatedProduct;
    cartList = currentCartList;
  }

  static void increaseQuantity(int index) {
    List<CartProduct> currentCartList =
        List.from(cartList); // Create a new list
    currentCartList[index].qty += 1;
    cartList = currentCartList;
  }

  static void decreaseQuantity(int index) {
    List<CartProduct> currentCartList =
        List.from(cartList); // Create a new list
    if (currentCartList[index].qty > 0) {
      currentCartList[index].qty -= 1;
    }
    cartList = currentCartList;
  }

  static void clearCart() {
    cartList = [];
  }
}
