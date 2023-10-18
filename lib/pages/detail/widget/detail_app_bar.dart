import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:properties_app/utils/dimensions.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class DetailAppBar extends StatefulWidget {
  final postId;
  const DetailAppBar({Key? key, required this.postId}) : super(key: key);

  @override
  State<DetailAppBar> createState() => _DetailAppBarState();
}

class _DetailAppBarState extends State<DetailAppBar> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var userData = {};
  int postLen = 0;

  @override
  void initState() {
    super.initState();
    getPostInfo();
  }

  getPostInfo() async {
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.postId)
          .get();

      userData = userSnap.data()!;
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          height: 400,
          width: MediaQuery.of(context).size.width > webScreenSize ? 800 : 475,
          color: Colors.white,
          child: Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width > webScreenSize
                    ? 800
                    : 475,
                height: 400,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('posts')
                        .doc(widget.postId)
                        .collection('collectionPath')
                        .snapshots(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Container(
                        width: MediaQuery.of(context).size.width > webScreenSize
                            ? 800
                            : 475,
                        height: 400,
                        color: Colors.blue,
                        // decoration: const BoxDecoration(
                        //     borderRadius: BorderRadius.only(
                        //         bottomLeft: Radius.circular(20),
                        //         bottomRight: Radius.circular(20))),
                        child: PhotoViewGallery.builder(
                            itemCount: snapshot.data!.docs.length,
                            builder: (context, index) {
                              snapshot.data!.docs[index].get('url');
                              return PhotoViewGalleryPageOptions(
                                  maxScale:
                                      PhotoViewComputedScale.contained * 2.0,
                                  minScale: PhotoViewComputedScale.contained,
                                  initialScale:
                                      PhotoViewComputedScale.contained,
                                  imageProvider: NetworkImage(
                                      snapshot.data!.docs[index].get('url')));
                            }),
                      );
                    }),
              ),
              SafeArea(
                  child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 20,
                      width: 20,
                      // padding: const EdgeInsets.all(0.1),
                      // decoration: const BoxDecoration(
                      //     color: Colors.grey, shape: BoxShape.circle),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ),
                    Container(
                      height: 20,
                      width: 20,
                      padding: const EdgeInsets.all(5),
                      /*decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                shape: BoxShape.circle),*/
                      child: const Icon(Icons.share, color: Colors.blueGrey),
                      // IconButton(
                      //     onPressed: () async {
                      //       await FireStoreMethods().likePost(
                      //           widget.postId,
                      //           FirebaseAuth.instance.currentUser!.uid,
                      //           userData['likes']);
                      //     },
                      //     icon: userData['likes'].contains(
                      //             FirebaseAuth.instance.currentUser!.uid)
                      //         ? const Icon(
                      //             Icons.bookmark_add,
                      //             color: Colors.deepPurple,
                      //             size: 32,
                      //           )
                      //         : const Icon(
                      //             Icons.bookmark_add_outlined,
                      //             size: 26,
                      //           ))
                    )
                  ],
                ),
              ))
            ],
          )),
    );
  }
}
