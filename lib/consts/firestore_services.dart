import '../consts/firebase_constants.dart';

class FirestoreServices {
  //get users data
  static getUser(uid) {
    return firestore
        .collection(usersCollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }

  //get products according to category
  static getEventsByDate(day) {
    return firestore
        .collection(eventsCollection)
        .where('date', isEqualTo: day)
        .snapshots();
  }

  //get cart
  static getUserEvents(uid) {
    return firestore
        .collection(eventsCollection)
        .where('added_by', isEqualTo: uid)
        .snapshots();
  }

  static getUserBookedEvents(uid) {
    return firestore
        .collection(bookedEventsCollection)
        .where('booked_by', isEqualTo: uid)
        .snapshots();
  }

  // delete document
  static deleteEvent(docId) {
    return firestore.collection(eventsCollection).doc(docId).delete();
  }

  // delete booked Event
  static deleteBookedEvent(docId) {
    return firestore.collection(eventsCollection).doc(docId).delete();
  }
}
