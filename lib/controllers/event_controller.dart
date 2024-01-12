import '../consts/firebase_constants.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class EventController extends GetxController {
  createEvent(
    title,
    img,
    eventDate,
    eventInfo,
    sponsors,
    context,
  ) async {
    await firestore.collection(eventsCollection).doc().set({
      'title': title,
      'img': img,
      'eventDate': eventDate,
      'eventInfo': eventInfo,
      'sponsors': sponsors,
      'added_by': currentUser!.uid
    }).catchError((e) {
      VxToast.show(context, msg: e.toString());
    });
  }
}
