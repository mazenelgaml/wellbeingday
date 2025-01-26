
import '../errors/exceptions.dart';
import '../models/sign_up_model.dart';
import 'api_consumer.dart';
import 'either.dart';
import 'end_points.dart';



class UserRepository {
  final ApiConsumer api;


  UserRepository({required this.api});


  Future<Either<String, SignUpModel>> signUp({
    required String firstname,
    required String lastname,
    required String email,
    required String password,
    // required String confirmPassword,
    required String phone,
    required String nationality,
    required String homeAddress,
    required String workAddress,
    required String filePath,





  }) async {
    try {
      final response = await api.post(
        EndPoint.signUp,
        data: {

          ApiKey.firstName: firstname,
          ApiKey.lastName: lastname,
          ApiKey.email: email,
          ApiKey.password: password,
          ApiKey.phone: phone,
          ApiKey.nationality: nationality,
          ApiKey.homeAddress: homeAddress,
          ApiKey.workAddress: workAddress,
          ApiKey.files: filePath

        },

      );


      final signUpModel = SignUpModel.fromJson(response);
      return Right(signUpModel);
    } on ServerException catch (e) {
      return Left(e.errModel.data);
    }
  }



}