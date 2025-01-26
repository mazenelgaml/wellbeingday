import 'package:flutter/material.dart';
import 'package:get/get.dart';

// A stateless widget representing a card for displaying doctor information
class DoctorCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.9, // Setting the width of the card to 90% of screen width
      height: 297, // Setting the height of the card
      child: Card(
        child: Column(
          children: [
            // Top section of the card, displaying the doctor's image and details
            Container(
              height: 220, // Height of the image container
              color: Color(0xFF19649E), // Background color for the top section
              child: Row(
                children: [
                  // Right side section displaying the doctor's information
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // Align the text to the right
                      children: [
                        const Text(
                          'د. محمود محمد', // Doctor's name
                          style: TextStyle(
                            fontWeight: FontWeight.bold, // Bold text
                            fontSize: 20, // Font size
                            color: Colors.white, // Text color is white
                          ),
                          textAlign: TextAlign.left, // Align the text to the left
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'طبيب مهتم بالوقاية النفسية', // Doctor's specialty
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16, // Font size
                          ),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(height: 10),
                        buildInfoRow("assets/images/heart.png", 'النوع: وقاية نفسية'), // Call method to display type info
                        const SizedBox(height: 4),
                        buildInfoRow("assets/images/PhoneCall.png", 'متاح جلسات صوتية، فيديو'), // Call method to display availability info
                        const SizedBox(height: 4),
                        buildInfoRow("assets/images/experience.png", 'خبرة 7 سنوات'), // Call method to display experience info
                        const SizedBox(height: 4),
                        buildInfoRow("assets/images/translation.png", 'اللغة: العربية، الإنجليزية'), // Call method to display language info
                      ],
                    ),
                  ),
                  // Image Container with 3D effect and zoom
                  Flexible(
                    child: Container(
                      height: 220, // Height for the image
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8), // Rounded corners for the image
                      ),
                      child: Transform.translate(
                        offset: Offset(-22, -12), // Move the image upwards by 14 units
                        child: Transform.scale(
                          scale: 1.11, // Scale the image to give a zoom effect
                          child: Image.asset(width: 130,height: 100,'assets/images/doctor.png', fit: BoxFit.fill), // Displaying the image
                        ),
                      ),
                    ),
                  ),



                ],
              ),
            ),
            // Bottom section displaying the doctor's availability and price
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                buildDetailColumn("assets/images/time.png", 'أقرب إتاحة', '04 يونيو - 7:00 مساءً'), // Call method to display availability time
                buildDetailColumn("assets/images/price.png", 'السعر', '300 ليرة / 30 دقيقة'), // Call method to display price
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Method to build each info row (e.g., type, availability, etc.)
  Widget buildInfoRow(String icon, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start, // Align the row to the right
      crossAxisAlignment: CrossAxisAlignment.end, // Align the row elements to the bottom
      children: [
        Container(
          width: 21.19,
          height: 19,
          child: Image.asset(
            icon, // Icon for the row
            fit: BoxFit.fill, // Fill the container with the image
            width: 21.19,
            height: 19,
            color: Colors.white, // Icon color is white
          ),
        ),

        const SizedBox(width: 8), // Space between the text and the icon
        Text(
          text,
          style: TextStyle(fontSize: 16, color: Colors.white), // Styling the text
          textAlign: TextAlign.right, // Align text to the right
        ),
      ],
    );
  }

  // Method to build the detail columns (e.g., availability time and price)
  Widget buildDetailColumn(String icon, String title, String value) {
    return Container(
      width: Get.width * 0.8, // Setting width of the detail container to 80% of the screen width
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end, // Align the row to the bottom
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between the elements
        children: [
          Row(
            children: [

              Container(
                width: 19,
                height: 19,
                child: Image.asset(icon, fit: BoxFit.fill), // Displaying the icon
              ),
              const SizedBox(width: 8), // Space between the title and the icon
              Text(
                title,
                style: TextStyle(color: Colors.black, fontSize: 14), // Styling the title text
              ),
            ],
          ),

          const SizedBox(width: 4), // Space between the text and the icon
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black), // Styling the value text
          ),
        ],
      ),
    );
  }
}
