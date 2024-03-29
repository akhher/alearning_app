import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/sign_in_blocs.dart';

class SignInController {
  final BuildContext context;
  const SignInController({required this.context});

  Future<void> handleSignIn(String type) async {
    try {
      if (type == "email") {
        //We can also use
        //BlocProvider.of<SignInBloc>(context).state
        final state = context.read<SignInBloc>().state;
        String emailAddress = state.email;
        String password = state.password;
        if (emailAddress.isEmpty) {
          //
          print("email empty");
        } else {
          print("email is $emailAddress");
        }
        ;
        if (password.isEmpty) {
          //
          print("password empty");
        }
        try {
          final credential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: emailAddress, password: password);
          if (credential.user == null) {
            //
            print("user doesn't exist");
          }
          if (!credential.user!.emailVerified) {
            ///
            print("not varied");
          }
          var user = credential.user;
          if (user != null) {
            print("user exist");
            //we got verified user from firebase
          } else {
            print("no user");
            //error getting user from firebase
          }
        } on FirebaseAuthException catch (e) {
          // >--- error code doesn't show --- <
          if (e.code == 'user-not-found') {
            print('No user found for that email.');
            // toastInfo(msg:"No user found for that email.");
          } else if (e.code == 'wrong-password') {
            print('Wrong password provided for that user.');
            // toastInfo(msg:"Wrong password provided for that user.");
          } else if (e.code == 'invalid-email') {
            print('Your email format is wrong.');
          }
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
