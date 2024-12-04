import 'package:dummy_1/controller/cart_controller.dart';
import 'package:dummy_1/models/orders_model.dart';
import 'package:dummy_1/models/product_model.dart';
import 'package:dummy_1/screens/widgets/app_textfield.dart';
import 'package:dummy_1/screens/widgets/main_button.dart';
import 'package:dummy_1/utils/app_data.dart';
import 'package:dummy_1/utils/cart_service.dart';
import 'package:dummy_1/utils/exports.dart';
import 'package:dummy_1/utils/order_service.dart';

class ConfirmOrderView extends StatefulWidget {
  const ConfirmOrderView({super.key});

  @override
  State<ConfirmOrderView> createState() => _ConfirmOrderViewState();
}

class _ConfirmOrderViewState extends State<ConfirmOrderView> {
  double subTotalPrice = 0.0;
  @override
  void initState() {
    for (var element in CartService.cartList) {
      var productTotalprice = element.price * element.qty;
      subTotalPrice += productTotalprice;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CartController controller = Get.put(CartController());
    return Scaffold(
      backgroundColor: AppColors.primary,
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: Get.height * 0.15,
            child: const Center(
              child: Text(
                'Confirm Order',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: Get.width,
              // height: Get.height * 0.85,
              decoration: const BoxDecoration(
                color: AppColors.kF2F2F2,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  20.heightBox,
                  const Row(
                    children: [
                      Text(
                        'Shipping Address',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      // SizedBox(width: 10),
                      // Icon(
                      //   Icons.edit,
                      //   color: AppColors.primary,
                      // ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  AppTextFormField(
                    name: 'address',
                    controller: controller.addressController,
                    validate: (value) {
                      return null;
                    },
                    showBorderRadius: true,
                    borderRadius: 20,
                    fillColor: AppColors.kDCDCDC,
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Order Summary',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.zero,
                      child: CartService.cartList.isEmpty
                          ? const Center(
                              child: Text(
                                'No Item Added Yet.',
                              ),
                            )
                          : Column(
                              children: [
                                const Divider(
                                  color: AppColors.kFFDECF,
                                  height: 0,
                                ),
                                ListView.separated(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  physics: const ClampingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    CartProduct product =
                                        CartService.cartList[index];
                                    return ListTile(
                                      visualDensity: VisualDensity.compact,
                                      dense: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 20),
                                      leading: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          10,
                                        ),
                                        child: Image.network(
                                          product.picturePath ?? '',
                                          height: 40,
                                          width: 40,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Icon(
                                              Icons.image_not_supported,
                                              size: 22.sp,
                                              weight: 800,
                                            );
                                          },
                                        ),
                                      ),
                                      title: Text(
                                        product.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      subtitle: Row(
                                        children: [
                                          if (product.isHalf)
                                            Container(
                                              decoration: BoxDecoration(
                                                color: AppColors.grey200,
                                                shape: BoxShape.rectangle,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  10,
                                                ),
                                              ),
                                              child: Text(
                                                'Half',
                                                style: TextStyle(
                                                  color: AppColors.black,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ).pOnly(
                                                left: 10,
                                                right: 10,
                                              ),
                                            ),
                                          10.widthBox,
                                          Text(
                                            '₹${(product.price * product.qty).toStringAsFixed(2)}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: AppColors.primary,
                                            ),
                                          ),
                                        ],
                                      ),
                                      trailing: SizedBox(
                                        width: 100,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    if (product.qty > 1) {
                                                      CartService
                                                          .decreaseQuantity(
                                                              index);
                                                      subTotalPrice -= product
                                                          .price; // Decrease subtotal
                                                    } else {
                                                      CartService
                                                          .removeFromCart(
                                                              index);
                                                    }
                                                    setState(
                                                        () {}); // Update the UI
                                                  },
                                                  padding: EdgeInsets.zero,
                                                  visualDensity:
                                                      VisualDensity.compact,
                                                  style: IconButton.styleFrom(
                                                    tapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                  ),
                                                  icon: Icon(
                                                    Icons
                                                        .remove_circle_outlined,
                                                    color: controller
                                                                .counter.value >
                                                            0
                                                        ? AppColors.primary
                                                        : AppColors.kFFDECF,
                                                    size: 30,
                                                  ),
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  '${product.qty}',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                const SizedBox(width: 5),
                                                IconButton(
                                                  onPressed: () {
                                                    CartService
                                                        .increaseQuantity(
                                                            index);
                                                    subTotalPrice += product
                                                        .price; // Increase subtotal
                                                    setState(() {});
                                                  },
                                                  padding: EdgeInsets.zero,
                                                  visualDensity:
                                                      VisualDensity.compact,
                                                  style: IconButton.styleFrom(
                                                    tapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                  ),
                                                  icon: const Icon(
                                                    Icons.add_circle,
                                                    color: AppColors.primary,
                                                    size: 30,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const Divider(
                                    color: AppColors.kFFDECF,
                                    height: 0,
                                  ),
                                  itemCount: CartService.cartList.length,
                                ),
                                const Divider(
                                  color: AppColors.kFFDECF,
                                  height: 0,
                                ),
                                const SizedBox(height: 25),
                                controller.buildTextRow(
                                  leadingText: 'Subtotal',
                                  trailingText: '₹$subTotalPrice',
                                ),
                                const SizedBox(height: 10),
                                controller.buildTextRow(
                                  leadingText: 'Delivery',
                                  trailingText: 'FREE',
                                ),
                                const SizedBox(height: 10),
                                controller.buildTextRow(
                                  leadingText: 'Payment Method',
                                  trailingText: 'COD',
                                ),
                                const SizedBox(height: 10),
                                const Divider(
                                  color: AppColors.kFFDECF,
                                  height: 0,
                                ),
                                const SizedBox(height: 25),
                                controller.buildTextRow(
                                  leadingText: 'Total',
                                  trailingText: '₹$subTotalPrice',
                                ),
                                const SizedBox(height: 40),
                                MainButton(
                                  buttonColor: AppColors.kFFDECF,
                                  fontColor: AppColors.primary,
                                  isIconAtStart: true,
                                  onPressed: () async {
                                    Orders orderData = Orders(
                                      id: '',
                                      userId: AppData.email,
                                      products: CartService.cartList,
                                      address:
                                          controller.addressController.text,
                                      totalAmount: subTotalPrice,
                                      status: 'pending',
                                    );

                                    // Place the order
                                    try {
                                      await OrderService.placeOrder(orderData);
                                      CartService.clearCart();
                                      setState(() {});
                                      Get.dialog(
                                        AlertDialog(
                                          title: const Text('Success'),
                                          content: const Text(
                                              'Order placed successfully!'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('OK'),
                                            ),
                                          ],
                                        ),
                                      );
                                    } catch (e) {
                                      // Show error message
                                      Get.dialog(
                                        AlertDialog(
                                          title: const Text('Error'),
                                          content: const Text(
                                              'Failed to place order. Please try again.'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('OK'),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  },
                                  text: 'Place Order',
                                ),
                                20.heightBox,
                              ],
                            ),
                    ),
                  ),
                ],
              ).pOnly(
                left: 20,
                right: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
