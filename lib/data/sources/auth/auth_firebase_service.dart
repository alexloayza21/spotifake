import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotifake/core/config/constants/app_urls.dart';
import 'package:spotifake/data/models/auth/create_user_req.dart';
import 'package:spotifake/data/models/auth/signin_user_req.dart';
import 'package:spotifake/data/models/auth/user.dart';
import 'package:spotifake/domain/entities/auth/user.dart';

abstract class AuthFirebaseService {

  Future<Either> signIn(SigninUserReq signinUserReq);

  Future<Either> signUp(CreateUserReq createUserReq);
  
  Future<Either> getUser();
  
}

class AuthFirebaseServiceImpl implements AuthFirebaseService {

  @override
  Future<Either> signIn(SigninUserReq signinUserReq) async{
    try {
      
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: signinUserReq.email, 
        password: signinUserReq.password,
      );

      return Right('Sign In Successfully');

    } on FirebaseAuthException catch (e) {

      String message = '';

      if (e.code == 'invalid-email') {
        message = 'The email address is badly formatted.';
      } else if(e.code == 'user-disabled') {
        message = 'The user corresponding to the given email has been disabled.';
      } else if (e.code == 'user-not-found') {
        message = 'No user corresponding to the given email was found.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong Password.';
      } else if (e.code == 'invalid-credential') {
        message = 'Wrong email or password.';
      }else {
        message = e.message!;
      }

      return Left(message);
      
    }  
  }

  @override
  Future<Either> signUp(CreateUserReq createUserReq) async {
    try {
      
      var data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: createUserReq.email, 
        password: createUserReq.password,
      );

      FirebaseFirestore.instance.collection('Users').doc(data.user?.uid)
      .set({
        'name': createUserReq.fullName,
        'email': data.user?.email,
      });

      return Right('Sign Up Successfully');

    } on FirebaseAuthException catch (e) {

      String message = '';

      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      } else if (e.code == 'invalid-email') {
        message = 'The email address is badly formatted.';
      } else {
        message = e.message!;
        
      }

      return Left(message);
      
    }    
  }
  
  @override
  Future<Either> getUser() async{
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      
      var user = await firestore.collection('Users').doc(
        auth.currentUser?.uid
      ).get();

      UserModel userModel = UserModel.fromJson(user.data()!);
      userModel.imgUrl = auth.currentUser?.photoURL ?? AppUrls.defaultImg;
      UserEntity userEntity = userModel.toEntity();
      return Right(userEntity);

    } catch (e) {
      return Left('Error fetching user: ${e.toString()}');
    }
  }
  
}