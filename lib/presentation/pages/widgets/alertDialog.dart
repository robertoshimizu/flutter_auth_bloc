import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc/domain/entities/entities.dart';
import 'package:flutter_auth_bloc/domain/repository/repositories.dart';

import '../../../data/repository/repositories.dart';
import '../../../locator.dart';

showAlertDialog(
    BuildContext context, String purpose, Object object, String message) {
  // print('Alert para confirmação deletar requestId: $requestId');
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancelar"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = TextButton(
    child: Text("Continuar"),
    onPressed: () {
      // Navigator.pop(context);
      // _addIndicationToFirestore(newIndication, requestId);
      deleteDocumentFromFirestore(purpose, object);
      Navigator.pushNamedAndRemoveUntil(context, 'home_screen', (_) => false);
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Confirmação"),
    content: Text(message),
    actions: [
      cancelButton,
      continueButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

deleteDocumentFromFirestore(String purpose, Object object) {
  switch (purpose) {
    case 'indication':
      try {
        Indication indication = object;
        IndicationRepository indicationRepo =
            IndicationRepository(indication.requestId);
        indicationRepo.deleteIndication(indication.indicationId);
      } catch (e) {
        print(e);
      }
      break;
    case 'request':
      var qquer = locator<DataAllRequests>();
      try {
        // qquer.deleteRequest(requestId);
        // print("RequestId $requestId deleted!");
      } catch (e) {
        print(e);
      }
      break;
    default:
      break;
  }
}
