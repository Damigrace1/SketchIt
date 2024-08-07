import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Query users collection for a particular user by user ID
  Future<DocumentSnapshot> getUserById(String userId) async {
    try {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(userId).get();
      return userDoc;
    } catch (e) {
      print('Error fetching user: $e');
      rethrow;
    }
  }

  // Save sketch data for a particular user
  Future<void> saveSketchData(String userId, List sketchData, String projName) async {
    try {
      await _firestore.collection('users').doc(userId).collection('myworks').doc(projName).set({
      'timestamp' : FieldValue.serverTimestamp(),
        "name" : projName,
        "data" : sketchData
      });
      Get.snackbar('Success', 'Sketch saved successfully');
    } catch (e) {
      print('Error saving sketch data: $e');
      rethrow;
    }
  }

  // Retrieve sketch data for a particular user
  Future<List<QueryDocumentSnapshot>> getSketchData(String userId, String projName) async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('users').doc(userId).collection('myworks').get();
      return snapshot.docs;
    } catch (e) {
      print('Error fetching sketch data: $e');
      rethrow;
    }
  }

 void collaborate(String userId, String projName) async {
    try {
      print('started listening');
       _firestore.collection('users').doc(userId).collection('myworks').doc(projName).
   snapshots().listen((data)=>print(data)
      );
    } catch (e) {
      print('Error saving sketch data: $e');
      rethrow;
    }
  }
}
