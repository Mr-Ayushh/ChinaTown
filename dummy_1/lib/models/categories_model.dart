// class CategoriesList {
//   List<Categories>? categories;

//   CategoriesList({this.categories});

//   CategoriesList.fromJson(Map<String, dynamic> json) {
//     if (json['categories'] != null) {
//       categories = [];
//       json['categories'].forEach((v) {
//         categories?.add(Categories.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (categories != null) {
//       data['categories'] = categories?.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Categories {
//   String? id;
//   String? title;
//   List<Products>? products;

//   Categories({this.id, this.title, this.products});

//   Categories.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//     if (json['products'] != null) {
//       products = [];
//       json['products'].forEach((v) {
//         products?.add(Products.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['title'] = title;
//     if (products != null) {
//       data['products'] = products?.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

class Products {
  String? id;
  String? name;
  double price = 0.0;
  double dummyPrice = 0.0;
  String? categoryID;
  String? picturePath;
  String? description;

  Products(
      {this.id,
      this.name,
      this.price = 0.0,
      this.dummyPrice = 0.0,
      this.categoryID,
      this.picturePath,
      this.description});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'dummyPrice': dummyPrice,
      'description': description,
      'picturePath': picturePath,
      'categoryID': categoryID,
    };
  }
}
