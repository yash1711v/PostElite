import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  List<String> Headings=[
    "About Us",
    "Disclaimer",
    "Privacy Policy",
    "Terms and Conditions",
    "Cancellation & Refund Policy",
    "Contact Us"
  ];
  List<String> Texts=[
    "Welcome to PostElite, brought to you by V Cube Tech Services! We are dedicated to providing reliable financial calculation services to our users. Our application aims to simplify financial planning by offering accurate calculations for Government Scheme Sukanya Samriddhi Yojana accounts.\nWith our user-friendly interface and precise calculations, we strive to empower users to make informed decisions about their financial investments.",
    "The information provided by PostElite is intended for general informational purposes only. While we strive to maintain the information as current and accurate, we do not make any representations or warranties, express or implied, regarding the completeness, accuracy, reliability, suitability, or availability of the application or the information, products, services, or related graphics contained within it.\n Any reliance you place on such information is strictly at your own risk.\nWe shall not be liable for any loss or damage, including but not limited to indirect or consequential loss or damage, or any loss or damage whatsoever arising from the loss of data or profits resulting from the use of this application, whether in connection with or arising out of the use of this application.",
    "PostElite is dedicated to safeguarding your privacy. We gather and retain personal data like names, mobile numbers, and email IDs to efficiently deliver our services. Rest assured, we do not disclose this information to external parties except when legally obligated. Your data is securely stored and utilized exclusively for furnishing financial calculation services via our application.",
    "By using the PostElite application, you agree to the following terms and conditions:\n\n1) The services provided by PostElite are for personal use only and may not be used for commercial purposes without prior authorization.\n\n2) Users must provide accurate and up-to-date information to ensure the accuracy of the calculations.\n\n3) PostElite reserves the right to modify or discontinue any feature or service provided by the application without prior notice",
    "Since PostElite is a paid application, all purchases are final and non-refundable. Once a user has subscribed to the premium features of the application, no cancellations or refunds will be provided. However, users can choose not to renew their subscription at the end of the subscription period.\nPlease note that by using PostElite, you acknowledge and agree to abide by the terms and conditions outlined above. ",
    "If you have any questions or concerns regarding our policies, please contact us at\nadmin@vcubetechservices.in "
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(40,60),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 2,
          leading: Center(
            child: IconButton(
              onPressed: () {
                Get.back();
              }, icon: Icon(Icons.arrow_back_rounded,
                color: Color(0xFF000000)),
            ),
          ),
          title: const Text(
            'About',
            style: TextStyle(
              color: Color(0xFF1D2129),
              fontSize: 18,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.bold,
              height: 0.07,
            ),
          ),
          centerTitle: false,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: SvgPicture.asset("assets/Images/Infoicon.svg",
                color: Colors.black,
                width: 20,
                height: 20,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
             child: ListView.builder(
               physics: NeverScrollableScrollPhysics(),
                itemCount: Headings.length,
                 shrinkWrap: true,
                 itemBuilder: (context,index){
                   return Card(
                     shadowColor: Colors.transparent,
                     elevation: 0,
                     child: ExpansionTile(
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(10.0), // Rounded corners for the card
                       ),
                       collapsedShape:  RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(30.0), // Rounded corners for the card
                       ),
                       backgroundColor: Color(0xFF114BA3),
                       expandedAlignment: Alignment.centerLeft,
                       collapsedBackgroundColor: Color(0xFF114BA3),
                       collapsedIconColor: Colors.white,
                       iconColor: Colors.white,
                       initiallyExpanded: false,
                       title: Text(Headings[index],
                         style: TextStyle(
                           color: Colors.white,
                           fontSize: 14,
                           fontFamily: 'Nunito',
                           fontWeight: FontWeight.w700,
                           height: 0.11,
                         ),
                       ),
                       children: [
                         Padding(
                           padding: const EdgeInsets.only(left:1.0,right: 1.0,bottom:
                           1.0),
                           child: Container(
                             decoration: ShapeDecoration(
                               color: Colors.white,
                               shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.only(
                                   topLeft: Radius.circular(0),
                                   topRight: Radius.circular(0),
                                   bottomRight: Radius.circular(10),
                                   bottomLeft: Radius.circular(10)
                                 ), // Rounded corners for the card
                               ),
                             ),
                             width: MediaQuery.of(context).size.width,
                             child: Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Text(

                                   Texts[index],
                                 textAlign: TextAlign.left,
                                 style: TextStyle(
                                       color: Colors.black,
                                       fontSize: 14,
                                       fontFamily: 'Roboto',
                                       fontWeight: FontWeight.w400,
                                       height: 0,
                                       letterSpacing: 0.42,
                                     )

                               ),
                             ),
                           ),
                         ),
                       ],
                     ),
                   );
                 }
             ),
           )
          ],
        ),
      ),
    );
  }
}
