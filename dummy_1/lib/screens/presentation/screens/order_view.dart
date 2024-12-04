import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummy_1/models/orders_model.dart';
import 'package:dummy_1/utils/app_data.dart';
import 'package:dummy_1/utils/app_images.dart';
import 'package:dummy_1/utils/exports.dart';
import 'package:share_plus/share_plus.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    getOrders();
    tabController = TabController(length: 2, vsync: this);
    tabController.animation!.addListener(() {
      if (tabController.animation!.value.round() != tabController.index) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    tabController.animation!.removeListener(() {});
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        height: Get.height,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: Get.height * 0.15,
              child: const Center(
                child: Text(
                  'My Orders',
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TabBar(
                      controller: tabController,
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      dividerColor: Colors.transparent,
                      unselectedLabelColor: AppColors.black,
                      labelColor: AppColors.primary,
                      indicator: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      onTap: (index) {
                        tabController.index = index;
                        setState(() {});
                      },
                      tabs: <Widget>[
                        buildTabContainer(
                          title: 'Orders',
                          fontColor: tabController.index == 0
                              ? AppColors.white
                              : AppColors.primary,
                          backgroundColor: tabController.index == 0
                              ? AppColors.primary
                              : AppColors.kFFDECF,
                        ),
                        buildTabContainer(
                          title: 'History',
                          fontColor: tabController.index == 1
                              ? AppColors.white
                              : AppColors.primary,
                          backgroundColor: tabController.index == 1
                              ? AppColors.primary
                              : AppColors.kFFDECF,
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: Divider(
                        color: AppColors.primary,
                        height: 0,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 30),
                        child: TabBarView(
                          controller: tabController,
                          children: <Widget>[
                            buildOrderList(),
                            buildHistoryList(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOrderList() {
    return Expanded(
      child: StreamBuilder<List<Orders>>(
          stream: getOrders(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Loading Data Wait a while....');
            }

            List<Orders> orders = snapshot.data!;
            List<Orders> pendingOrders =
                orders.where((order) => order.status == 'pending').toList();
            if (!snapshot.hasData || pendingOrders.isEmpty) {
              return Center(
                child: buildEmptyOrderView(),
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
    );
  }

  void shareOrder(BuildContext context, Orders order) async {
    String orderDetails = 'Order ID: ${order.id}\n'
        'User ID: ${order.userId}\n'
        'Total Amount: ₹${order.totalAmount}\n'
        'Products:\n';

    for (var product in order.products) {
      orderDetails += '- ${product.name}, Quantity: ${product.qty}\n';
    }

    await Share.share(orderDetails, subject: 'Order Details');
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
      margin: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[300],
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
              10.widthBox,
              Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Preparing',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  10.widthBox,
                  Icon(
                    Icons.share,
                    size: 20.sp,
                    weight: 700,
                    color: AppColors.black,
                  ).onTap(() {
                    shareOrder(context, ordersList[index]);
                  }),
                ],
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

  Widget buildHistoryList() {
    return Expanded(
      child: StreamBuilder<List<Orders>>(
          stream: getOrders(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Loading Data Wait a while....');
            }

            List<Orders> orders = snapshot.data!;
            List<Orders> pendingOrders =
                orders.where((order) => order.status == 'completed').toList();
            if (!snapshot.hasData || pendingOrders.isEmpty) {
              return buildEmptyHistoryView();
            }
            return ListView.builder(
              itemCount: pendingOrders.length,
              itemBuilder: (context, index) {
                return _buildCompletedOrderListItem(
                    context, index, pendingOrders);
              },
            );
          }),
    );
  }

  Column buildEmptyHistoryView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(AppAssets.noHistory),
        const SizedBox(height: 30),
        const Text(
          'No history yet',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        // const SizedBox(height: 10),
        // const Text(
        //   'Hit the button down\nbelow to Create an order',
        //   textAlign: TextAlign.center,
        //   style: TextStyle(fontSize: 14),
        // ),
      ],
    );
  }

  Column buildEmptyOrderView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(AppAssets.noOrder),
        const SizedBox(height: 30),
        const Text(
          'No orders yet',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Hit the button down\nbelow to Create an order',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  Container buildTabContainer({
    required String title,
    Color? fontColor,
    Color? backgroundColor,
  }) {
    return Container(
      width: double.maxFinite,
      height: 35,
      padding: const EdgeInsets.all(4),
      decoration: ShapeDecoration(
        color: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(38),
        ),
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: fontColor,
          fontSize: 17,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  static final CollectionReference _ordersCollection =
      FirebaseFirestore.instance.collection('ordersMaster');

  static Stream<List<Orders>> getOrders() {
    return _ordersCollection.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => Orders.fromFirestore(doc))
        .where((element) => element.userId == AppData.email)
        .toList());
  }
}
