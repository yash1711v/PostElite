import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:post_elite/Presentation/MainScreen.dart';
import 'package:post_elite/Presentation/home_screen.dart';
import 'package:post_elite/SharedPref/Sharedpref.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  TextEditingController firstnameControler = TextEditingController();
  TextEditingController mobilenumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final RegExp _validCharacters = RegExp(r'^[a-zA-Z\s]*$');
  final RegExp _validDigits = RegExp(r'^[0-9]*$');
  String name = "Mr.";
  String errorMessage = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    settingVariables();
    Valuesarethere();
  }

  String errorMessageNumber = '';
  Future<void> settingVariables() async {
    String UserName=await Sharedpref().getUsername();
    String email=await Sharedpref().getEmail();
    String MobileNumber=await Sharedpref().getMobile();
    setState(() {
      firstnameControler.text=UserName;
      mobilenumberController.text=MobileNumber;
      emailController.text=email;
    });

  }
  bool ValuesarethereVar = false;

  Future<void> Valuesarethere() async {
    String UserName=await Sharedpref().getUsername();
    String email=await Sharedpref().getUid();
    String MobileNumber=await Sharedpref().getMobile();
    if(UserName.isNotEmpty && email.isNotEmpty && MobileNumber.isNotEmpty){
       setState(() {
         ValuesarethereVar=true;
       });
    }else{
      setState(() {
        ValuesarethereVar=false;
      });
    }

  }
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
                 Get.to(()=>MainScreen());
               }, icon: Icon(Icons.arrow_back_rounded,
                color: Color(0xFF000000)),
            ),
          ),
          title: const Text(
            'My Profile',
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
              child: SvgPicture.asset("assets/Images/profilepicIcon.svg",
              color: Colors.black,
                width: 20,
                height: 20,
              ),
            ),
          ],
        ),
      ),
      body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Image(image: AssetImage("assets/Images/PersonalPic.png")),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
          child: TextField(
            enabled: true,
            inputFormatters: [
              FilteringTextInputFormatter.allow(_validCharacters),
            ],
            maxLines: 1,
            maxLength: 12,
            onChanged: (value) {
              if (!_validCharacters.hasMatch(value)) {
                String newText = firstnameControler.text.replaceAll(_validCharacters, '');
                firstnameControler.value = firstnameControler.value.copyWith(
                  text: newText,
                  selection: TextSelection.collapsed(offset: newText.length),
                );
              }
              setState(() {
                errorMessage = validateName(value);
              });
              if(errorMessage.isNotEmpty){
                print("Error Message is not empty");

              }else{
                Valuesarethere();
              }
              print("$errorMessage");
            },
            controller: firstnameControler,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 1.0,horizontal: 10),
              counterText: "",
              error: errorMessage != ""
                  ? Row(
                      children: [
                        SvgPicture.asset("assets/Images/alert-circle.svg"),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          errorMessage,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w700,
                            height: 0.12,
                          ),
                        ),
                      ],
                    )
                  : null,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blue,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(30.0),
              ),
              enabled: true,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(30.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: errorMessage.isNotEmpty ? Colors.red : Colors.blue,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(30.0),
              ),
              label: Text(
                'Full Name',
                style: TextStyle(
                  color: Color(0xFF1D2129),
                  fontSize: 14,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w700,
                  height: 0.11,
                ),
              ),
              hintText: 'Enter Your Name',
              hintStyle: TextStyle(
                color: Color(0xFFA1A4B2),
                fontSize: 16,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: TextField(
            maxLength: 10,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                errorMessageNumber = validatePhoneNumber(value);
              });
              validateNameAndPhoneNumber(
                  firstnameControler.text, mobilenumberController.text);
              if(errorMessage.isNotEmpty){
                print("Error Message is not empty");

              }else{
                Valuesarethere();
              }
            },
            controller: mobilenumberController,
            inputFormatters: [
              FilteringTextInputFormatter.allow(_validDigits),
            ],
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 1.0,horizontal: 10),

              counterText: "",
              error: errorMessageNumber != ""
                  ? Row(
                      children: [
                        SvgPicture.asset("assets/Images/alert-circle.svg"),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          errorMessageNumber,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w700,
                            height: 0.12,
                          ),
                        ),
                      ],
                    )
                  : null,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blue,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(30.0),
              ),
              enabled: true,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(30.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color:
                      errorMessageNumber.isNotEmpty ?
                      Colors.red :
                      Colors.blue,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(30.0),
              ),
              label: Text(
                'Mobile Number',
                style: TextStyle(
                  color: Color(0xFF1D2129),
                  fontSize: 14,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w700,
                  height: 0.11,
                ),
              ),
              prefix: Container(
                width: 80,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: Image.asset(
                        "assets/Images/IndianFlag.png",
                        width: 24,
                        height: 24,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "+91",
                      style: TextStyle(
                        color: Color(0xFF1D2129),
                        fontSize: 14,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w700,
                        height: 0.11,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 0.70,
                      height: 14,
                      decoration: BoxDecoration(color: Color(0xFF4E5969)),
                    )
                  ],
                ),
              ),
              hintText: 'Enter your mobile number',
              hintStyle: TextStyle(
                color: Color(0xFFA1A4B2),
                fontSize: 16,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
          child: TextField(
            readOnly: true,
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {},
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 1.0,horizontal: 10),

              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blue,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(30.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(30.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(30.0),
              ),
              label: Text(
                'Email Address',
                style: TextStyle(
                  color: Color(0xFF1D2129),
                  fontSize: 14,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w700,
                  height: 0.11,
                ),
              ),
              hintText: 'abcxyz@gmail.com',
              hintStyle: TextStyle(
                color: Color(0xFFA1A4B2),
                fontSize: 16,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),
          ),
        ),
        Container(
          width: 300,
          height: 45,
          decoration: ShapeDecoration(
            image: DecorationImage(
              image: validateNameAndPhoneNumber(firstnameControler.text, mobilenumberController.text) ? AssetImage('assets/Images/Button.png') : AssetImage("assets/Images/unactivebutton.png"),
              fit: BoxFit.cover,
            ),
            color: Color(0xFFE5E6EB),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: ElevatedButton(
            onPressed: () async {
              Sharedpref().setUsername(firstnameControler.text);
              Sharedpref().setEmail(emailController.text);
              Sharedpref().setMobile(mobilenumberController.text);
              if(ValuesarethereVar){}else{
                try {
                  final response = await dio.post(
                      "https://admin.vcubetechservices.com/api/register",
                      queryParameters: {
                        "email": emailController.text,
                      });

                  print(response);
                  int id=response.data['user']['id'];
                 Sharedpref().setid(id);
                } catch (e) {
                  print(e);
                }
              }
              Get.offAll(()=>MainScreen());
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              padding: EdgeInsets.all(16.0),
            ),
            child: Text(
              ValuesarethereVar?"Edit Profile":'Save Profile',
              style: TextStyle(
                color: validateNameAndPhoneNumber(
                        firstnameControler.text, mobilenumberController.text)
                    ? Colors.white
                    : Color(0xFF86909C),
                fontSize: 16,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w600,
                height: 0.09,
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

String validateName(String value) {
  if (value.length < 3) {
    return 'Please enter a minimum of 3 letters for your name.';
  } else if (value.contains(new RegExp(r'[0-9]'))) {
    return 'Name cannot contain numbers';
  } else if (value.contains(new RegExp(r'[!@#%^&*,.?":{}|<>](?![_])'))) {
    return 'Name cannot contain special characters';
  }
  return '';
}

String validatePhoneNumber(String value) {
  if (value.length != 10) {
    return 'Please enter the 10 digits of your mobile number';
  } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
    return 'Mobile number must contain only numbers';
  }
  return '';
}

bool validateNameAndPhoneNumber(String name, String phoneNumber) {
  // Validate name
  String err = validateName(name);
  String err1 = validatePhoneNumber(phoneNumber);
  print(err);
  print(err1);
  if (err.isNotEmpty || err1.isNotEmpty) {
    return false;
  }

  // If both name and phone number pass all conditions, return true
  return true;
}
