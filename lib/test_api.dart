// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class TestApi extends StatefulWidget {
//   const TestApi({super.key});

//   @override
//   State<TestApi> createState() => _TestApiState();
// }

// class _TestApiState extends State<TestApi> {
//   // @override
//   // void initState() {
//   //   getProduct();
//   //   super.initState();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         color: Colors.lightBlue,
//         padding: const EdgeInsets.all(10.0),
//         child: FutureBuilder(
//           future: getProduct(),
//           builder: (context, snapshot) {
//             if (snapshot.hasError) {
//               return Center(child: Text("ERROR"));
//             } else if (snapshot.hasData) {
//               return snapshot.data!.isEmpty
//                   ? Center(child: Text("No data"))
//                   : ListView.builder(
//                       itemCount: snapshot.data!.length,
//                       itemBuilder: (context, i) {
//                         return ListTile(
//                           title: Text(snapshot.data![i].name),
//                           leading: Text("${snapshot.data![i].id}"),
//                           subtitle: Text("${snapshot.data![i].price}"),
//                         );
//                       },
//                     );
//             } else {
//               return Center(child: CircularProgressIndicator());
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

// class ProductsModel {
//   final int id;
//   final String name;
//   final int? price;
//   final bool? available;

//   ProductsModel({
//     required this.id,
//     required this.name,
//     required this.price,
//     required this.available,
//   });

//   factory ProductsModel.fromJson(Map<String, dynamic> json) {
//     return ProductsModel(
//       id: json["product_id"],
//       name: json["product_name"],
//       price: json["product_price"],
//       available: json["is_available"],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       "product_id": id,
//       "product_name": name,
//       "product_price": price ?? 0,
//       "is_available": available ?? false,
//     };
//   }
// }

// Future<List<ProductsModel>> getProduct() async {
//   final http.Client client = http.Client();

//   try {
//     final response = await client.get(Uri.parse("http://192.168.1.7/products"));
//     print(response.statusCode);
//     if (response.statusCode == 200) {
//       print(jsonDecode(response.body));
//       final List responseBody = jsonDecode(response.body) as List;
//       print(responseBody);
//       return responseBody
//           .map((product) => ProductsModel.fromJson(product))
//           .toList();
//     } else {
//       return [];
//     }
//   } catch (e) {
//     print("===================================");
//     print(e);
//     print("===================================");
//     return [];
//   }
// }
