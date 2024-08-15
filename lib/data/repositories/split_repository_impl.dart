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
  Future<bool> favouriteSplit(FavouriteModel favSplit) async {
    //final expenseRef = firestore.collection('expenses').doc(expense.id);

    // Check if there is an exisiting favourite for this user
    final existingFav = await firestore
        .collection("favourites")
        .where('userId', isEqualTo: favSplit.userId)
        .get();

    String existingFavId = "";

    // If there is a favourite already, then delete it
    if (existingFav.docs.isNotEmpty) {
      for (var doc in existingFav.docs) {
        existingFavId = doc["splitId"];
        await firestore.collection('favourites').doc(doc.id).delete();
      }
    }

    // If the existing fav is equal to the favSplitId then it means the user
    //is unfavouriting it so no need to add to the collection
    if (existingFavId != favSplit.splitId) {
      // Create a reference for the new favourite split
      final favRef = firestore.collection('favourites').doc();
      final newFavSplit = favSplit.copyWith(
          id: favRef.id, userId: favSplit.userId, splitId: favSplit.splitId);

      await favRef.set(newFavSplit.toMap());
      return true;
    }

    return false;
  }

  @override
  Future<SplitModel> getSplitById(String splitId) async {
    final splitRef = await firestore.collection("splits").doc(splitId).get();

    SplitModel split =
        SplitModel.fromMap(splitRef.data() as Map<String, dynamic>);

    return split;
  }

  @override
  Future<bool> checkFavouriteStatus(String splitId, String userId) async {
    final existingFav = await firestore
        .collection("favourites")
        .where('userId', isEqualTo: userId)
        .where('splitId', isEqualTo: splitId)
        .get();

    if (existingFav.docs.isEmpty) {
      return false;
    }

    return true;
  }

  @override
  Future<void> deleteSplit(String splitId) async {
    try {
      // Query expenses associated with the splitId
      final expenseRef = await firestore
          .collection("expenses")
          .where('splitId', isEqualTo: splitId)
          .get();

      //  Delete each expense document if it exists.
      if (expenseRef.docs.isNotEmpty) {
        for (var doc in expenseRef.docs) {
          await doc.reference.delete();
        }
      }

      // Delete the split document
      final splitRef = firestore.collection('splits').doc(splitId);
      await splitRef.delete();
    } catch (e) {
      throw Exception('Failed to update split: $e');
    }
  }

  @override
  Future<void> editSplit(SplitModel split) async {
    try {
      final splitRef = await firestore
          .collection('splits')
          .where('id', isEqualTo: split.id)
          .get();

      if (splitRef.docs.isNotEmpty) {
        final doc = splitRef.docs.first;
        await doc.reference.update(split.toMap());
      } else {
        throw Exception('Split not found');
      }
    } catch (e) {
      throw Exception('Failed to update split: $e');
    }
  }

  @override
  Future<SplitModel?> getFavourited() async {
    try {
      final user = auth.currentUser;
      if (user == null) throw Exception('User not authenticated');

      final favSnapshot = await firestore
          .collection('favourites')
          .where('userId', isEqualTo: user.uid)
          .get();

      SplitModel? favSplit;
      if (favSnapshot.docs.isEmpty) {
        return null;
      }

      for (var fav in favSnapshot.docs) {
        favSplit = await getSplitById(fav.get("splitId"));
      }

      return favSplit;
    } catch (e) {
      throw Exception('Failed to update split: $e');
    }
  }
}
