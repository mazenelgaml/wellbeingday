import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../models/user_profile_model.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final UserProfileModel userProfile;
  final double screenWidth;
  final double screenHeight;

  const CustomAppBar({
    Key? key,
    required this.userProfile,
    required this.screenWidth,
    required this.screenHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(40),
        bottomRight: Radius.circular(40),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.lightBlue[100], // Background color of the app bar
        ),
        child: AppBar(
          backgroundColor: Colors.transparent, // Set to transparent to allow the custom color to show
          elevation: 0, // Remove the shadow of the AppBar
          automaticallyImplyLeading: false, // Prevents the default leading icon (back button)
          flexibleSpace: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left side (profile image and greeting text)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 66,
                      height: 66,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: userProfile.imageUrl == "" || userProfile.imageUrl == null
                            ? Image.asset("assets/images/profile.jpg", fit: BoxFit.fill)
                            : Image.network(userProfile.imageUrl ?? "", fit: BoxFit.fill),
                      ),
                    ),
                    const SizedBox(width: 28),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        "greeting".tr() + " " + "${userProfile.firstName}",
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xff19649E),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                // Right side (image and action icons)
                Padding(
                  padding: EdgeInsets.only(bottom: screenHeight * 0.02),
                  child: SizedBox(
                    height: screenHeight * 0.17,
                    width: screenWidth * 0.35,
                    child: Image.asset('assets/images/img.png', fit: BoxFit.fill),
                  ),
                ),

                // Middle column (social media and phone icons)
                SizedBox(
                  width: screenWidth * 0.25,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: screenHeight * 0.09, bottom: screenHeight * 0.03),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: SizedBox(
                                width: 27.66,
                                height: 25.33,
                                child: Image.asset("assets/images/phone.png", fit: BoxFit.fill),
                              ),
                            ),
                            const SizedBox(width: 20),
                            GestureDetector(
                              onTap: () {},
                              child: SizedBox(
                                width: 27.66,
                                height: 25.33,
                                child: Image.asset("assets/images/notification.png", fit: BoxFit.fill),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: screenHeight * 0.005),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: screenWidth * 0.04, bottom: screenHeight * 0.005),
                              child: const Text(
                                "تواصل معنا",
                                style: TextStyle(
                                  color: Color(0xff19649E),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: SizedBox(
                                    width: 27.66,
                                    height: 25.33,
                                    child: Image.asset("assets/images/fa-brands_twitter-square.png", fit: BoxFit.fill),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                GestureDetector(
                                  onTap: () {},
                                  child: SizedBox(
                                    width: 27.66,
                                    height: 25.33,
                                    child: Image.asset("assets/images/uil_facebook.png", fit: BoxFit.fill),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                GestureDetector(
                                  onTap: () {},
                                  child: SizedBox(
                                    width: 27.66,
                                    height: 25.33,
                                    child: Image.asset("assets/images/ri_instagram-fill.png", fit: BoxFit.fill),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(screenHeight * 0.21);
}
