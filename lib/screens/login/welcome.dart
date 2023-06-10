import 'package:app_cooky/providers/user_provider.dart';

import 'package:app_cooky/screens/loadcreens.dart';
import 'package:app_cooky/utils/mycolors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

final fi = FirebaseFirestore.instance;
final userfr = fi.collection('users');

class Sign_In extends StatefulWidget {
  @override
  State<Sign_In> createState() => _Sign_InState();
}

class _Sign_InState extends State<Sign_In> {
  //---------
  late UserProvider userProvider;

  // Future<User?> _googleSignUp() async {
  //   try {
  //     final GoogleSignIn _googleSignIn = GoogleSignIn(
  //       scopes: ['email'],
  //     );
  //     final FirebaseAuth _auth = FirebaseAuth.instance;

  //     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
  //     final GoogleSignInAuthentication googleAuth =
  //         await googleUser!.authentication;

  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );

  //     final User? user = (await _auth.signInWithCredential(credential)).user;
  //     // print("signed in " + user.displayName);
  //     userProvider.addUserData(
  //       currentUser: user,
  //       userEmail: user!.email,
  //       userImage: user.photoURL,
  //       userName: user.displayName,
  //     );

  //     return user;
  //   } catch (e) {}
  // }
  //----
  Future<void> siginInWithGoogle() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    final GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        final _gAuthentication = await account.authentication;
        final _credential = GoogleAuthProvider.credential(
            idToken: _gAuthentication.idToken,
            accessToken: _gAuthentication.accessToken);
        await _auth.signInWithCredential(_credential);
        final User userdetail =
            (await _auth.signInWithCredential(_credential)).user!;
        userProvider.addUserData(
          currentUser: userdetail,
          userEmail: userdetail.email,
          userImage: userdetail.photoURL,
          userName: userdetail.displayName,
        );

        // await saveAccout(account);
      }
    } on Exception catch (error) {
    
    }
  }

  Future<void> saveAccout(GoogleSignInAccount account) async {
    FirebaseFirestore.instance.collection("users").doc(account.email).set({
      "email": account.email,
      "name": account.displayName,
      "profilepic": account.photoUrl
    });
  }
  //--------

//----
  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/background3.jpg',
                ),
                fit: BoxFit.fill)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 400,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Đăng nhập để tiếp tục!'),
                  Text(
                    'Cooky',
                    style:
                        TextStyle(fontSize: 50, color: Colors.white, shadows: [
                      BoxShadow(
                        blurRadius: 5,
                        color: Color_text,
                        offset: Offset(3, 3),
                      )
                    ]),
                  ),
                  //button gg
                  SignInButton(
                    Buttons.Google,
                    text: "Đăng nhập bằng Google",
                    onPressed: () async {
                      await siginInWithGoogle().then(
                        (value) => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => LoadScreen(),
                          ),
                        ),
                      );
                    },
                  ),
                  SignInButton(
                    Buttons.Apple,
                    text: "Đăng nhập bằng Apple",
                    onPressed: () async {},
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
