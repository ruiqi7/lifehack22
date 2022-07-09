import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lifehack22/models/app_user.dart';

class DatabaseService {

  final String uid;

  DatabaseService({ required this.uid });

  // collection reference
  final CollectionReference userDatabaseCollection = FirebaseFirestore.instance
      .collection('userDatabase');

  Future createNewUser() async {
    return await userDatabaseCollection.doc(uid).set({
      'name': '',
      'email': '',
      'phone': '',
    });
  }

  Future updateName(String name) async {
    return await userDatabaseCollection.doc(uid).update({
      'name': name,
    });
  }

  Future updateEmail(String email) async {
    return await userDatabaseCollection.doc(uid).update({
      'email': email,
    });
  }

  Future updatePhone(String phone) async {
    return await userDatabaseCollection.doc(uid).update({
      'phone': phone,
    });
  }

  Stream<List<AppUser>> userStream() {
    return userDatabaseCollection
        .snapshots()
        .map(_userDataListFromSnapshot);
  }

  List<AppUser> _userDataListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return AppUser(
        uid: doc.id,
        name: doc.get('name'),
        email: doc.get('email'),
        phone: doc.get('phone'),
      );
    }).toList();
  }

  Stream<AppUser> get userData {
    return userDatabaseCollection.doc(uid).snapshots().map<AppUser>(_userDataFromSnapshot);
  }

  AppUser _userDataFromSnapshot(DocumentSnapshot snapshot) {
    snapshot = snapshot as DocumentSnapshot<Map<String, dynamic>>;
    final data = snapshot.data();
    return AppUser(
      uid: snapshot.id,
      name: data?['name'],
      email: data?['email'],
      phone: data?['phone'],
    );
  }

  Future deleteUserDocument() async {
    return await FirebaseFirestore.instance.runTransaction((transaction) async =>
        transaction.delete(userDatabaseCollection.doc(uid)));
  }
}