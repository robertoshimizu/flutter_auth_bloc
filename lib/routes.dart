import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc/presentation/pages/pages.dart';

import 'presentation/pages/contacts/select_OneContact_widget.dart';
import 'presentation/pages/contacts/select_contacts_widget.dart';
import 'presentation/pages/profile/main_profile.dart';
import 'presentation/pages/service_request/add_new_request_view.dart';
import 'presentation/pages/service_request/needRequest_page.dart';

class Routeer {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'phoneLoginWrapper':
        return MaterialPageRoute(builder: (_) => PhoneLoginWrapper());
      // case 'home_screen':
      //   return MaterialPageRoute(builder: (_) => HomePage());
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
