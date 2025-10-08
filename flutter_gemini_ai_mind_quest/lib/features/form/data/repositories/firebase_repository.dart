import 'package:firebase_database/firebase_database.dart';
import '../models/user_data.dart';

class FirebaseRepository {
  final DatabaseReference _database;

  FirebaseRepository(FirebaseDatabase database)
      : _database = database.ref().child('users');

  Future<void> saveUserData(UserData userData) async {
    try {
      final newUserRef = _database.push();
      await newUserRef.set(userData.toJson());
    } catch (e) {
      throw Exception('Failed to save data: $e');
    }
  }
}
