import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummy_1/models/orders_model.dart';
import 'package:dummy_1/utils/exports.dart';

class PendingOrderListPage extends StatefulWidget {
  const PendingOrderListPage({super.key});

  @override
  State<PendingOrderListPage> createState() => _PendingOrderListPageState();
}

class _PendingOrderListPageState extends State<PendingOrderListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            decoration: const BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: const Center(
              child: Text(
                'Pending Orders',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Orders>>(
                stream: getOrders(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text('Loading Data Wait a while....');
                  }

                  List<Orders> orders = snapshot.data!;
                  List<Orders> pendingOrders = orders
                      .where((order) => order.status == 'pending')
                      .toList();
                  if (!snapshot.hasData || pendingOrders.isEmpty) {
                    return const Center(
                      child: Text('No pending orders found.'),
                    );
                  }
                  return ListView.builder(
                    itemCount: pendingOrders.length,
                    itemBuilder: (context, index) {
                      return _buildCompletedOrderListItem(
                          context, index, pendingOrders);
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }

  static final CollectionReference _ordersCollection =
      FirebaseFirestore.instance.collection('ordersMaster');

  static Stream<List<Orders>> getOrders() {
    return _ordersCollection.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Orders.fromFirestore(doc)).toList());
  }

  void showOrderDetailsDialog(BuildContext context, Orders data) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: Get.height * 0.1,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Order Details',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order #${data.id.length > 6 ? data.id.substring(0, 6) : data.id}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text('Email: ${data.userId}'),
                      const SizedBox(height: 5),
                      Text('Ordered Date: ${DateTime.now().toString()}'),
                      const SizedBox(height: 5),
                      Text('Price: ₹${data.totalAmount}'),
                      const SizedBox(height: 20),
                      const Text(
                        'Products:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: data.products.length,
                        itemBuilder: (context, index) {
                          final product = data.products[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('• ${product.name}'),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Qty: ${product.qty}'),
                                  Text('Price: ₹${product.price}'),
                                ],
                              ),
                              const SizedBox(height: 10),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCompletedOrderListItem(
      BuildContext context, int index, List<Orders> ordersList) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order #${ordersList[index].id.length > 6 ? ordersList[index].id.substring(
                      0,
                      6,
                    ) : ordersList[index].id}', // Replace with actual order number
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Completed',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ).onTap(
                () async {
                  await updateOrderStatus(ordersList[index].id);
                  Get.dialog(
                    Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(
                          20,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                        child: const Text(
                          'Order Status Changed to completed successfully',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Email: ${ordersList[index].userId}', // Replace with actual email
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '₹${ordersList[index].totalAmount}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ).onTap(() {
      showOrderDetailsDialog(context, ordersList[index]);
    });
  }

  Future<void> updateOrderStatus(String orderId) async {
    try {
      // Update order status to 'completed' in Firestore
      await FirebaseFirestore.instance
          .collection('ordersMaster')
          .doc(orderId)
          .update({'status': 'completed'});
    } catch (error) {
      debugPrint('Error updating order status: $error');
      Get.dialog(
        AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          title: const Text('Alert'),
          content: const Text('Order status failed to get update.'),
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
    }
  }
}
