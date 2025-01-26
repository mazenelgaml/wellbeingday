import 'package:easy_localization/easy_localization.dart';

String? validateName(String? value, String fieldName) {
  if (value == null || value.trim().isEmpty) {
    return "generalValidator".tr()+" $fieldName";
  }
  if (value.trim().length < 2) {
    return "$fieldName "+"moreThanTwo".tr();
  }
  return null;
}

String? validateEmail(String? value, String fieldName) {
  final emailRegex =
      RegExp(r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
  if (value == null || value.trim().isEmpty) {
    return "generalValidator".tr()+" $fieldName";
  }
  if (!emailRegex.hasMatch(value.trim())) {
    return "generalValidatorFor".tr()+" $fieldName";
  }
  return null;
}

String? validatePassword(String? value, String fieldName) {
  if (value == null || value.trim().isEmpty) {
    return "generalValidator".tr()+" $fieldName";
  }
  if (value.length < 8) {
    return "passwordLength".tr();
  }
  return null;
}

String? validateConfirmPassword(String? value, String originalPassword) {
  if (value == null || value.trim().isEmpty) {
    return "confirmPasswordValidator".tr();
  }
  if (value != originalPassword) {
    return "matchPassword".tr();
  }
  return null;
}

String? validatePhone(String? value, String fieldName) {
  final phoneRegex = RegExp(r'^[0-9]{10,15}$');
  if (value == null || value.trim().isEmpty) {
    return "generalValidator".tr()+" $fieldName";
  }
  if (!phoneRegex.hasMatch(value.trim())) {
    return "phoneValidator".tr();
  }
  return null;
}

String? validateNationality(String? value, String fieldName) {
  if (value == null || value.trim().isEmpty) {
    return "generalValidator".tr()+" $fieldName";
  }
  return null;
}

String? validateAddress(String? value, String fieldName) {
  if (value == null || value.trim().isEmpty) {
    return "generalValidator".tr()+" $fieldName";
  }
  return null;
}

String? validateYearsOfExperience(String? value, String fieldName) {
  if (value == null || value.trim().isEmpty) {
    return "generalValidator".tr()+" $fieldName";
  }
  if (int.tryParse(value) == null || int.parse(value) < 0) {
    return "generalValidatorFor".tr()+" $fieldName";
  }
  return null;
}

String? validateSessionDetails(String? value, String fieldName) {
  if (value == null || value.trim().isEmpty) {
    return "generalValidator".tr()+" $fieldName";
  }
  if (double.tryParse(value) == null || double.parse(value) <= 0) {
    return "generalValidatorFor".tr()+" $fieldName";
  }
  return null;
}

String? validateUpload(String? value, String fieldName) {
  if (value == null || value.trim().isEmpty) {
    return "uploadValidator".tr()+" $fieldName";
  }
  return null;
}
