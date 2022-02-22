import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final CollectionReference productsRef =
      FirebaseFirestore.instance.collection('Products');

  final CollectionReference usersRef =
      FirebaseFirestore.instance.collection('Users');

  String getUserID() {
    return _firebaseAuth.currentUser!.uid;
  }

  Future<String> userLogin(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'login-success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }

      return e.message.toString();
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> userRegistration(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'registration-success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }

      return e.message.toString();
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> addToCart(
    String productID,
    String size,
  ) async {
    try {
      await usersRef
          .doc(getUserID())
          .collection('Cart')
          .doc(productID)
          .set({'size': size});

      return 'Product added to the cart.';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> addToSaved(String productID, String size) async {
    try {
      await usersRef
          .doc(getUserID())
          .collection('Saved')
          .doc(productID)
          .set({'size': size});

      return 'Product saved.';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> removeFromCart(String id) async {
    try {
      await usersRef.doc(getUserID()).collection('Cart').doc(id).delete();

      return 'Product removed from the cart.';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> removeFromSaved(String id) async {
    try {
      await usersRef.doc(getUserID()).collection('Saved').doc(id).delete();

      return 'Product removed.';
    } catch (e) {
      return e.toString();
    }
  }

  Future getCartProductIDs() async {
    /*   List<String> productIDs = List.empty(growable: true);
    
        .forEach((document) {
      for (var el in document.docs) {
        productIDs.add(el.id);
      }
    }); */

    return usersRef.doc(getUserID()).collection('Cart').snapshots();
  }
}
