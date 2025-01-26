// import 'package:dio/dio.dart';
// import 'package:doctor/core/strings.dart';
// import 'dart:developer';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../api/end_points.dart';
// import '../../errors/exceptions.dart';
// import '../../models/doctor.dart';
// import 'doctor_sign_up_state.dart';
// import 'package:http_parser/http_parser.dart';

// class SignUpSpecialistCubit extends Cubit<SignUpSpecialistState> {
//   SignUpSpecialistCubit() : super(SignUpSpecialistInitial());

//   Future<void> signUp(Doctor doctor) async {
//     log("Sign-up is loading...");
//     emit(SignUpSpecialistLoading(message: SpSignUpLoadingMsg));

//     try {
//       final dio = Dio(
//         BaseOptions(
//           baseUrl: EndPoint.baseUrl,
//           validateStatus: (status) => status != null && status < 500,
//         ),
//       );

//       // Prepare form data
//       FormData formData = FormData.fromMap({
//         'firstName': doctor.firstName,
//         'lastName': doctor.lastName,
//         'email': doctor.email,
//         'phone': doctor.phone,
//         'password': doctor.password,
//         'nationality': doctor.nationality,
//         'work': doctor.work,
//         'yearsExperience': doctor.yearOfExperience.toString(),
//         'workAddress': doctor.workAddress,
//         'homeAddress': doctor.homeAddress,
//         'bio': doctor.bio,
//         'sessionPrice': doctor.sessionPrice,
//         'sessionDuration': doctor.sessionDuration,
//         'specialties': doctor.specialties,
//         if (doctor.idOrPassport != null)
//           'idOrPassport': await MultipartFile.fromFile(
//             doctor.idOrPassport!.path!,
//             contentType: MediaType('application', 'pdf'),
//           ),
//         if (doctor.resume != null)
//           'resume': await MultipartFile.fromFile(
//             doctor.resume!.path!,
//             contentType: MediaType('application', 'pdf'),
//           ),
//         if (doctor.certificates != null)
//           'certificates': await MultipartFile.fromFile(
//             doctor.certificates!.path!,
//             contentType: MediaType('application', 'pdf'),
//           ),
//         if (doctor.ministryLicense != null)
//           'ministryLicense': await MultipartFile.fromFile(
//             doctor.ministryLicense!.path!,
//             contentType: MediaType('application', 'pdf'),
//           ),
//         if (doctor.associationMembership != null)
//           'associationMembership': await MultipartFile.fromFile(
//             doctor.associationMembership!.path!,
//             contentType: MediaType('application', 'pdf'),
//           ),
//       });

//       Response response = await dio.post(
//         EndPoint.signUpSpecialist,
//         data: formData,
//         options: Options(
//           headers: {
//             "Content-Type": "multipart/form-data",
//           },
//         ),
//         onSendProgress: (int sent, int total) {
//           log("Progress: $sent / $total");
//         },
//       );

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         log("Success: ${response.data}");
//         emit(SignUpSpecialistSuccess(message: SpSignUpSuccessMsg));
//       } else {
//         emit(SignUpSpecialistFailure(
//           errMessage:
//               SpSignUpErrorMsg + " " + handleFailureResponse(response.data),
//         ));
//         log("Failure: ${response.statusCode} - ${response.data}");
//       }
//     } on ServerException catch (e) {
//       emit(SignUpSpecialistFailure(errMessage: e.errModel.data));
//     }
//   }
// }

// String handleFailureResponse(Map<String, dynamic> errorResponse) {
//   if (errorResponse.containsKey('errors') &&
//       errorResponse['errors'].isNotEmpty) {
//     String errorMessage = errorResponse['errors'][0]['msg'];
//     return "$errorMessage";
//   }
//   return "";
// }
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor/models/Specialist.dart';
import 'package:doctor/core/strings.dart';
import 'package:doctor/errors/exceptions.dart';
import '../../api/end_points.dart';
import '../../screens/specialist/repo/SpecialistRepository.dart';
import 'doctor_sign_up_state.dart';
import 'dart:developer';

class SignUpSpecialistCubit extends Cubit<SignUpSpecialistState> {
  final SpecialistRepository specialistRepository = SpecialistRepository(
    dio: Dio(
      BaseOptions(
        baseUrl: EndPoint.baseUrl,
        validateStatus: (status) => status != null && status < 500,
      ),
    ),
  );

  SignUpSpecialistCubit() : super(SignUpSpecialistInitial());

  Future<void> signUp(Specialist doctor) async {
    emit(SignUpSpecialistLoading(message: SpSignUpLoadingMsg));
    log("Sign-up is loading...");

    try {
      // Call the sign-up function from the repository
      Response response = await specialistRepository.signUpSpecialist(doctor);

      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.statusMessage!);
        emit(SignUpSpecialistSuccess(message: SpSignUpSuccessMsg));
      } else {
        emit(SignUpSpecialistFailure(
            errMessage:
                SpSignUpErrorMsg + " " + handleFailureResponse(response.data)));
        log("Failure: ${response.statusCode} - ${response.data}");
      }
    } on ServerException catch (e) {
      emit(SignUpSpecialistFailure(errMessage: e.errModel.message!));
    }
  }
}

String handleFailureResponse(Map<String, dynamic> errorResponse) {
  if (errorResponse.containsKey('errors') &&
      errorResponse['errors'].isNotEmpty) {
    String errorMessage = errorResponse['errors'][0]['msg'];
    return "$errorMessage";
  }
  return "";
}
