import 'package:flutter/material.dart';

import 'presentation/pages/pages.dart';

class Routeer {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'phoneLoginWrapper':
        return MaterialPageRoute(builder: (_) => PhoneLoginWrapper());
      case 'home_screen':
        return MaterialPageRoute(builder: (_) => HomePage());
      // case 'main_profile':
      //   return MaterialPageRoute(builder: (_) => Profile());
      // case 'first_profile1':
      //   return MaterialPageRoute(builder: (_) => FirstProfile1());
      // case 'first_profile2':
      //   return MaterialPageRoute(builder: (_) => FirstProfile2());
      // case 'mycontacts_screen':
      //   return MaterialPageRoute(builder: (_) => Contacts());
      case 'needRequest_screen':
        return MaterialPageRoute(builder: (_) => NeedRequestPage());
      case 'myNeedRequest_screen':
        return MaterialPageRoute(builder: (_) => MyNeedRequestPage());
      case 'addRequest_screen':
        return MaterialPageRoute(builder: (_) => AddNewRequestPage());
      case 'contacts_widget':
        return MaterialPageRoute(builder: (_) => SelectContacts());
      case 'oneContact_widget':
        return MaterialPageRoute(builder: (_) => SelectOneContact());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
