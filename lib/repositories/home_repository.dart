import 'package:eco_focus/models/sign_in/sign_in_models.dart';

abstract class HomeRepository {
  Future<UserDetails> getUserDetails(UserDetailsReqBody reqBody);
}
