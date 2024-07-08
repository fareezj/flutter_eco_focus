import 'package:eco_focus/models/sign_in/sign_in_models.dart';
import 'package:eco_focus/repositories/home_repository.dart';
import 'package:eco_focus/services/rest/rest_service.dart';

class HomeRepositoryImpl extends HomeRepository {
  final RestService restService;

  HomeRepositoryImpl({required this.restService});

  @override
  Future<UserDetails> getUserDetails(UserDetailsReqBody reqBody) async {
    try {
      var response = await restService.post(
        endpoint:
            'https://dfrzbwjbf6.execute-api.us-west-2.amazonaws.com/dev/main/get-user-details',
        isAuthGuard: false,
        reqBody: reqBody.toJson(),
      );
      return UserDetails.fromJson(response);
    } catch (e) {
      throw Exception(e);
    }
  }
}
