import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummy_1/screens/admin/add_item_page.dart';
import 'package:dummy_1/utils/exports.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class VegListPage extends StatefulWidget {
  const VegListPage({super.key});

  @override
  State<VegListPage> createState() => _VegListPageState();
}

class _VegListPageState extends State<VegListPage> {
  late Stream<QuerySnapshot> vegStream;
  @override
  void initState() {
    vegStream = fetchFeaturedData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.15,
            decoration: const BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: const Center(
              child: Text(
                'Veg Product List',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          20.heightBox,
          OutlinedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddItemPage(
                    categoryName: 'Vegetarian',
                  ),
                ),
              );
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.red), // Outline color
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Add Items',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.red, // Button text color
              ),
            ),
          ).pOnly(
            left: 20,
            right: 20,
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: vegStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Something went wrong'));
                } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var item = snapshot.data!.docs[index].data()
                          as Map<String, dynamic>;
                      String name = item['name'];
                      String description = item['description'];
                      double price = item['price'];
                      String picturePath = item['picturePath'];
                      String categoryName = item['category'];

                      return Slidable(
                        key: const ValueKey(0),
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          // dismissible: DismissiblePane(onDismissed: () {
                          //   deleteItem(
                          //     snapshot.data!.docs[index].id,
                          //     item['category'],
                          //   );
                          // }),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                deleteItem(
                                  snapshot.data!.docs[index].id,
                                  item['category'],
                                );
                              },
                              backgroundColor: const Color(0xFFFE4A49),
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Delete',
                            ),
                          ],
                        ),
                        child: ListTile(
                          title: Text(name),
                          subtitle: Text(description),
                          trailing: Text('₹$price'),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                          tileColor: Colors.grey.shade200,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddItemPage(
                                  name: name,
                                  description: description,
                                  price: price.toString(),
                                  picturePath: picturePath,
                                  categoryName: 'Vegetarian',
                                ),
                              ),
                            );
                          },
                        ),
                      ).pOnly(
                        left: 20,
                        bottom: 10,
                        right: 20,
                      );
                    },
                  );
                } else {
                  return const Center(child: Text('No items found'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void deleteItem(String documentId, String category) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final CollectionReference productCollection = firestore
        .collection('AdminMaster')
        .doc(category)
        .collection(category.toLowerCase() == 'beverages'
            ? 'coldDrinks'
            : category.toLowerCase() == 'featuredproducts'
                ? 'featured'
                : category.toLowerCase() == 'nonvegetarian'
                    ? 'nonveg'
                    : category.toLowerCase() == 'vegetarian'
                        ? 'veg'
                        : '');

    try {
      await productCollection.doc(documentId).delete();
      setState(() {
        vegStream = fetchFeaturedData();
      });
      debugPrint('Product deleted successfully');
    } catch (e) {
      debugPrint('Error deleting product: $e');
    }
  }

  Stream<QuerySnapshot> fetchFeaturedData() {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final CollectionReference mainCollection =
        firestore.collection('AdminMaster');
    CollectionReference beveragesItemCollection =
        mainCollection.doc('Vegetarian').collection('veg');

    return beveragesItemCollection.snapshots();
  }
}
