import 'package:flutter/material.dart';
//import 'package:properties_app/pages/auth/login_page.dart';
import 'package:properties_app/pages/screens/upload_post.dart';


class RouteManager {
  static const String homePage = '/';
  static const String uploadPage = '/uploadPage';
  static const String loginpage = '/loginPage';
  static const String detailPage = '/detailPage';
  //final listOfOffer = House.generateBestOffer();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case loginpage:
      //   return MaterialPageRoute(
      //     builder: (context) => LoginPage(
      //       showRegisterPage: () {},
      //     ),
      //   );

      case uploadPage:
        return MaterialPageRoute(
          builder: (context) => const UploadScreen(),
        );

      // case homePage:
      //   return MaterialPageRoute(builder: (context) => HomePage());

      /* case detailPage:
        return MaterialPageRoute(builder: (context) => DetailPage(house: listOfOffer[index] ,));
          */

      default:
        throw const FormatException('Route not found! Check routes again!');
    }
  }
}
