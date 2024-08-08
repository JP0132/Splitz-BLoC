import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:splitz_bloc/data/models/split_model.dart';
import 'package:splitz_bloc/domain/repository/split_repository.dart';

class SplitRepositoryImpl implements SplitRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  SplitRepositoryImpl({required this.firestore, required this.auth});

  @override
  Future<void> createSplit(SplitModel split) async {
    final user = auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    final docRef = firestore.collection('splits').doc();
    final newSplit = split.copyWith(
      id: docRef.id,
      userId: user.uid,
      dateTime: DateTime.now(),
      totalAmount: 0,
    );

    await docRef.set(newSplit.toMap());
  }

  @override
  Future<List<SplitModel>> getAllSplits() async {
    final user = auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    final snapshot = await firestore
        .collection('splits')
        .where('userId', isEqualTo: user.uid)
        .get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return SplitModel.fromMap(data);
    }).toList();
  }

  @override
  Future<void> favouriteSplit(String splitId, String userId) {
    // TODO: implement favouriteSplit
    throw UnimplementedError();
  }

  @override
  Future<SplitModel> getSplitById(String splitId) async {
    final splitRef = await firestore.collection("splits").doc(splitId).get();

    SplitModel split =
        SplitModel.fromMap(splitRef.data() as Map<String, dynamic>);

    return split;
  }
}
