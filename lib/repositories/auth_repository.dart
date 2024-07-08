import 'package:eco_focus/models/sign_in/sign_in_models.dart';
import 'package:eco_focus/models/sign_up/sign_up_models.dart';

abstract class AuthRepository {
  Future<SignInResBody> signIn(SignInReqBody reqBody);

  Future<SignUpResBody> signUp(SignUpReqBody reqBody);
}
