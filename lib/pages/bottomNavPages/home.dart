import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:properties_app/pages/agency%20screen/agency_logo.dart';
import 'package:properties_app/pages/screens/edit_profile.dart';
import 'package:properties_app/pages/screens/upload_post.dart';
import 'package:properties_app/pages/screens/user_post_card_view.dart';
import 'package:properties_app/widgets/google_sign_in_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class UserHome extends StatefulWidget {
  const UserHome({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  final user = FirebaseAuth.instance.currentUser!;

  var userData = {};
  int postLen = 0;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();

      //post numbers
      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      postLen = postSnap.docs.length;
      userData = userSnap.data()!;
      setState(() {});
    } catch (e) {
      print(e);
      //showSnackBar(context, e.toString());
    }

    //   print(snap.data());

    //   setState(() {
    //     username = (snap.data() as Map<String, dynamic>)['username'];
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    final googleUser = Provider.of<GoogleSignInProvider>(context);
    //model.User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          user.providerData.first.providerId == 'google.com'
              ? user.displayName ?? "user"
              : '${userData['username'] ?? "user"}',
        ),
        actions: [
          IconButton(
            onPressed: user.providerData.first.providerId != 'google.com'
                ? () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditProfile(
                              uid: widget.uid,
                              username: userData['username'],
                            )))
                : () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            //title: Text("You can't edit your profile"),
                            content: const Text(
                                "You can't edit your profile because you are logged in with google"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Ok"))
                            ],
                          );
                        });
                  },
            icon: user.providerData.first.providerId != 'google.com'
                ? const Icon(Icons.edit)
                : const Icon(Icons.edit_off),
          ),
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        //child: Text(user.username),
        children: [
          const AgencyLogo(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              //mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  // backgroundImage: NetworkImage(userData['photoUrl'] ??
                  //     "https://images.unsplash.com/photo-1557682250-33bd709cbe85?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1129&q=80"),
                  backgroundImage: NetworkImage(
                    user.providerData.first.providerId == 'google.com'
                        ? user.photoURL ??
                            'https://images.unsplash.com/photo-1557682250-33bd709cbe85?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1129&q=80'
                        : userData['photoUrl'] ??
                            'https://images.unsplash.com/photo-1557682250-33bd709cbe85?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1129&q=80',
                  ),
                  radius: 60,
                ),
                const SizedBox(height: 10),
                Container(
                  //alignment: Alignment.center,
                  padding: const EdgeInsets.only(top: 1),
                  child: Text(
                    user.providerData.first.providerId == 'google.com'
                        ? user.displayName ?? "user"
                        : '${userData['username'] ?? "user"}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UploadScreen())),
                  child: const Text(
                    'List Privately',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.blue),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //margin: const EdgeInsets.only(top: 4),
                  children: [
                    Text(
                      "$postLen House's Listed",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(),
          FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('posts')
                .where('uid', isEqualTo: widget.uid)
                .get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return GridView.builder(
                  shrinkWrap: true,
                  itemCount: (snapshot.data! as dynamic).docs.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 1.5,
                      childAspectRatio: 1),
                  itemBuilder: (context, index) {
                    DocumentSnapshot snap =
                        (snapshot.data! as dynamic).docs[index];
                    return Container(
                        child: InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const UserPostCardView())),
                      child: Image(
                        image: NetworkImage(
                            (snap.data()! as dynamic)['postUrl'] ?? "null"),
                        fit: BoxFit.cover,
                      ),
                    ));
                  });
            },
          )
        ],
      ),
    );
  }

  Column buildStatColumn(int num, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Text(
            label,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.w400, color: Colors.grey),
          ),
        )
      ],
    );
  }
}
