import 'package:dio/dio.dart';
import 'package:doctor/screens/specialist/repo/SpecialistRepository.dart';
import 'package:doctor/screens/specialist/sign_up_specialist_spcalize_screen.dart.dart';
import 'package:doctor/widgets/custom_text_field_for_sign_up.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/dio_consumer.dart';
import '../../api/user_repository.dart';
import '../../core/validators.dart';
import '../../cubit/doctor_sign_up_cubit/doctor_sign_up_cubit.dart';
import '../../models/Specialist.dart';
import '../../widgets/custom_snake_bar.dart';
import '../../widgets/custom_upload_file.dart';

class SignUpAsDoctorFirstScreen extends StatefulWidget {
  const SignUpAsDoctorFirstScreen({super.key});

  @override
  State<SignUpAsDoctorFirstScreen> createState() =>
      _SignUpAsDoctorFirstScreenState();
}

class _SignUpAsDoctorFirstScreenState extends State<SignUpAsDoctorFirstScreen> {
  bool isSubmitted = false;

  GlobalKey<FormState> signUpFormKey = GlobalKey();
  late PlatformFile cvFile;
  late PlatformFile idOrPassport;
  late PlatformFile certificates;
  late PlatformFile ministryLicense;
  late PlatformFile associationMembership;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  TextEditingController homeAddressController = TextEditingController();
  TextEditingController workAddressController = TextEditingController();
  TextEditingController workController = TextEditingController();
  TextEditingController about_doctor_Controller = TextEditingController();
  TextEditingController exp_year_Controller = TextEditingController();
  TextEditingController session_time_Controller = TextEditingController();
  TextEditingController session_price_Controller = TextEditingController();

