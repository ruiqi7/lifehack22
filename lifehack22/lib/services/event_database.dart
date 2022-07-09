import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lifehack22/event.dart';

class EventDatabase {

  //collection reference
  final CollectionReference eventDatabaseCollection = FirebaseFirestore.instance
      .collection('eventDatabase');

  final DateTime _now = DateTime.now();

  //get forumDatabase stream
  Stream<QuerySnapshot> get eventDatabaseStream {
    return eventDatabaseCollection.snapshots();
  }

  List<Event> eventListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Event(
        eventId: doc.reference.id,
        imageUrl: doc.data().toString().contains('imageUrl') ? doc.get('imageUrl'): '',
        title: doc.data().toString().contains('title') ? doc.get('title'): '',
        dateTime: doc.data().toString().contains('dateTime') ? doc.get('dateTime'): '',
        region: doc.data().toString().contains('region') ? doc.get('region'): '',
        quota: doc.data().toString().contains('quota') ? doc.get('quota'): 0,
        activityType: doc.data().toString().contains('activityType') ? doc.get('activityType'): '',
        community: doc.data().toString().contains('community') ? doc.get('community'): '',
        details: doc.data().toString().contains('details') ? doc.get('details'): '',
        contactName: doc.data().toString().contains('contactName') ? doc.get('contactName'): '',
        contactNumber: doc.data().toString().contains('contactNumber') ? doc.get('contactNumber'): '',
        contactEmail: doc.data().toString().contains('contactEmail') ? doc.get('contactEmail'): '',
        organiserUid: doc.data().toString().contains('organiserUid') ? doc.get('organiserUid'): '',
        participantsList: doc.data().toString().contains('participantsList') ? doc.get('participantsList'): [],
      );
    }).toList();
  }

  //get event document stream
  Stream<Event> eventData(String eventId) {
    return eventDatabaseCollection.doc(eventId).snapshots().map<Event>(_eventDataFromSnapshot);
  }

  // event data from snapshot
  Event _eventDataFromSnapshot(DocumentSnapshot snapshot) {
    snapshot = snapshot as DocumentSnapshot<Map<String, dynamic>>;
    final data = snapshot.data();
    return Event(
      eventId: snapshot.id,
      imageUrl: data?['imageUrl'],
      title: data?['title'],
      dateTime: data?['dateTime'],
      region: data?['region'],
      quota: data?['quota'],
      activityType: data?['activityType'],
      community: data?['community'],
      details: data?['details'],
      contactName: data?['contactName'],
      contactNumber: data?['contactNumber'],
      contactEmail: data?['contactEmail'],
      organiserUid: data?['organiserUid'],
      participantsList: data?['participantsList'],
    );
  }

  Future createNewEvent(String imageUrl, String title, String dateTime, String region, int quota,
      String activityType, String community, String details, String organiserUid) async {
      
    return await eventDatabaseCollection.add({
      'imageUrl': imageUrl,
      'title': title,
      'dateTime': dateTime,
      'region': region,
      'quota': quota,
      'activityType': activityType,
      'community': community,
      'details': details,
      'organiserUid': organiserUid,
      'participantsList': [organiserUid],
    });
  }

  //get eventDatabase stream of upcoming events that user has registered for home page
  Stream<List<Event>> homeEventsStream(String uid) {
    return eventDatabaseCollection
        .where('participantsList', arrayContains: uid)
        .where('dateTime', isGreaterThanOrEqualTo: _now)
        .orderBy('dateTime')
        .snapshots()
        .map(eventListFromSnapshot);
  }

  //get eventDatabase stream of upcoming events for volunteering page
  Stream<List<Event>> volunteeringEventsStream() {
    return eventDatabaseCollection
        .where('dateTime', isGreaterThanOrEqualTo: _now)
        .orderBy('dateTime')
        .snapshots()
        .map(eventListFromSnapshot);
  }

  //get eventDatabase stream of upcoming events for organising page
  Stream<List<Event>> organisingEventsStream(String uid) {
    return eventDatabaseCollection
        .where('organiserUid', isEqualTo: uid)
        .where('dateTime', isGreaterThanOrEqualTo: _now)
        .orderBy('dateTime')
        .snapshots()
        .map(eventListFromSnapshot);
  }

  //get eventDatabase stream of upcoming events that user has registered for home page
  Stream<List<Event>> pastEventsStream(String uid) {
    return eventDatabaseCollection
        .where('participantsList', arrayContains: uid)
        .where('dateTime', isLessThanOrEqualTo: _now)
        .orderBy('dateTime')
        .snapshots()
        .map(eventListFromSnapshot);
  }

  Future registerEvent(String uid, String eventId) async {
    List<dynamic> list = [uid];
    return await eventDatabaseCollection.doc(eventId).update({
      'participantsList': FieldValue.arrayUnion(list),
    });
  }

  Future unregisterEvent(String uid, String eventId) async {
    List<dynamic> list = [uid];
    return await eventDatabaseCollection.doc(eventId).update({
      'participantsList': FieldValue.arrayRemove(list),
    });
  }

}