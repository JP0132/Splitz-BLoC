import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:splitz_bloc/data/models/favourite_model.dart';
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
  Future<void> favouriteSplit(FavouriteModel favSplit) async {
    //final expenseRef = firestore.collection('expenses').doc(expense.id);

    // Check if there is an exisiting favourite for this user
    final existingFav = await firestore
        .collection("favourites")
        .where('userId', isEqualTo: favSplit.userId)
        .get();

    String existingFavId = "";
    if (existingFav.docs.isNotEmpty) {
      for (var doc in existingFav.docs) {
        existingFavId = doc["splitId"];
        await firestore.collection('favourites').doc(doc.id).delete();
      }
    }

    if (existingFavId != favSplit.splitId) {
      // Create a reference for the new favourite split
      final favRef = firestore.collection('favourites').doc();
      final newFavSplit = favSplit.copyWith(
          id: favRef.id, userId: favSplit.userId, splitId: favSplit.splitId);

      await favRef.set(newFavSplit.toMap());
    }
  }

  @override
  Future<SplitModel> getSplitById(String splitId) async {
    final splitRef = await firestore.collection("splits").doc(splitId).get();

    SplitModel split =
        SplitModel.fromMap(splitRef.data() as Map<String, dynamic>);

    return split;
  }
}
