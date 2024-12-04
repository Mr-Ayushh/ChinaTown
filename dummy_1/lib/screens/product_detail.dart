import 'package:dummy_1/controller/product_details_controller.dart';
import 'package:dummy_1/models/product_model.dart';
import 'package:dummy_1/screens/widgets/main_button.dart';
import 'package:dummy_1/utils/cart_service.dart';
import 'package:dummy_1/utils/exports.dart';

class ProductDetailView extends GetView<ProductDetailsController> {
  const ProductDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          backgroundColor: AppColors.primary,
          resizeToAvoidBottomInset: false,
          body: SizedBox(
            height: Get.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Get.height * 0.15,
                  child: const Center(
                    child: Text(
                      'Product Details',
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        20.heightBox,
                        ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(30),
                          ),
                          child: Image.network(
                            controller.picturePath ?? '',
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset('assets/images/banner.png');
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                controller.name ?? '',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: controller.decrementCounter,
                                      padding: EdgeInsets.zero,
                                      visualDensity: VisualDensity.compact,
                                      style: IconButton.styleFrom(
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                      ),
                                      icon: Icon(
                                        Icons.remove_circle_outlined,
                                        color: controller.counter.value > 0
                                            ? AppColors.primary
                                            : AppColors.kFFDECF,
                                        size: 30,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      '${controller.counter.value}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    IconButton(
                                      onPressed: controller.incrementCounter,
                                      padding: EdgeInsets.zero,
                                      visualDensity: VisualDensity.compact,
                                      style: IconButton.styleFrom(
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
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
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Divider(
                          color: AppColors.kFFDECF,
                          height: 0,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          controller.description ?? '',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 40),
                        (controller.isCombo)
                            ? Container()
                            : controller.buildOptionRadioListTile(
                                title: 'Half',
                                price: ((controller.price ?? 0.0).toInt() / 2)
                                    .toString(),
                                value: 'Half',
                                groupValue: controller.selectedOption.value,
                                onChanged: (value) {
                                  controller.selectedOption.value =
                                      value ?? 'Half';
                                  controller.selectedOption.refresh();
                                },
                              ),
                        (controller.isCombo)
                            ? Container()
                            : controller.buildOptionRadioListTile(
                                title: 'Full',
                                price: (controller.price ?? 0.0).toString(),
                                value: 'Full',
                                groupValue: controller.selectedOption.value,
                                onChanged: (value) {
                                  controller.selectedOption.value =
                                      value ?? 'Half';
                                  controller.selectedOption.refresh();
                                },
                              ),
                        if (controller.isCombo)
                          controller.buildOptionRadioListTile(
                            title: 'Price',
                            price: (controller.price ?? 0.0).toString(),
                            value: 'Full',
                            groupValue: 'Full',
                            onChanged: (value) {
                              controller.selectedOption.value = value ?? 'Full';
                              controller.selectedOption.refresh();
                            },
                          ),
                        const SizedBox(height: 40),
                        MainButton.icon(
                          icon: const Icon(
                            Icons.shopping_cart,
                            color: AppColors.white,
                          ),
                          isIconAtStart: true,
                          onPressed: () {
                            debugPrint(controller.counter.value.toString());
                            CartService.addToCart(
                              CartProduct(
                                name: (controller.name ?? ''),
                                qty: controller.counter.value,
                                picturePath: controller.picturePath ?? '',
                                price: controller.selectedOption.value == 'Half'
                                    ? ((controller.price ?? 0.0) / 2)
                                    : controller.price ?? 0.0,
                                isHalf:
                                    controller.selectedOption.value == 'Half'
                                        ? true
                                        : false,
                              ),
                            );
                            Get.back();
                            Get.dialog(
                              AlertDialog(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15.0),
                                  ),
                                ),
                                title: const Text('Success'),
                                content:
                                    const Text('Product Added Successfully.'),
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
                          },
                          text: 'Add to Cart',
                        ),
                      ],
                    ).pOnly(
                      left: 20,
                      right: 20,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
