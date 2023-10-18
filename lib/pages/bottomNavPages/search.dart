// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:properties_app/pages/detail/detail.dart';
import 'package:properties_app/widgets/bookmarked.dart';
import 'package:properties_app/widgets/custom_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../widgets/recommended_house.dart';
import '../../widgets/welcome_text.dart';

class UserSearch extends StatefulWidget {
  const UserSearch({super.key});

  @override
  State<UserSearch> createState() => _UserSearchState();
}

class _UserSearchState extends State<UserSearch> {
  final TextEditingController searchController = TextEditingController();
  bool isShowPosts = false;

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: ListView(
        children: [
          WelcomeText(),
          Container(
            padding: EdgeInsets.all(15),
            child: TextFormField(
              onFieldSubmitted: (String _) {
                setState(() {
                  isShowPosts = true;
                });
              },
              controller: searchController,
              decoration: InputDecoration(
                fillColor: Color.fromARGB(255, 211, 220, 228),
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8),
                ),
                hintText: 'Search here...',
                prefixIcon: Container(
                  padding: EdgeInsets.all(20),
                  child: const Icon(Icons.search),
                ),
                contentPadding: EdgeInsets.all(2),
              ),
            ),
          ),
          isShowPosts
              ? FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('posts')
                      .where('district',
                          isGreaterThanOrEqualTo: searchController.text)
                      .get(),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: (snapshot.data! as dynamic).docs.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => DetailPage(
                                        postId: (snapshot.data! as dynamic)
                                            .docs[index]['postId'],
                                      ))),
                          child: SizedBox(
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  (snapshot.data! as dynamic).docs[index]
                                      ['postUrl'],
                                ),
                                radius: 24,
                              ),
                              title: Text(
                                (snapshot.data! as dynamic).docs[index]
                                    ['aboutHouse'],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }))
              : RecommendedHouse(),
          BookMarked(),
          // StreamBuilder(
          //   stream:
          //       // typeOfProperty != null
          //       //     ? FirebaseFirestore.instance
          //       //         .collection('posts')
          //       //         .where('typeOfProperty', isEqualTo: typeOfProperty)
          //       //         .where('forSaleOrForRent', isEqualTo: rentalOrSale)
          //       //         .snapshots()
          //       //     : priceRange != null
          //       //         ? FirebaseFirestore.instance
          //       //             .collection('posts')
          //       //             .where('price', isGreaterThanOrEqualTo: priceRange)
          //       //             .snapshots():
          //       FirebaseFirestore.instance.collection('posts').snapshots(),
          //   builder: (context,
          //       AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return const Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     }
          //     return ListView.separated(
          //       scrollDirection: Axis.vertical,
          //       itemCount: snapshot.data!.docs.length,
          //       itemBuilder: (context, index) => PostCard(
          //         snap: snapshot.data!.docs[index].data(),
          //       ),
          //       separatorBuilder: (BuildContext context, int index) =>
          //           const Divider(
          //         height: 5,
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