  final TextEditingController resumeController = TextEditingController();
  final TextEditingController idOrPassportController = TextEditingController();
  final TextEditingController certificatesController = TextEditingController();
  final TextEditingController licenseController = TextEditingController();
  final TextEditingController associationMembershipController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpSpecialistCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 35,
          backgroundColor: Colors.white,
        ),
        body: Form(
          key: signUpFormKey,
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      "headerAsSpecialist".tr(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  CustomTextField(
                    label: "firstName".tr(),
                    controller: firstNameController,
                    validator: (value) =>
                        isSubmitted ? validateName(value, "firstName".tr()) : null,
                  ),
                  CustomTextField(
                    label: "lastName".tr(),
                    controller: lastNameController,
                    validator: (value) =>
                        isSubmitted ? validateName(value, "lastName".tr(),) : null,
                  ),


                  CustomTextField(
                    label: "email".tr(),
                    controller: emailController,
                    validator: (value) => isSubmitted ? validateEmail(value, "email".tr(),) : null,
                    suffixIcon: Icons.mail,
                  ),
                  CustomTextField(
                    label: "password".tr(),
                    controller: passwordController,
                    validator: (value) => isSubmitted ? validatePassword(value, "password".tr()) : null,
                    suffixIcon: Icons.remove_red_eye,
                  ),
                  CustomTextField(
                    label: "confirmPassword".tr(),
                    controller: confirmPasswordController,
                    validator: isSubmitted
                        ? (value) => validateConfirmPassword(
                            value, passwordController.text)
                        : null,
                    suffixIcon: Icons.remove_red_eye,
                  ),
                  CustomTextField(
                    keyboardType: TextInputType.number,
                    label: "phoneNumber".tr(),
                    controller: phoneController,
                    validator: (value) => isSubmitted ? validatePhone(value, "phoneNumber".tr()) : null,
                    suffixIcon: Icons.phone_android,
                  ),
                  CustomTextField(
                    label: "nationality".tr(),
                    controller: nationalityController,
                    validator: (value) => isSubmitted ? validateNationality(value, "nationality".tr()) : null,
                    suffixIcon: Icons.person,
                  ),
                  CustomTextField(
                    label: "homeAddress".tr(),
                    controller: homeAddressController,
                    validator: isSubmitted
                        ? (value) => validateAddress(value, "homeAddress".tr())
                        : null,
                    suffixIcon: Icons.location_city,
                  ),
                  CustomTextField(
                    label: "profession".tr(),
                    controller: workController,
                    validator: isSubmitted
                        ? (value) => validateName(value, "profession".tr())
                        : null,
                    suffixIcon: Icons.work,
                  ),
                  CustomTextField(
                    label: "professionAddress".tr(),
                    controller: workAddressController,
                    validator: isSubmitted
                        ? (value) => validateAddress(value, "professionAddress".tr())
                        : null,
                    suffixIcon: Icons.location_city,
                  ),
                  CustomTextField(
                    label: "bio".tr(),
                    isMultiline: true,
                    controller: about_doctor_Controller,
                    validator: isSubmitted
                        ? (value) => validateName(value, "bio".tr())
                        : null,
                    suffixIcon: Icons.work_history,
                  ),
                  CustomTextField(
                    keyboardType: TextInputType.number,
                    label: "experience".tr(),
                    controller: exp_year_Controller,
                    validator: (value) => isSubmitted ? validateYearsOfExperience(value, "experience".tr()) : null,
                    suffixIcon: Icons.work_history,
                  ),
                  CustomTextField(
                    keyboardType: TextInputType.number,
                    label: "sessionDuration".tr(),
                    controller: session_time_Controller,
                    validator: isSubmitted
                        ? (value) => validateSessionDetails(value, "sessionDuration".tr())
                        : null,
                    suffixIcon: Icons.timer,
                  ),
                  CustomTextField(
                    keyboardType: TextInputType.number,
                    label: "sessionPrice".tr(),
                    controller: session_price_Controller,
                    validator: isSubmitted
                        ? (value) => validateSessionDetails(value, "sessionPrice".tr())
                        : null,
                    suffixIcon: Icons.price_check_sharp,
                  ),


                  CustomUploadFile(
                    label: "cv".tr(),
                    controller: resumeController,
                    validator: (value) =>
                        validateUpload(value, "cv".tr()),
                    onFilePicked: (PlatformFile? file) {
                      if (file != null) {
                        cvFile = file;
                        // Handle the picked file (e.g., upload it to the server).
                        print("Picked file: ${file.name}");
                        print("File size: ${file.size} bytes");
                      } else {
                        print("File picking canceled.");
                      }
                    },
                  ),
                  CustomUploadFile(
                    label: "passportPhoto".tr(),
                    controller: idOrPassportController,
                    validator: (value) =>
                        validateUpload(value, "passportPhoto".tr()),
                    onFilePicked: (PlatformFile? file) {
                      if (file != null) {
                        idOrPassport = file;
                      } else {
                        print("File picking canceled.");
                      }
                    },
                  ),
                  CustomUploadFile(
                    label: "certificates".tr(),
                    controller: certificatesController,
                    validator: (value) => validateUpload(value, "certificates".tr()),
                    onFilePicked: (PlatformFile? file) {
                      if (file != null) {
                        certificates = file;
                      } else {
                        print("File picking canceled.");
                      }
                    },
                  ),
                  CustomUploadFile(
                    label: "license".tr(),
                    validator: (value) =>
                        validateUpload(value, "license".tr()),
                    controller: licenseController,
                    onFilePicked: (PlatformFile? file) {
                      if (file != null) {
                        ministryLicense = file;
                      } else {
                        print("File picking canceled.");
                      }
                    },
                  ),
                  CustomUploadFile(
                    label: "membership".tr(),
                    validator: (value) =>
                        validateUpload(value, "membership".tr()),
                    controller: associationMembershipController,
                    onFilePicked: (PlatformFile? file) {
                      if (file != null) {
                        associationMembership = file;
                      } else {
                        print("File picking canceled.");
                      }
                    },
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isSubmitted =
                            true; // Set to true when submit button is clicked
                      });

                      if (signUpFormKey.currentState?.validate() ?? false) {
                        Specialist doctor = Specialist.withoutSpeciality(
                          phone: phoneController.text,
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                          email: emailController.text,
                          password: passwordController.text,
                          nationality: nationalityController.text,
                          work: workController.text,
                          workAddress: workAddressController.text,
                          homeAddress: homeAddressController.text,
                          bio: about_doctor_Controller.text,
                          yearOfExperience:
                              int.tryParse(exp_year_Controller.text)!,
                          sessionPrice: session_price_Controller.text,
                          sessionDuration: session_time_Controller.text,
                          idOrPassport: idOrPassport,
                          resume: cvFile,
                          certificates: certificates,
                          ministryLicense: ministryLicense,
                          associationMembership: associationMembership,
                        );

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpAsDoctorThirdScreen(
                              doctor: doctor,
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          customSnackBar(
                            context: context,
                            message: "fieldsValidator".tr(),
                            backgroundColor: Colors.red,
                            icon: Icons.error,
                          ),
                        );
                      }
                    },
                    child: Container(
                      width: 140,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xff19649E),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          "next".tr(),
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
