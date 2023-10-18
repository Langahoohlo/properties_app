import 'package:flutter/material.dart';

class RealEstateImage extends StatefulWidget {
  //final String postId;
  // final String imageUrl;
  // final String address;
  // final String price;

  const RealEstateImage({
    Key? key,
    //required this.postId,
    // required this.imageUrl,
    // required this.address,
    // required this.price,
  }) : super(key: key);

  @override
  State<RealEstateImage> createState() => _RealEstateImageState();
}

class _RealEstateImageState extends State<RealEstateImage> {
  // var userData = {};

  // @override
  // void initState() {
  //   getUserData();
  //   super.initState();
  // }

  // getUserData() async {
  //   try {
  //     var userSnap = await FirebaseFirestore.instance
  //         .collection('posts')
  //         .doc(widget.postId)
  //         .get();

  //     userData = userSnap.data()!;
  //     setState(() {});
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
        image: const DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
              'https://scontent.fmsu1-1.fna.fbcdn.net/v/t39.30808-6/318155205_10161290033996015_8460465891143865652_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=730e14&_nc_eui2=AeHSecxjOV-45ofIaERbdKKGBOuFbXEsI1IE64VtcSwjUnGLnj49NbolSJOljfeDW70nOxK6QKwNg3lpn7H1UHB4&_nc_ohc=B7KlJ67KAo0AX8zNO5D&_nc_ht=scontent.fmsu1-1.fna&oh=00_AfCAmwFeYhaGwIUOurREyINjKxoClMi07iwZvBUHBwEl-g&oe=639A2563'),
        ),
      ),
      child: const Stack(
        children: [
          Positioned(
            bottom: 8,
            left: 8,
            child: Text(
              'userData[address]',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            bottom: 8,
            right: 8,
            child: Text(
              'R5000',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
