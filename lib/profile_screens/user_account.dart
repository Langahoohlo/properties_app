import 'package:flutter/material.dart';
import 'package:properties_app/profile_screens/user_account/user_listing.dart';

class UserAccount extends StatelessWidget {
  final uid;
  const UserAccount({super.key, required this.uid});
  // const AgencyLogo({Key? key, required this.snap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Container(
                height: 54,
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.yellow,
                ),
                child: TextButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)))),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text("Edit Profile",
                          style: TextStyle(color: Colors.black, fontSize: 16)),
                    ],
                  ),
                  onPressed: () {},
                )),
            Container(
                height: 54,
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.black54,
                ),
                child: TextButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)))),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text("Your Listings",
                          style: TextStyle(color: Colors.yellow, fontSize: 16)),
                    ],
                  ),
                  onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => UserListings())),
                )),
            Container(
                height: 54,
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.black54,
                ),
                child: TextButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)))),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text("About",
                          style: TextStyle(color: Colors.yellow, fontSize: 16)),
                    ],
                  ),
                  onPressed: () {},
                ))
          ],
        ),
      ),
    );
  }
}
