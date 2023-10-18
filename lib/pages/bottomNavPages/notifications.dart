import 'package:flutter/material.dart';
import '../../model/user.dart' as model;
import 'package:provider/provider.dart';
import '../../providers/user_providers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:photo_view/photo_view_gallery.dart';

class UserNotifications extends StatefulWidget {
  final String uid;
  const UserNotifications({super.key, required this.uid});

  @override
  State<UserNotifications> createState() => _UserNotificationsState();
}

class _UserNotificationsState extends State<UserNotifications> {
  List items = [];
  var userData = {};
  //User data from firebase to be saved
  @override
  void initState() {
    super.initState();
    addData();
  }

  getData() async {
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.uid)
          .get();

      userData = userSnap.data()!;
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  addData() async {
    UserProvider userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
        appBar: AppBar(title: const Text('Testing ListView')),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .doc('6adca430-6bde-11ed-93a0-a1adfc0e78a8')
              .collection('collectionPath')
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return SizedBox(
              height: 400,
              width: 400,
              child: PhotoViewGallery.builder(
                  itemCount: snapshot.data!.docs.length,
                  builder: (context, index) {
                    snapshot.data!.docs[index].get('url');
                    return PhotoViewGalleryPageOptions(
                        imageProvider: NetworkImage(
                            snapshot.data!.docs[index].get('url')));
                  }),
            );
            // return GridView.builder(
            //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //         crossAxisCount: 3),
            //     itemCount: snapshot.data!.docs.length,
            //     itemBuilder: (context, index) {
            //       return Container(
            //         margin: EdgeInsets.all(3),
            //         child: FadeInImage.memoryNetwork(
            //           image: snapshot.data!.docs[index].get('url'),
            //           placeholder: kTransparentImage,
            //         ),
            //       );
            //     });
          },
        )
        // Container(
        //   height: 250,
        //   //width: 400,
        //   child: ListView.separated(
        //     scrollDirection: Axis.horizontal,
        //     itemCount: 5,
        //     separatorBuilder: ((context, _) => SizedBox(
        //           width: 12,
        //         )),
        //     itemBuilder: (context, index) => buildCard(),
        //   ),
        // )
        );

    // return StreamBuilder(
    //     stream: FirebaseFirestore.instance
    //         .collection('posts')
    //         //.where(userData['postId'] == widget.uid)
    //         .snapshots(),
    //     builder: (context,
    //         AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
    //       DocumentSnapshot snap = (snapshot.data! as dynamic).docs[snapshot];

    // return Scaffold(
    //     //body: PostCard(),
    //     body: SafeArea(
    //   child: Center(
    //     child: Column(
    //       children: [
    //         SizedBox(
    //           height: 75,
    //         ),
    //         Text(user.username),
    //         TextButton(
    //             onPressed: () => Navigator.of(context).push(MaterialPageRoute(
    //                 builder: (context) => UploadMultipleImages())),
    //             child: Text('Upload Images To Firebase'))
    //       ],
    //     ),
    //   ),
    // ));
  }

  Widget buildCard() => Container(
      width: 250,
      height: 250,
      color: Colors.red,
      child: const Column(
        children: [
          // Image.network(
          //   'https://firebasestorage.googleapis.com/v0/b/propertiesbylanga.appspot.com/o/houses%2Fimage_picker504366282.jpg?alt=media&token=dc7a39c3-6eac-4c65-8d12-bf24e470d7ae',
          //   fit: BoxFit.cover,
          // ),
        ],
      ));
  //);
}
//}
