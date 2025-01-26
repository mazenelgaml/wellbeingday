import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import '../../../api/end_points.dart';
import '../../../errors/error_model.dart';
import '../../../errors/exceptions.dart';
import '../../../models/Specialist.dart';

class SpecialistRepository {
  final Dio dio;

  SpecialistRepository({required this.dio});

  Future<Response> signUpSpecialist(Specialist doctor) async {
    try {
      // Prepare form data
      FormData formData = FormData.fromMap({
        'firstName': doctor.firstName,
        'lastName': doctor.lastName,
        'email': doctor.email,
        'phone': doctor.phone,
        'password': doctor.password,
        'nationality': doctor.nationality,
        'work': doctor.work,
        'yearsExperience': doctor.yearOfExperience.toString(),
        'workAddress': doctor.workAddress,
        'homeAddress': doctor.homeAddress,
        'bio': doctor.bio,
        'sessionPrice': doctor.sessionPrice,
        'sessionDuration': doctor.sessionDuration,
        'specialties': doctor.specialties,
        if (doctor.idOrPassport != null)
          'idOrPassport': await MultipartFile.fromFile(
            doctor.idOrPassport!.path!,
            contentType: MediaType('application', 'pdf'),
          ),
        if (doctor.resume != null)
          'resume': await MultipartFile.fromFile(
            doctor.resume!.path!,
            contentType: MediaType('application', 'pdf'),
          ),
        if (doctor.certificates != null)
          'certificates': await MultipartFile.fromFile(
            doctor.certificates!.path!,
            contentType: MediaType('application', 'pdf'),
          ),
        if (doctor.ministryLicense != null)
          'ministryLicense': await MultipartFile.fromFile(
            doctor.ministryLicense!.path!,
            contentType: MediaType('application', 'pdf'),
          ),
        if (doctor.associationMembership != null)
          'associationMembership': await MultipartFile.fromFile(
            doctor.associationMembership!.path!,
            contentType: MediaType('application', 'pdf'),
          ),
      });

      // Send the request to the API
      final response = await dio.post(
        EndPoint.signUpSpecialist,
        data: formData,
        options: Options(
          headers: {"Content-Type": "multipart/form-data"},
        ),
      );

      return response;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
    throw Exception('Unexpected error occurred (network connection)');
  }
}

void handleDioExceptions(DioException e) {
  if (e.response != null) {
    final responseData = e.response!.data;
    final statusCode = e.response!.statusCode;

    if (statusCode != null) {
      throw ServerException(
        errModel: ResponseModel.fromJson(responseData as Map<String, dynamic>),
      );
    }
  }

  // Handle cases with no response
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.connectionError:
      throw ServerException(
        errModel: ResponseModel(
          code: 'TIMEOUT',
          message:
              'Connection timed out. Please try again later.  افحص الاتصال بالانترنت \n مشكلة في الشبكة',
        ),
      );
    case DioExceptionType.cancel:
      throw ServerException(
        errModel: ResponseModel(
          code: 'CANCELLED',
          message: 'Request was cancelled. تم الغاء الطلب',
        ),
      );
    case DioExceptionType.badResponse:
      throw ServerException(
        errModel: ResponseModel(
          code: 'BAD_RESPONSE',
          message: 'An error occurred while processing the request. حدثت مشكلة',
        ),
      );
    case DioExceptionType.unknown:
      throw ServerException(
        errModel: ResponseModel(
          code: 'UNKNOWN',
          message: 'An unknown error occurred. Please try again. حطأ غير معروف',
        ),
      );
    case DioExceptionType.badCertificate:
      throw ServerException(
        errModel: ResponseModel(
          code: 'BAD_CERTIFICATE',
          message: 'Invalid server certificate.',
        ),
      );
  }
}
