import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummy_1/utils/exports.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeController extends GetxController {
  late Stream<QuerySnapshot> beveragesStream;
  late Stream<QuerySnapshot> nonVegStream;
  late Stream<QuerySnapshot> vegStream;
  late Stream<QuerySnapshot> featuredStream;

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  void onInit() {
    nonVegStream = fetchNonVegData();
    vegStream = fetchVegetarianData();
    beveragesStream = fetchBeveragesData();
    featuredStream = fetchfeaturedData();
    super.onInit();
  }

  Stream<QuerySnapshot> fetchNonVegData() {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final CollectionReference mainCollection =
        firestore.collection('AdminMaster');
    CollectionReference nonVegItemCollection =
        mainCollection.doc('NonVegetarian').collection('nonveg');

    return nonVegItemCollection.snapshots();
  }

  Stream<QuerySnapshot> fetchBeveragesData() {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final CollectionReference mainCollection =
        firestore.collection('AdminMaster');
    CollectionReference beveragesItemCollection =
        mainCollection.doc('Beverages').collection('coldDrinks');

    return beveragesItemCollection.snapshots();
  }

  Stream<QuerySnapshot> fetchVegetarianData() {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final CollectionReference mainCollection =
        firestore.collection('AdminMaster');
    CollectionReference beveragesItemCollection =
        mainCollection.doc('Vegetarian').collection('veg');

    return beveragesItemCollection.snapshots();
  }

  Stream<QuerySnapshot> fetchfeaturedData() {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final CollectionReference mainCollection =
        firestore.collection('AdminMaster');
    CollectionReference beveragesItemCollection =
        mainCollection.doc('FeaturedProducts').collection('featured');

    return beveragesItemCollection.snapshots();
  }
}
