import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Método para obtener el rol del usuario autenticado
  Future<String> getUserRole() async {
    try {
      // Obtener el usuario autenticado
      User? user = _auth.currentUser;

      if (user != null) {
        // Obtener el documento del usuario desde Firestore
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        // Retornar el rol del usuario
        return userDoc['role']; // 'admin' o 'cliente'
      } else {
        throw Exception('No user is logged in');
      }
    } catch (e) {
      throw Exception('Error: ${e.toString()}');
    }
  }

  // Login del usuario
  Future<void> login(String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Obtener el rol del usuario desde Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user?.uid)
          .get();

      String role = userDoc['role'];  // 'admin' o 'cliente'

      // Redirigir según el rol
      if (role == 'admin') {
        Navigator.pushReplacementNamed(context, '/adminHome');
      } else {
        Navigator.pushReplacementNamed(context, '/clientHome');
      }
    } catch (e) {
      throw Exception('Error: ${e.toString()}');
    }
  }

  // Registro de nuevo usuario
  Future<void> register(String email, String password, String role) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Guardar el rol del usuario en Firestore
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user?.uid).set({
        'email': email,
        'role': role, // 'admin' o 'cliente'
      });
    } catch (e) {
      throw Exception('Error: ${e.toString()}');
    }
  }

  // Cerrar sesión
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
