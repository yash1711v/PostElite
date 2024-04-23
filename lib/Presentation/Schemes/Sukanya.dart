import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:post_elite/SharedPref/Sharedpref.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';

import '../home_screen.dart';

class Sukanya extends StatefulWidget {
  String currentInterest;
  Sukanya({super.key, required this.currentInterest});

  @override
  State<Sukanya> createState() => _SukanyaState();
}

class _SukanyaState extends State<Sukanya> {
  bool cal = true;
  bool add = false;
  DateTime _selectedDate= DateTime.now();
  DateTime _selectedDateAge= DateTime.now();
  TextEditingController amountController = TextEditingController();
  TextEditingController interestControler = TextEditingController();
  TextEditingController TotalContribution = TextEditingController();
  TextEditingController MaturityAmount = TextEditingController();
  TextEditingController NumberController = TextEditingController();
  TextEditingController GirlChildName = TextEditingController();
  TextEditingController acOpeningDate = TextEditingController(text: DateFormat('dd/MM/yyyy').format(DateTime.now()));
  TextEditingController ageAtAcOpening = TextEditingController();
  TextEditingController DateofBirth = TextEditingController(text: DateFormat('dd/MM/yyyy').format(DateTime.now()));
  TextEditingController currentAge = TextEditingController();
  TextEditingController initalContributionController = TextEditingController();
  String error="";
  String errorForGirlName="";
  int id=0;
  String errorMessageNumber = "";
  bool calculatepressed = false;
  Map<String, dynamic> data = {};
  List<dynamic> Chartdata = [];
  List<Employee> employees = <Employee>[];

  late EmployeeDataSource employeeDataSource;
  int ssa_id=0;

  String formatDateDifference(String inputDate,DateTime frommdifference) {
    // Parsing the input date
    DateTime parsedDate = DateFormat('dd/MM/yyyy').parse(inputDate);



    // Calculate difference
    Duration diff = frommdifference.difference(parsedDate);

    // Breaking down difference into days, months, and years
    int years = diff.inDays ~/ 365;
    int months = (diff.inDays % 365) ~/ 30; // Simplified calculation (approximation)
    int days = diff.inDays - (years * 365 + months * 30);

    // Formatting to "dd/mm/yyyy" format for the output
    return "  ${  years.toString().padLeft(2, '0')} Y ${months.toString().padLeft(2, '0')} M ${days.toString().padLeft(2, '0')} D ";
  }
  String formatDateDifferenceforaccounage(String inputDate,DateTime frommdifference) {
    // Parsing the input date
    DateTime parsedDate = DateFormat('dd/MM/yyyy').parse(inputDate);



    // Calculate difference
    Duration diff = parsedDate.difference(frommdifference);

    // Breaking down difference into days, months, and years
    int years = diff.inDays ~/ 365;
    int months = (diff.inDays % 365) ~/ 30; // Simplified calculation (approximation)
    int days = diff.inDays - (years * 365 + months * 30);

    // Formatting to "dd/mm/yyyy" format for the output
    return "  ${  years.toString().padLeft(2, '0')} Y ${months.toString().padLeft(2, '0')} M ${days.toString().padLeft(2, '0')} D ";
  }
  String formatDateDifferenceforapi(String inputDate) {
    // Parsing the input date
    DateTime parsedDate = DateFormat('dd/MM/yyyy').parse(inputDate);

    // Getting today's date
    DateTime today = DateTime.now();

    // Calculate difference
    Duration diff = today.difference(parsedDate);

    // Breaking down difference into days, months, and years
    int years = diff.inDays ~/ 365;
    int months = (diff.inDays % 365) ~/ 30; // Simplified calculation (approximation)
    int days = diff.inDays - (years * 365 + months * 30);

    // Formatting to "dd/mm/yyyy" format for the output
    return "${years.toString().padLeft(2, '0')}";
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    interestControler.text = '${widget.currentInterest}%';

    // employees= getEmployees();
    ageAtAcOpening.text=formatDateDifferenceforaccounage(DateFormat('dd/MM/yyyy').format(DateTime.now()),_selectedDateAge);
    currentAge.text=formatDateDifference(DateFormat('dd/MM/yyyy').format(DateTime.now()),DateTime.now());
    employeeDataSource = EmployeeDataSource(employees: employees);
    getid();

  }
  getid() async {
    int idd=await Sharedpref().getid();
    print("id -----> $idd");
    setState(() {
      id=idd;
    });
  }

  Future<void> _selectDate(BuildContext context,DateTime Acopeningdate) async {
    await showDialog(context: context, builder: (BuildContext context) {
      return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Container(
            width: 700,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),),
            child:
            Column(
              children: [

                Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: Text("Enter DOB",
                  style: TextStyle(
                    color: Color(0xFF1D2129),
                    fontSize: 16,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w700,
                    height: 0.08,

                  ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Container(
                    width:  350,
                    height: 200,
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      minimumDate: adjustAccountOpeningDate(Acopeningdate),
                      initialDateTime: _selectedDate,
                      maximumDate: Acopeningdate,
                      onDateTimeChanged: (DateTime picked1) {
                        _selectedDate = picked1; // Update temporary variable
                        DateofBirth.text = DateFormat('dd/MM/yyyy').format(_selectedDate);
                        setState(() {
                          currentAge.text=formatDateDifference(DateofBirth.text,DateTime.now());
                          ageAtAcOpening.text= formatDateDifferenceforaccounage(acOpeningDate.text,_selectedDate);
                        });

                        },
                    ),
                  ),
                ),

                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      elevation: 0,
                      shadowColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: EdgeInsets.all(16.0),
                    ),
                    onPressed: (){
                  Navigator.pop(context);
                }, child: Text("OK",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w700,
                    height: 0.08,

                  ),)
                )
              ],
            ),
          )
      ); });
  }
  DateTime adjustAccountOpeningDate(DateTime accountOpeningDate) {
    // Define the boundary dates
    DateTime startDate = DateFormat('dd/MM/yyyy').parse('22/01/2015');
    DateTime endDate = DateFormat('dd/MM/yyyy').parse('02/12/2015');

    // Check the range and subtract years accordingly
    if (accountOpeningDate.isAfter(startDate) && accountOpeningDate.isBefore(endDate)) {
      // If the date is between 22/01/2015 and 02/12/2015 (exclusive), subtract 11 years
      return DateTime(accountOpeningDate.year - 11, accountOpeningDate.month, accountOpeningDate.day);
    } else if (accountOpeningDate.isAtSameMomentAs(endDate) || accountOpeningDate.isAfter(endDate)) {
      // If the date is from 02/12/2015 (inclusive) to current date, subtract 10 years
      return DateTime(accountOpeningDate.year - 10, accountOpeningDate.month, accountOpeningDate.day);
    } else {
      // If the date is before 22/01/2015, no subtraction as per scenario given (though it's not mentioned)
      return accountOpeningDate;
    }
  }
  Future<void> _selectDateAge(BuildContext context) async {
    await showDialog(context: context, builder: (BuildContext context) {
      return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Container(
            width: 700,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),),
            child:Container(
              width: 700,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),),
              child:
              Column(
                children: [

                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: Text("Enter Accout Opening Date",
                      style: TextStyle(
                        color: Color(0xFF1D2129),
                        fontSize: 16,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w700,
                        height: 0.08,

                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      width:  350,
                      height: 200,
                      child:     CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        initialDateTime: _selectedDateAge,
                        maximumDate: DateTime.now(),
                        minimumDate: DateTime(2015, 1, 22),
                        onDateTimeChanged: (DateTime picked1) {
                          _selectedDateAge = picked1; // Update temporary variable
                          acOpeningDate.text = DateFormat('dd/MM/yyyy').format(_selectedDateAge);
                          DateofBirth.text = DateFormat('dd/MM/yyyy').format(_selectedDateAge);

                          setState(() {

                            _selectedDate=picked1;
                            ageAtAcOpening.text= formatDateDifferenceforaccounage(acOpeningDate.text,_selectedDate);
                          });
                        },
                      ),
                    ),
                  ),

                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        elevation: 0,
                        shadowColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        padding: EdgeInsets.all(16.0),
                      ),
                      onPressed: (){
                        Navigator.pop(context);
                      }, child: Text("OK",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w700,
                      height: 0.08,

                    ),)
                  )
                ],
              ),
            )

          )
      ); });
  }

  Future<void> OnTapDataEntry(BuildContext context) async {
    await showDialog(context: context, builder: (BuildContext context) {
      return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Container(
            width: 343,
            height: 300,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              shadows: [
                BoxShadow(
                  color: Color(0x07101828),
                  blurRadius: 8,
                  offset: Offset(0, 8),
                  spreadRadius: -4,
                ),
                BoxShadow(
                  color: Color(0x14101828),
                  blurRadius: 24,
                  offset: Offset(0, 20),
                  spreadRadius: -4,
                )
              ],
            ),
           child: Column(
             children: [
               Row(
                 mainAxisAlignment: MainAxisAlignment.end,
                 children: [
                    IconButton(onPressed: (){
                      Navigator.of(context).pop();
                    }, icon: Icon(Icons.cancel),color: Colors.red,)
                 ],
               ),
               const SizedBox(height: 5),
               SizedBox(
                 width: double.infinity,
                 child: Text(
                   'SSA Account Added Successfully ',
                   textAlign: TextAlign.center,
                   style: TextStyle(
                     color: Color(0xFF1D2129),
                     fontSize: 16,
                     fontFamily: 'Nunito',
                     fontWeight: FontWeight.bold,
                     height: 0.08,
                   ),
                 ),
               ),
                SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                width: double.infinity,
                height: 170,
                padding: const EdgeInsets.all(8),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 0.70, color: Color(0xFF86909C)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                 children: [

                   Container(
                     width: double.infinity,
                     child: Row(
                       mainAxisSize: MainAxisSize.min,
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Expanded(
                           child: Container(
                             height: 20,
                             child: Row(
                               mainAxisSize: MainAxisSize.min,
                               mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Expanded(
                                   child: SizedBox(
                                     child: Text(
                                       'A/c Number',
                                       style: TextStyle(
                                         color: Color(0xFF1D2129),
                                         fontSize: 12,
                                         fontFamily: 'Nunito',
                                         fontWeight: FontWeight.w700,
                                         height: 1.18,
                                       ),
                                     ),
                                   ),
                                 ),
                                 const SizedBox(width: 2),
                                 Text(
                                   ':',
                                   style: TextStyle(
                                     color: Color(0xFF1D2129),
                                     fontSize: 12,
                                     fontFamily: 'Nunito',
                                     fontWeight: FontWeight.w400,
                                     height: 0.12,
                                   ),
                                 ),
                               ],
                             ),
                           ),
                         ),
                         const SizedBox(width: 12),
                         SizedBox(
                           width: 160,
                           child: Text(
                             '**** **** ${NumberController.text}',
                             style: TextStyle(
                               color: Color(0xFF1D2129),
                               fontSize: 12,
                               fontFamily: 'Nunito',
                               fontWeight: FontWeight.w800,
                               height: 0.12,
                             ),
                           ),
                         ),
                       ],
                     ),
                   ),
                   const SizedBox(height: 6),
                   Container(
                     width: double.infinity,
                     child: Row(
                       mainAxisSize: MainAxisSize.min,
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Expanded(
                           child: Container(
                             height: 25,
                             child: const Row(
                               mainAxisSize: MainAxisSize.min,
                               mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Expanded(
                                   child: SizedBox(
                                     child: Text(
                                       'A/c Holder Name',
                                       style: TextStyle(
                                         color: Color(0xFF1D2129),
                                         fontSize: 12,
                                         fontFamily: 'Nunito',
                                         fontWeight: FontWeight.w700,
                                         height: 1.1,
                                       ),
                                     ),
                                   ),
                                 ),
                                 SizedBox(width: 2),
                                 Text(
                                   ':',
                                   style: TextStyle(
                                     color: Color(0xFF1D2129),
                                     fontSize: 12,
                                     fontFamily: 'Nunito',
                                     fontWeight: FontWeight.w400,
                                     height: 0.12,
                                   ),
                                 ),
                               ],
                             ),
                           ),
                         ),
                         const SizedBox(width: 12),
                         SizedBox(
                           width: 160,
                           child: Text(
                             '${GirlChildName.text}',
                             style: TextStyle(
                               color: Color(0xFF1D2129),
                               fontSize: 12,
                               fontFamily: 'Nunito',
                               fontWeight: FontWeight.w800,
                               height: 0.12,
                             ),
                           ),
                         ),
                       ],
                     ),
                   ),
                   const SizedBox(height: 18),
                   Container(
                     width: double.infinity,
                     child: Row(
                       mainAxisSize: MainAxisSize.min,
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Expanded(
                           child: Container(
                             height: 18,
                             child: Row(
                               mainAxisSize: MainAxisSize.min,
                               mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Expanded(
                                   child: SizedBox(
                                     child: Text(
                                       'Date of Birth',
                                       style: TextStyle(
                                         color: Color(0xFF1D2129),
                                         fontSize: 12,
                                         fontFamily: 'Nunito',
                                         fontWeight: FontWeight.w700,
                                         height: 0.12,
                                       ),
                                     ),
                                   ),
                                 ),
                                 const SizedBox(width: 2),
                                 Text(
                                   ':',
                                   style: TextStyle(
                                     color: Color(0xFF1D2129),
                                     fontSize: 12,
                                     fontFamily: 'Nunito',
                                     fontWeight: FontWeight.w400,
                                     height: 0.12,
                                   ),
                                 ),
                               ],
                             ),
                           ),
                         ),
                         const SizedBox(width: 12),
                         SizedBox(
                           width: 160,
                           child: Text(
                             '${DateofBirth.text}',
                             style: TextStyle(
                               color: Color(0xFF1D2129),
                               fontSize: 12,
                               fontFamily: 'Nunito',
                               fontWeight: FontWeight.w800,
                               height: 0.12,
                             ),
                           ),
                         ),
                       ],
                     ),
                   )  ,
                   const SizedBox(height: 6),
                   Container(
                     width: double.infinity,
                     child: Row(
                       mainAxisSize: MainAxisSize.min,
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Expanded(
                           child: Container(
                             height: 25,
                             child: Row(
                               mainAxisSize: MainAxisSize.min,
                               mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Expanded(
                                   child: SizedBox(
                                     child: Text(
                                       'A/c Opening Date',
                                       style: TextStyle(
                                         color: Color(0xFF1D2129),
                                         fontSize: 12,
                                         fontFamily: 'Nunito',
                                         fontWeight: FontWeight.w700,
                                         height: 1.1,
                                       ),
                                     ),
                                   ),
                                 ),
                                 const SizedBox(width: 2),
                                 Text(
                                   ':',
                                   style: TextStyle(
                                     color: Color(0xFF1D2129),
                                     fontSize: 12,
                                     fontFamily: 'Nunito',
                                     fontWeight: FontWeight.w400,
                                     height: 0.12,
                                   ),
                                 ),
                               ],
                             ),
                           ),
                         ),
                         const SizedBox(width: 12),
                         SizedBox(
                           width: 160,
                           child: Text(
                             '${acOpeningDate.text}',
                             style: TextStyle(
                               color: Color(0xFF1D2129),
                               fontSize: 12,
                               fontFamily: 'Nunito',
                               fontWeight: FontWeight.w800,
                               height: 0.12,
                             ),
                           ),
                         ),
                       ],
                     ),
                   ) ,
                   const SizedBox(height: 8),
                   Container(
                     width: double.infinity,
                     child: Row(
                       mainAxisSize: MainAxisSize.min,
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Expanded(
                           child: Container(
                             height: 25,
                             child: Row(
                               mainAxisSize: MainAxisSize.min,
                               mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Expanded(
                                   child: SizedBox(
                                     child: Text(
                                       'Initial Contribution',
                                       style: TextStyle(
                                         color: Color(0xFF1D2129),
                                         fontSize: 12,
                                         fontFamily: 'Nunito',
                                         fontWeight: FontWeight.w700,
                                         height: 1.1,
                                       ),
                                     ),
                                   ),
                                 ),
                                 const SizedBox(width: 2),
                                 Text(
                                   ':',
                                   style: TextStyle(
                                     color: Color(0xFF1D2129),
                                     fontSize: 12,
                                     fontFamily: 'Nunito',
                                     fontWeight: FontWeight.w400,
                                     height: 0.12,
                                   ),
                                 ),
                               ],
                             ),
                           ),
                         ),
                         const SizedBox(width: 12),
                         SizedBox(
                           width: 160,
                           child: Text(
                             '${initalContributionController.text}',
                             style: TextStyle(
                               color: Color(0xFF1D2129),
                               fontSize: 12,
                               fontFamily: 'Nunito',
                               fontWeight: FontWeight.w800,
                               height: 0.12,
                             ),
                           ),
                         ),
                       ],
                     ),
                   ),

                 ],

               )
               ),

            ),
               const SizedBox(height: 8),
               Container(
                 width: 250,
                 height: 45,
                 decoration: ShapeDecoration(
                   image: DecorationImage(
                     image:  AssetImage('assets/Images/Button.png'),

                     fit: BoxFit.cover,
                   ),
                   color: Color(0xFFE5E6EB),
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(30),
                   ),
                 ),
                 // {" message":"SSA calculation for 15 years deposit and 6 years without deposit","monthly_contribution":"5000","interest_rate":"8.2","totaldeposit":900000,"total_interest":1873058,"totalclosingbalance":2773058,"data":[{"year":1,"interest_cf":2665,"total_deposit":60000,"opening_balance":0,"closing_balance":62665,"interest_rate":"8.2","annual_interest":2665},{"year":2,"interest_cf":7804,"total_deposit":60000,"opening_balance":62665,"closing_balance":130469,"interest_rate":"8.2","annual_interest":7804},{"year":3,"interest_cf":13363,"total_deposit":60000,"opening_balance":130469,"closing_balance":203832,"interest_rate":"8.2","annual_interest":13363},{"year":4,"interest_cf":19379,"total_deposit":60000,"opening_balance":203832,"closing_balance":283211,"interest_rate":"8.2","annual_interest":19379},{"year":5,"interest_cf":25888,"total_deposit":60000,"opening_balance":283211,"closing_balance":369099,"interest_rate":"8.2","annual_interest":25888},{"year":6,"interest_cf":32931,"total_deposit":60000,"opening_balance":369

                 child: ElevatedButton(
                   onPressed: () async {
                     try {
                       final response = await dio.post(
                           "https://admin.vcubetechservices.com/api/ssa-data",
                           queryParameters: {
                             "ssa_id":NumberController.text.trim(),
                           });
                       //      String ssa_id=response['data']['id'];
                       // print(response);

                       // print(ssa_id)
                     } catch (e) {
                       print(e);
                     }
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
                     'OK',
                     style: TextStyle(
                       color:  Colors.white,

                       fontSize: 16,
                       fontFamily: 'Nunito',
                       fontWeight: FontWeight.w600,
                       height: 0.09,
                     ),
                   ),
                 ),
               ),
             ],
           ),
          )
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        setState(() {
          if(calculatepressed==true){
            calculatepressed=false;
          }
        });
        Navigator.of(context).pop(false);
        return true;
      },
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(40, 60),
            child: AppBar(
              backgroundColor: Colors.white,
              elevation: 2,
              leading: Center(
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.arrow_back_rounded, color: Color(0xFF000000)),
                ),
              ),
              title: SizedBox(
                width: 261,
                child: Text(
                  'Sukanya Samriddhi Account (SSA)',
                  style: TextStyle(
                    color: Color(0xFF1D2129),
                    fontSize: 16,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w700,
                    height: 0.08,
                  ),
                ),
              ),
              centerTitle: false,
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: (){

                    },
                    child: SvgPicture.asset(
                      "assets/Images/sukaniyaAletrLogo.svg",
                      color: Colors.blue,
                      width: 25,
                      height: 25,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(top: 10,left: 15,right: 15),
                child: Container(
                  width: MediaQuery.of(context).size.width-15,
                  height: 44,
                  padding: const EdgeInsets.all(3),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: Color(0xFFF7F8FA),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 0.70, color: Color(0xFF86909C)),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            cal = true;
                            add = false;
                          });
                        },
                        child: Container(
                          width:MediaQuery.of(context).size.width/2-20,
                          height: 38,
                          padding: const EdgeInsets.all(8),
                          decoration: ShapeDecoration(
                            color:
                                cal ?
                                Color(0xFF008026) :
                                Color(0xFFE5E6EB),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                bottomLeft: Radius.circular(30),
                              ),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x33000000),
                                blurRadius: 3,
                                offset: Offset(0, 2),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 25,
                                height: 20,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 3.75, vertical: 1.25),
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/Images/Calculator.svg",
                                      color: cal
                                          ? Colors.white
                                          : Color(0xFF4E5969),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: SizedBox(
                                  child: Text(
                                    'Cal. Int.',
                                    style: TextStyle(
                                      color: cal
                                          ? Colors.white
                                          : Color(0xFF4E5969),
                                      fontSize: 14,
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.w900,
                                      height: 0.11,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 3.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              cal = false;
                              add = true;
                            });
                          },
                          child: Container(
                            width:MediaQuery.of(context).size.width/2-22,
                            height: 38,
                            padding: const EdgeInsets.all(8),
                            decoration: ShapeDecoration(
                              color:
                                  add ?
                                  Color(0xFF008026) :
                                  Color(0xFFE5E6EB),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(30),
                                  bottomRight: Radius.circular(30),
                                ),
                              ),
                              shadows: [
                                BoxShadow(
                                  color: Color(0x33000000),
                                  blurRadius: 3,
                                  offset: Offset(0, 2),
                                  spreadRadius: 0,
                                )
                              ],
                            ),

                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 25,
                                  height: 20,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 0.62, vertical: 1.25),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/Images/Person.svg",
                                        color: add
                                            ? Colors.white
                                            : Color(0xFF4E5969),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: SizedBox(
                                    child: Text(
                                      'Add A/c',
                                      style: TextStyle(
                                        color: add
                                            ? Colors.white
                                            : Color(0xFF4E5969),
                                        fontSize: 14,
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w900,
                                        height: 0.11,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
                child: Container(
                  width: 400,
                  height: 44,
                  padding: const EdgeInsets.all(3),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: Color(0xFFF7F8FA),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 0.70, color: Color(0xFF86909C)),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          width: 200,
                          height: 44,
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          decoration: ShapeDecoration(
                            color: Color(0xFF114BA3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                bottomLeft: Radius.circular(30),
                              ),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x33000000),
                                blurRadius: 3,
                                offset: Offset(0, 2),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 152,
                                height: 44,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 152,
                                      child: Text(
                                        calculatepressed?'Benefit Illustration':'Data Entry',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.bold,
                                          height: 0.17,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 3),
                      Expanded(
                        child: Container(
                          height: 44,
                          padding: const EdgeInsets.symmetric(
                              vertical: 4),
                          decoration: ShapeDecoration(
                            color: Color(0xFF114BA3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 152,
                                child: Text(
                                  'Date: ${DateFormat('dd/MM/yyyy').format(DateTime.now())}',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.bold,
                                    height: 0.11,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: cal,
                child: Column(
                  children: [
                    Visibility(
                      visible: !calculatepressed,
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 4),
                            child: Row(
                              children: [
                                Container(
                                  width: 175,
                                  height: 150,
                                  child: TextField(
                                    maxLength: 5,
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) async {
                                      setState(() {
                                        errorMessageNumber =
                                            _validateInput(value);
                                      });
                                      if (errorMessageNumber.isEmpty) {
                                        try {
                                          final response = await dio.post(
                                              "https://admin.vcubetechservices.com/api/cal-ssa",
                                              queryParameters: {
                                                "deposit": amountController.text,
                                                "interest_rate":
                                                    widget.currentInterest
                                              });

                                          print(response);

                                          setState(() {
                                            data = response.data;
                                            TotalContribution.text =
                                                addCommasToNumber(data["totaldeposit"].toString());
                                            MaturityAmount.text =
                                                addCommasToNumber (data["totalclosingbalance"]
                                                    .toString());
                                          });
                                          print(data["totalclosingbalance"]
                                              .toString());
                                        } catch (e) {
                                          print(e);
                                        }
                                      }else{
                                        setState(() {
                                          TotalContribution.text ="";
                                          MaturityAmount.text ="";
                                        });
                                      }
                                    },
                                    controller: amountController,
                                    inputFormatters: [
                                      // FilteringTextInputFormatter.allow(_validDigits),
                                    ],
                                    decoration: InputDecoration(
                                      error: errorMessageNumber != ""
                                          ? Row(
                                              children: [
                                                SvgPicture.asset(
                                                    "assets/Images/alert-circle.svg"),
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
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 1.0, horizontal: 10),
                                      counterText: "",
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.blue,
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          bottomLeft: Radius.circular(30),
                                        ),
                                      ),
                                      enabled: true,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey,
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          bottomLeft: Radius.circular(30),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: errorMessageNumber.isNotEmpty
                                              ? Colors.red
                                              : Color(0xFF86909C),
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          bottomLeft: Radius.circular(30),
                                        ),
                                      ),
                                      label: Text(
                                        'Monthly Contribution ',
                                        style: TextStyle(
                                          color: Color(0xFF23272F),
                                          fontSize: 14,
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.w700,
                                          height: 0.11,
                                        ),
                                      ),
                                      prefix: Container(
                                          width: 20,
                                          child: Text(
                                            "₹",
                                            style: TextStyle(
                                              color: Color(0xFF1D2129),
                                              fontSize: 16,
                                              fontFamily: 'Nunito',
                                              fontWeight: FontWeight.w700,
                                              height: 0.09,
                                            ),
                                          )),
                                      hintText: 'Enter Amount',
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
                                  padding: const EdgeInsets.only(left: 3.0),
                                  child: Container(
                                    width: 175,
                                    height: 150,
                                    child: TextField(
                                      maxLength: 5,
                                      readOnly: true,
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {},
                                      controller: interestControler,
                                      inputFormatters: [
                                        // FilteringTextInputFormatter.allow(_validDigits),
                                      ],
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 1.0, horizontal: 10),
                                        counterText: "",
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.blue,
                                            width: 1.0,
                                          ),
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(30),
                                            bottomRight: Radius.circular(30),
                                          ),
                                        ),
                                        enabled: true,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey,
                                            width: 1.0,
                                          ),
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(30),
                                            bottomRight: Radius.circular(30),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: errorMessageNumber.isNotEmpty
                                                ? Colors.red
                                                : Color(0xFF86909C),
                                            width: 1.0,
                                          ),
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(30),
                                            bottomRight: Radius.circular(30),
                                          ),
                                        ),
                                        label: Text(
                                          'Current Interest',
                                          style: TextStyle(
                                            color: Color(0xFF86909C),
                                            fontSize: 14,
                                            fontFamily: 'Nunito',
                                            fontWeight: FontWeight.w700,
                                            height: 0.11,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: errorMessageNumber.isNotEmpty ? 80 : 65.0,left: 20,right: 20),
                            child: Row(
                              children: [
                                Container(
                                  width: 175,
                                  height: 150,
                                  child: TextField(
                                    maxLength: 5,
                                    readOnly: true,
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {},
                                    controller: TotalContribution,
                                    inputFormatters: [
                                      // FilteringTextInputFormatter.allow(_validDigits),
                                    ],
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 1.0, horizontal: 10),
                                      counterText: "",
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.blue,
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          bottomLeft: Radius.circular(30),
                                        ),
                                      ),
                                      enabled: true,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey,
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          bottomLeft: Radius.circular(30),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: errorMessageNumber.isNotEmpty
                                              ? Colors.red
                                              : Color(0xFF86909C),
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          bottomLeft: Radius.circular(30),
                                        ),
                                      ),
                                      label: Text(
                                        'Total Contribution',
                                        style: TextStyle(
                                          color: Color(0xFF86909C),
                                          fontSize: 14,
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.w700,
                                          height: 0.11,
                                        ),
                                      ),
                                      prefix: Container(
                                          width: 20,
                                          child: Text(
                                            "₹",
                                            style: TextStyle(
                                              color: Color(0xFF1D2129),
                                              fontSize: 16,
                                              fontFamily: 'Nunito',
                                              fontWeight: FontWeight.w700,
                                              height: 0.09,
                                            ),
                                          )),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 3.0),
                                  child: Container(
                                    width: 175,
                                    height: 150,
                                    child: TextField(
                                      maxLength: 5,
                                      readOnly: true,
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {},
                                      controller: MaturityAmount,
                                      inputFormatters: [
                                        // FilteringTextInputFormatter.allow(_validDigits),
                                      ],
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 1.0, horizontal: 10),
                                        counterText: "",
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.blue,
                                            width: 1.0,
                                          ),
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(30),
                                            bottomRight: Radius.circular(30),
                                          ),
                                        ),
                                        enabled: true,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey,
                                            width: 1.0,
                                          ),
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(30),
                                            bottomRight: Radius.circular(30),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: errorMessageNumber.isNotEmpty
                                                ? Colors.red
                                                : Color(0xFF86909C),
                                            width: 1.0,
                                          ),
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(30),
                                            bottomRight: Radius.circular(30),
                                          ),
                                        ),
                                        label: Text(
                                          'Maturity Amount',
                                          style: TextStyle(
                                            color: Color(0xFF86909C),
                                            fontSize: 14,
                                            fontFamily: 'Nunito',
                                            fontWeight: FontWeight.w700,
                                            height: 0.11,
                                          ),
                                        ),
                                        prefix: Container(
                                            width: 20,
                                            child: Text(
                                              "₹",
                                              style: TextStyle(
                                                color: Color(0xFF1D2129),
                                                fontSize: 16,
                                                fontFamily: 'Nunito',
                                                fontWeight: FontWeight.w700,
                                                height: 0.09,
                                              ),
                                            )),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 130.0, left: 45),
                            child: GestureDetector(
                              onTap: () {
                                print(data);
                              },
                              child: Container(
                                width: 300,
                                height: 45,
                                decoration: ShapeDecoration(
                                  image: DecorationImage(
                                    image: _validateInput(amountController.text)
                                            .isEmpty
                                        ? AssetImage('assets/Images/Button.png')
                                        : AssetImage(
                                            "assets/Images/unactivebutton.png"),
                                    fit: BoxFit.cover,
                                  ),
                                  color: Color(0xFFE5E6EB),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                // {" message":"SSA calculation for 15 years deposit and 6 years without deposit","monthly_contribution":"5000","interest_rate":"8.2","totaldeposit":900000,"total_interest":1873058,"totalclosingbalance":2773058,"data":[{"year":1,"interest_cf":2665,"total_deposit":60000,"opening_balance":0,"closing_balance":62665,"interest_rate":"8.2","annual_interest":2665},{"year":2,"interest_cf":7804,"total_deposit":60000,"opening_balance":62665,"closing_balance":130469,"interest_rate":"8.2","annual_interest":7804},{"year":3,"interest_cf":13363,"total_deposit":60000,"opening_balance":130469,"closing_balance":203832,"interest_rate":"8.2","annual_interest":13363},{"year":4,"interest_cf":19379,"total_deposit":60000,"opening_balance":203832,"closing_balance":283211,"interest_rate":"8.2","annual_interest":19379},{"year":5,"interest_cf":25888,"total_deposit":60000,"opening_balance":283211,"closing_balance":369099,"interest_rate":"8.2","annual_interest":25888},{"year":6,"interest_cf":32931,"total_deposit":60000,"opening_balance":369

                                child: ElevatedButton(
                                  onPressed: errorMessageNumber.isEmpty?() {
                                    setState(() {
                                      calculatepressed = true;
                                      Chartdata = data['data'];
                                    });
                                    List<Employee> employess = [];
                                    for (int i = 0; i < Chartdata.length; i++) {
                                      setState(() {
                                        employess.add(Employee(

                                            '${Chartdata[i]['year'].toString()}',
                                            '${addCommasToNumber(Chartdata[i]['opening_balance'].toString())}',
                                            '${addCommasToNumber(Chartdata[i]['total_deposit'].toString())}',
                                            '${addCommasToNumber(Chartdata[i]['annual_interest'].toString())}',
                                            '${addCommasToNumber(Chartdata[i]['closing_balance'].toString())}',
                                        ));
                                      });

                                    }
                                    setState(() {
                                      employees= employess;
                                      employeeDataSource = EmployeeDataSource(employees: employees);
                                    });
                                    print(Chartdata);
                                  }:(){},
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    padding: EdgeInsets.all(16.0),
                                  ),
                                  child: Text(
                                    'Calculate',
                                    style: TextStyle(
                                      color: _validateInput(amountController.text)
                                              .isEmpty
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
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: calculatepressed,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Container(
                          width: 400,
                          height: 200,
                          padding: const EdgeInsets.all(8),
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 1, color: Color(0xFF86909C)),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 6),
                              Container(
                                width: double.infinity,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 18,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: SizedBox(
                                                child: Text(
                                                  'Monthly Contribution',
                                                  style: TextStyle(
                                                    color: Color(0xFF1D2129),
                                                    fontSize: 12,
                                                    fontFamily: 'Nunito',
                                                    fontWeight: FontWeight.w700,
                                                    height: 0.12,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 2),
                                            Text(
                                              ':',
                                              style: TextStyle(
                                                color: Color(0xFF1D2129),
                                                fontSize: 12,
                                                fontFamily: 'Nunito',
                                                fontWeight: FontWeight.w400,
                                                height: 0.12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    SizedBox(
                                      width: 160,
                                      child: Text(
                                        '₹ ${addCommasToNumber(amountController.text)}/-',
                                        style: TextStyle(
                                          color: Color(0xFF1D2129),
                                          fontSize: 12,
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.w800,
                                          height: 0.12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 6),
                              Container(
                                width: double.infinity,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 18,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: SizedBox(
                                                child: Text(
                                                  'Interest Rate',
                                                  style: TextStyle(
                                                    color: Color(0xFF1D2129),
                                                    fontSize: 12,
                                                    fontFamily: 'Nunito',
                                                    fontWeight: FontWeight.w700,
                                                    height: 0.12,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 2),
                                            Text(
                                              ':',
                                              style: TextStyle(
                                                color: Color(0xFF1D2129),
                                                fontSize: 12,
                                                fontFamily: 'Nunito',
                                                fontWeight: FontWeight.w400,
                                                height: 0.12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    SizedBox(
                                      width: 160,
                                      child: Text(
                                        '${widget.currentInterest}%',
                                        style: TextStyle(
                                          color: Color(0xFF1D2129),
                                          fontSize: 12,
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.w800,
                                          height: 0.12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 6),
                              Container(
                                width: double.infinity,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 18,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: SizedBox(
                                                child: Text(
                                                  'Deposit Period',
                                                  style: TextStyle(
                                                    color: Color(0xFF1D2129),
                                                    fontSize: 12,
                                                    fontFamily: 'Nunito',
                                                    fontWeight: FontWeight.w700,
                                                    height: 0.12,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 2),
                                            Text(
                                              ':',
                                              style: TextStyle(
                                                color: Color(0xFF1D2129),
                                                fontSize: 12,
                                                fontFamily: 'Nunito',
                                                fontWeight: FontWeight.w400,
                                                height: 0.12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    SizedBox(
                                      width: 160,
                                      child: Text(
                                        '15 Years from A/c Opening',
                                        style: TextStyle(
                                          color: Color(0xFF1D2129),
                                          fontSize: 12,
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.w800,
                                          height: 0.12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 6),
                              Container(
                                width: double.infinity,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 18,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: SizedBox(
                                                child: Text(
                                                  'Freezing Period',
                                                  style: TextStyle(
                                                    color: Color(0xFF1D2129),
                                                    fontSize: 12,
                                                    fontFamily: 'Nunito',
                                                    fontWeight: FontWeight.w700,
                                                    height: 0.12,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 2),
                                            Text(
                                              ':',
                                              style: TextStyle(
                                                color: Color(0xFF1D2129),
                                                fontSize: 12,
                                                fontFamily: 'Nunito',
                                                fontWeight: FontWeight.w400,
                                                height: 0.12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    SizedBox(
                                      width: 160,
                                      child: Text(
                                        '6 Years after Deposit Period',
                                        style: TextStyle(
                                          color: Color(0xFF1D2129),
                                          fontSize: 12,
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.w800,
                                          height: 0.12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 6),
                              Container(
                                width: double.infinity,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 18,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: SizedBox(
                                                child: Text(
                                                  'Maturity Period',
                                                  style: TextStyle(
                                                    color: Color(0xFF1D2129),
                                                    fontSize: 12,
                                                    fontFamily: 'Nunito',
                                                    fontWeight: FontWeight.w700,
                                                    height: 0.12,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 2),
                                            Text(
                                              ':',
                                              style: TextStyle(
                                                color: Color(0xFF1D2129),
                                                fontSize: 12,
                                                fontFamily: 'Nunito',
                                                fontWeight: FontWeight.w400,
                                                height: 0.12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    SizedBox(
                                      width: 160,
                                      child: Text(
                                        '21 Years from A/c Opening',
                                        style: TextStyle(
                                          color: Color(0xFF1D2129),
                                          fontSize: 12,
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.w800,
                                          height: 0.12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 6),
                              Container(
                                width: double.infinity,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 18,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: SizedBox(
                                                child: Text(
                                                  'Total Contribution',
                                                  style: TextStyle(
                                                    color: Color(0xFF1D2129),
                                                    fontSize: 12,
                                                    fontFamily: 'Nunito',
                                                    fontWeight: FontWeight.w700,
                                                    height: 0.12,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 2),
                                            Text(
                                              ':',
                                              style: TextStyle(
                                                color: Color(0xFF1D2129),
                                                fontSize: 12,
                                                fontFamily: 'Nunito',
                                                fontWeight: FontWeight.w400,
                                                height: 0.12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    SizedBox(
                                      width: 160,
                                      child: Text(
                                        '₹ ${addCommasToNumber(TotalContribution.text)}/-',
                                        style: TextStyle(
                                          color: Color(0xFF1D2129),
                                          fontSize: 12,
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.w800,
                                          height: 0.12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 6),
                              Container(
                                width: double.infinity,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 18,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: SizedBox(
                                                child: Text(
                                                  'Total Interest',
                                                  style: TextStyle(
                                                    color: Color(0xFF1D2129),
                                                    fontSize: 12,
                                                    fontFamily: 'Nunito',
                                                    fontWeight: FontWeight.w700,
                                                    height: 0.12,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 2),
                                            Text(
                                              ':',
                                              style: TextStyle(
                                                color: Color(0xFF1D2129),
                                                fontSize: 12,
                                                fontFamily: 'Nunito',
                                                fontWeight: FontWeight.w400,
                                                height: 0.12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    SizedBox(
                                      width: 160,
                                      child: Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: '₹ ${addCommasToNumber(data['total_interest'].toString())}/-',
                                              style: TextStyle(
                                                color: Color(0xFFF63031),
                                                fontSize: 12,
                                                fontFamily: 'Nunito',
                                                fontWeight: FontWeight.w800,
                                                height: 0.12,
                                              ),
                                            ),
                                            TextSpan(
                                              text: ' (Approx)',
                                              style: TextStyle(
                                                color: Color(0xFF1D2129),
                                                fontSize: 12,
                                                fontFamily: 'Nunito',
                                                fontWeight: FontWeight.w800,
                                                height: 0.12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 6),
                              Container(
                                width: double.infinity,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 8,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: SizedBox(
                                                child: Text(
                                                  'Maturity Amount',
                                                  style: TextStyle(
                                                    color: Color(0xFF1D2129),
                                                    fontSize: 12,
                                                    fontFamily: 'Nunito',
                                                    fontWeight: FontWeight.w800,
                                                    height: 0.12,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 2),
                                            Text(
                                              ':',
                                              style: TextStyle(
                                                color: Color(0xFF1D2129),
                                                fontSize: 12,
                                                fontFamily: 'Nunito',
                                                fontWeight: FontWeight.w400,
                                                height: 0.12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    SizedBox(
                                      width: 160,
                                      child: Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: '₹ ${addCommasToNumber(MaturityAmount.text)}/-',
                                              style: TextStyle(
                                                color: Color(0xFFF63031),
                                                fontSize: 12,
                                                fontFamily: 'Nunito',
                                                fontWeight: FontWeight.w800,
                                                height: 0.12,
                                              ),
                                            ),
                                            TextSpan(
                                              text: ' (Approx)',
                                              style: TextStyle(
                                                color: Color(0xFF1D2129),
                                                fontSize: 12,
                                                fontFamily: 'Nunito',
                                                fontWeight: FontWeight.w800,
                                                height: 0.12,
                                              ),
                                            ),
                                          ],
                                        ),
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
                    SizedBox(height: 20,),
                    Visibility(
                      visible: calculatepressed,
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 11.5),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 65,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFEF0F0),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20)),
                                        border: Border(
                                          left:
                                          BorderSide(color: Color(0xFF86909C)),
                                          top: BorderSide(color: Color(0xFF86909C)),
                                          right: BorderSide(
                                              width: 1, color: Color(0xFF86909C)),
                                          bottom: BorderSide(
                                              width: 1, color: Color(0xFF86909C)),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 5.0),
                                        child: Center(
                                          child: SizedBox(
                                            width: 60,
                                            child: Text(
                                              'Financial Year',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontFamily: 'Nunito',
                                                fontWeight: FontWeight.bold,
                                                height: 0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 80,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFEF0F0),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(00)),
                                        border: Border(
                                          left:
                                          BorderSide(color: Color(0xFF86909C)),
                                          top: BorderSide(color: Color(0xFF86909C)),
                                          right: BorderSide(
                                              width: 1, color: Color(0xFF86909C)),
                                          bottom: BorderSide(
                                              width: 1, color: Color(0xFF86909C)),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 70,
                                            child: Center(
                                              child: Text(
                                                'Opening\nBalance',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontFamily: 'Nunito',
                                                  fontWeight: FontWeight.bold,
                                                  height: 0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 80,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFEF0F0),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(00)),
                                        border: Border(
                                          left:
                                          BorderSide(color: Color(0xFF86909C)),
                                          top: BorderSide(color: Color(0xFF86909C)),
                                          right: BorderSide(
                                              width: 1, color: Color(0xFF86909C)),
                                          bottom: BorderSide(
                                              width: 1, color: Color(0xFF86909C)),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 70,
                                            child: Center(
                                              child: Text(
                                                'Total\nDeposit',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontFamily: 'Nunito',
                                                  fontWeight: FontWeight.bold,
                                                  height: 0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 80,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFEF0F0),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(00)),
                                        border: Border(
                                          left:
                                          BorderSide(color: Color(0xFF86909C)),
                                          top: BorderSide(color: Color(0xFF86909C)),
                                          right: BorderSide(
                                              width: 1, color: Color(0xFF86909C)),
                                          bottom: BorderSide(
                                              width: 1, color: Color(0xFF86909C)),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 70,
                                            child: Center(
                                              child: Text(
                                                'Annual\nInterest',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontFamily: 'Nunito',
                                                  fontWeight: FontWeight.bold,
                                                  height: 0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 65,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFEF0F0),
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(20)),
                                        border: Border(
                                          left:
                                          BorderSide(color: Color(0xFF86909C)),
                                          top: BorderSide(color: Color(0xFF86909C)),
                                          right: BorderSide(
                                              width: 1, color: Color(0xFF86909C)),
                                          bottom: BorderSide(
                                              width: 1, color: Color(0xFF86909C)),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 56.6,
                                            child: Center(
                                              child: Text(
                                                'Closing\nBalance',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontFamily: 'Nunito',
                                                  fontWeight: FontWeight.bold,
                                                  height: 0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                 ListView.builder(
                                   physics: NeverScrollableScrollPhysics(),
                                   shrinkWrap: true,
                                     itemCount:Chartdata.length,
                                     itemBuilder: (BuildContext context, int index){
                                   return     Row(
                                     children: [
                                       Container(
                                         width: 65,
                                         height: 30,
                                         decoration: BoxDecoration(
                                           color: index % 2 ==0? Colors.white:Color(0xFFF7F8FA),
                                           borderRadius: BorderRadius.only(
                                               topLeft: Radius.circular(00),
                                               bottomLeft: index==Chartdata.length-1?Radius.circular(20):   Radius.circular(00),
                                           ),
                                           border: Border(
                                             left:
                                             BorderSide(color: Color(0xFF86909C)),
                                             top: BorderSide(color: Color(0xFF86909C)),
                                             right: BorderSide(
                                                 width: 1, color: Color(0xFF86909C)),
                                             bottom: BorderSide(
                                                 width: 1, color: Color(0xFF86909C)),
                                           ),
                                         ),
                                         child: Row(
                                           mainAxisSize: MainAxisSize.min,
                                           mainAxisAlignment: MainAxisAlignment.center,
                                           crossAxisAlignment:
                                           CrossAxisAlignment.center,
                                           children: [
                                             SizedBox(
                                               width: 45,
                                               child: Center(
                                                 child: Text(
                                                   '${Chartdata[index]['year']}',
                                                   textAlign: TextAlign.center,
                                                   style: TextStyle(
                                                     color: Colors.black,
                                                     fontSize: 13,
                                                     fontFamily: 'Nunito',
                                                     fontWeight: FontWeight.bold,
                                                     height: 0,
                                                   ),
                                                 ),
                                               ),
                                             ),
                                           ],
                                         ),
                                       ),
                                       Container(
                                         width: 80,
                                         height: 30,
                                         decoration: BoxDecoration(
                                           color: index % 2 ==0? Colors.white:Color(0xFFF7F8FA),
                                           borderRadius: BorderRadius.only(
                                               topLeft: Radius.circular(00)),
                                           border: Border(
                                             left:
                                             BorderSide(color: Color(0xFF86909C)),
                                             top: BorderSide(color: Color(0xFF86909C)),
                                             right: BorderSide(
                                                 width: 1, color: Color(0xFF86909C)),
                                             bottom: BorderSide(
                                                 width: 1, color: Color(0xFF86909C)),
                                           ),
                                         ),
                                         child: Row(
                                           mainAxisSize: MainAxisSize.min,
                                           mainAxisAlignment: MainAxisAlignment.center,
                                           crossAxisAlignment:
                                           CrossAxisAlignment.center,
                                           children: [
                                             SizedBox(
                                               width: 70,
                                               child: Center(
                                                 child: FittedBox(
                                                   fit:BoxFit.fitWidth,
                                                   child: Text(
                                                     '₹ ${addCommasToNumber(Chartdata[index]['opening_balance'].toString())}',
                                                     textAlign: TextAlign.center,
                                                     style: TextStyle(
                                                       color: Colors.black,
                                                       fontSize: 13,
                                                       fontFamily: 'Nunito',
                                                       fontWeight: FontWeight.bold,
                                                       height: 0,
                                                     ),
                                                   ),
                                                 ),
                                               ),
                                             ),
                                           ],
                                         ),
                                       ),
                                       Container(
                                         width: 80,
                                         height: 30,
                                         decoration: BoxDecoration(
                                           color: index % 2 ==0? Colors.white:Color(0xFFF7F8FA),
                                           borderRadius: BorderRadius.only(
                                               topLeft: Radius.circular(00)),
                                           border: Border(
                                             left:
                                             BorderSide(color: Color(0xFF86909C)),
                                             top: BorderSide(color: Color(0xFF86909C)),
                                             right: BorderSide(
                                                 width: 1, color: Color(0xFF86909C)),
                                             bottom: BorderSide(
                                                 width: 1, color: Color(0xFF86909C)),
                                           ),
                                         ),
                                         child: Row(
                                           mainAxisSize: MainAxisSize.min,
                                           mainAxisAlignment: MainAxisAlignment.center,
                                           crossAxisAlignment:
                                           CrossAxisAlignment.center,
                                           children: [
                                             SizedBox(
                                               width: 70,
                                               child: Center(
                                                 child: FittedBox(
                                                   fit:BoxFit.fitWidth,
                                                   child: Text(
                                                     '₹ ${addCommasToNumber(Chartdata[index]['total_deposit'].toString())}',
                                                     textAlign: TextAlign.center,
                                                     style: TextStyle(
                                                       color: Colors.black,
                                                       fontSize: 13,
                                                       fontFamily: 'Nunito',
                                                       fontWeight: FontWeight.bold,
                                                       height: 0,
                                                     ),
                                                   ),
                                                 ),
                                               ),
                                             ),
                                           ],
                                         ),
                                       ),
                                       Container(
                                         width: 80,
                                         height: 30,
                                         decoration: BoxDecoration(
                                           color: index % 2 ==0? Colors.white:Color(0xFFF7F8FA),
                                           borderRadius: BorderRadius.only(
                                               topLeft: Radius.circular(00)),
                                           border: Border(
                                             left:
                                             BorderSide(color: Color(0xFF86909C)),
                                             top: BorderSide(color: Color(0xFF86909C)),
                                             right: BorderSide(
                                                 width: 1, color: Color(0xFF86909C)),
                                             bottom: BorderSide(
                                                 width: 1, color: Color(0xFF86909C)),
                                           ),
                                         ),
                                         child: Row(
                                           mainAxisSize: MainAxisSize.min,
                                           mainAxisAlignment: MainAxisAlignment.center,
                                           crossAxisAlignment:
                                           CrossAxisAlignment.center,
                                           children: [
                                             SizedBox(
                                               width: 70,
                                               child: Center(
                                                 child: FittedBox(
                                                   fit:BoxFit.fitWidth,
                                                   child: Text(
                                                     '₹ ${addCommasToNumber(Chartdata[index]['annual_interest'].toString())}',
                                                     textAlign: TextAlign.center,
                                                     style: TextStyle(
                                                       color: Colors.black,
                                                       fontSize: 13,
                                                       fontFamily: 'Nunito',
                                                       fontWeight: FontWeight.bold,
                                                       height: 0,
                                                     ),
                                                   ),
                                                 ),
                                               ),
                                             ),
                                           ],
                                         ),
                                       ),
                                       Container(
                                         width: 65,
                                         height: 30,
                                         decoration: BoxDecoration(
                                           color: index % 2 ==0? Colors.white:Color(0xFFF7F8FA),
                                           borderRadius: BorderRadius.only(
                                               topLeft: Radius.circular(00),
                                             bottomRight: index==Chartdata.length-1?Radius.circular(20):   Radius.circular(00),
                                           ),
                                           border: Border(
                                             left:
                                             BorderSide(color: Color(0xFF86909C)),
                                             top: BorderSide(color: Color(0xFF86909C)),
                                             right: BorderSide(
                                                 width: 1, color: Color(0xFF86909C)),
                                             bottom: BorderSide(
                                                 width: 1, color: Color(0xFF86909C)),
                                           ),
                                         ),
                                         child: Row(
                                           mainAxisSize: MainAxisSize.min,
                                           mainAxisAlignment: MainAxisAlignment.center,
                                           crossAxisAlignment:
                                           CrossAxisAlignment.center,
                                           children: [
                                             SizedBox(
                                               width: 60,
                                               child: Center(
                                                 child: FittedBox(
                                                   fit:BoxFit.fitWidth,
                                                   child: Text(
                                                     '₹ ${addCommasToNumber(Chartdata[index]['closing_balance'].toString())}',
                                                     textAlign: TextAlign.center,
                                                     style: TextStyle(
                                                       color: Colors.black,
                                                       fontSize: 18,
                                                       fontFamily: 'Nunito',
                                                       fontWeight: FontWeight.bold,
                                                       height: 0,
                                                     ),
                                                   ),
                                                 ),
                                               ),
                                             ),
                                           ],
                                         ),
                                       ),

                                     ],
                                   );
                                 })
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
              Visibility(
                  visible: !cal,
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                            child: TextField(
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.bold,
                                height: 0.11,
                              ),
                              readOnly: false,
                              controller: NumberController,
                              keyboardType: TextInputType.number,
                              onTap: () {
                                // Position cursor at the end if it's not already there
                                int newPosition = NumberController.text.length;
                                NumberController.selection = TextSelection.fromPosition(
                                  TextPosition(offset: newPosition),
                                );
                              },
                              maxLength: 4,
                              onChanged: (value) {},
                              decoration: InputDecoration(
                                counterText: "",
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
                                  'A/c Number',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.bold,
                                    height: 0.11,
                                  ),
                                ),
                                hintText: 'Enter last 4 digits of A/c Number',
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
                            padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                            child: TextField(
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.bold,
                                height: 0.11,
                              ),
                              readOnly: false,
                              controller: GirlChildName,
                              keyboardType: TextInputType.emailAddress,
                              // onTap: (){
                              //   setState(() {
                              //     NumberController.text="**** **** ";
                              //   });
                              // },
                              onChanged: (value) {
                                setState(() {
                                  errorForGirlName=validateName(value);
                                });
                      
                              },
                              decoration: InputDecoration(
                                 error:  errorForGirlName != ""
                                      ? Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/Images/alert-circle.svg"),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        errorForGirlName,
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 12,
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.w700,
                                          height: 0.12,
                                        ),
                                      ),
                                    ],
                                  ):null,
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
                                  'Name of the Girl Child',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.bold,
                                    height: 0.11,
                                  ),
                                ),
                                hintText: 'Enter Girl Child Name',
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
                            padding: const EdgeInsets.only(left: 20.0,top: 10),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width/2.2,
                                  height: 50,
                                  child: TextField(
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.bold,
                                      height: 0.11,
                                    ),
                                    keyboardType: TextInputType.datetime,
                                    readOnly: true,
                      
                                    controller: acOpeningDate,
                                    // onTap: (){
                                    //   setState(() {
                                    //     NumberController.text="**** **** ";
                                    //   });
                                    // },
                                    onChanged: (value) {},
                                    decoration: InputDecoration(
                                      suffix:GestureDetector(
                                          onTap: (){
                                            _selectDateAge(context);
                                          },
                                          child: Icon(Icons.calendar_today_sharp,size: 20,)),
                      
                      
                                      contentPadding: EdgeInsets.symmetric(vertical: 1.0,horizontal: 10),
                      
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.blue,
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30.0),
                                          bottomLeft: Radius.circular(30.0),
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey,
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30.0),
                                          bottomLeft: Radius.circular(30.0),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey,
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30.0),
                                          bottomLeft: Radius.circular(30.0),
                                        ),
                                      ),
                                      label: Text(
                                        'A/c Opening Date',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.bold,
                                          height: 0.11,
                                        ),
                                      ),
                                      hintText: 'DD/MM/YYYY',
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
                                SizedBox(width: 3,),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width/2.3,
                                  height: 50,
                                  child: TextField(
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.bold,
                                      height: 0.11,
                                    ),
                                    keyboardType: TextInputType.datetime,
                                    readOnly: true,
                      
                                    controller: ageAtAcOpening,
                                    // onTap: (){
                                    //   setState(() {
                                    //     NumberController.text="**** **** ";
                                    //   });
                                    // },
                                    onChanged: (value) {},
                                    decoration: InputDecoration(
                      
                                      contentPadding: EdgeInsets.symmetric(vertical: 1.0,horizontal: 10),
                      
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.blue,
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(30.0),
                                          bottomRight: Radius.circular(30.0),
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey,
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(30.0),
                                          bottomRight: Radius.circular(30.0),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey,
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(30.0),
                                          bottomRight: Radius.circular(30.0),
                                        ),
                                      ),
                                      label: Text(
                                        'Age at A/c Opening',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.bold,
                                          height: 0.11,
                                        ),
                                      ),
                                      hintText: '00 Y   00 M   00 D',
                                      hintStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.bold,
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0,top: 20),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width/2.2,
                                  height: 50,
                                  child: TextField(
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.bold,
                                      height: 0.11,
                                    ),
                                    keyboardType: TextInputType.datetime,
                                    readOnly: true,
                      
                                    controller: DateofBirth,
                      
                                    decoration: InputDecoration(
                                      suffix:GestureDetector(
                                          onTap: (){
                                            setState(() {
                                              _selectedDate=_selectedDateAge;
                                            });
                                            _selectDate(context,_selectedDateAge);
                                          },
                                          child: Icon(Icons.calendar_today_sharp,size: 20,)),
                      
                                      contentPadding: EdgeInsets.symmetric(vertical: 1.0,horizontal: 10),
                      
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.blue,
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30.0),
                                          bottomLeft: Radius.circular(30.0),
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey,
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30.0),
                                          bottomLeft: Radius.circular(30.0),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey,
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30.0),
                                          bottomLeft: Radius.circular(30.0),
                                        ),
                                      ),
                                      label: Text(
                                        'Date of Birth',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.bold,
                                          height: 0.11,
                                        ),
                                      ),
                                      hintText: 'DD/MM/YYYY',
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
                                SizedBox(
                                  width: 3,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width/2.3,
                                  height: 50,
                                  child: TextField(
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.bold,
                                      height: 0.11,
                                    ),
                      
                                    keyboardType: TextInputType.datetime,
                                    readOnly: true,
                      
                                    controller: currentAge,
                                    // onTap: (){
                                    //   setState(() {
                                    //     NumberController.text="**** **** ";
                                    //   });
                                    // },
                                    onChanged: (value) {},
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(vertical: 1.0,horizontal: 10),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.blue,
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(30.0),
                                          bottomRight: Radius.circular(30.0),
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey,
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(30.0),
                                          bottomRight: Radius.circular(30.0),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey,
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(30.0),
                                          bottomRight: Radius.circular(30.0),
                                        ),
                                      ),
                                      label: Text(
                                        'Current Age',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.bold,
                                          height: 0.11,
                                        ),
                                      ),
                                      hintText: '00 Y   00 M   00 D',
                                      hintStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.bold,
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0,top: 20),
                            child: Row(
                              children: [
                      
                                SizedBox(
                                  width: MediaQuery.of(context).size.width/2.2,
                                  height: 300,
                                  child: TextField(

                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.bold,
                                      height: 0.11,
                                    ),
                                    keyboardType: TextInputType.number,
                                    readOnly: false,
                      
                                    controller: initalContributionController,
                                    // onTap: (){
                                    //   setState(() {
                                    //     NumberController.text="**** **** ";
                                    //   });
                                    // },
                                    onChanged: (text) {
                                      setState(() {
                                        error= validateInitialContribution(text);
                                        initalContributionController.text=addCommasToNumber(text);
                                      });

                                    },
                                    decoration: InputDecoration(
                                      prefix: Text("₹",style: TextStyle(color: Colors.black),),
                                      error: error != ""
                                          ? Row(
                                                                              children: [
                                          SvgPicture.asset(
                                              "assets/Images/alert-circle.svg"),
                                          SizedBox(
                                            width: 5,
                                          ),
                                                                                SizedBox(
                                                                                  width: 135,
                                            height: 35,
                                            child: Text(
                                              error,
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 12,
                                                fontFamily: 'Nunito',
                                                fontWeight: FontWeight.w700,
                                                height: 1,
                                              ),
                                            ),
                                          ),
                                                                              ],
                                                                            )
                                          : null,
                                      contentPadding: EdgeInsets.symmetric(vertical: 1.0,horizontal: 10),
                      
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.blue,
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30.0),
                                          bottomLeft: Radius.circular(30.0),
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey,
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30.0),
                                          bottomLeft: Radius.circular(30.0),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey,
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30.0),
                                          bottomLeft: Radius.circular(30.0),
                                        ),
                                      ),
                                      label: Text(
                                        'Initial Contribution',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.bold,
                                          height: 0.11,
                                        ),
                                      ),
                                      hintText: 'Enter Amount',
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
                                SizedBox(
                                  width: 3,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 250.0),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width/2.3,
                                    height: 50,
                                    child: TextField(
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.bold,
                                        height: 0.11,
                                      ),
                      
                                      readOnly: true,
                                      controller: interestControler,
                                      // onTap: (){
                                      //   setState(() {
                                      //     NumberController.text="**** **** ";
                                      //   });
                                      // },
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(vertical: 1.0,horizontal: 10),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.blue,
                                            width: 2.0,
                                          ),
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(30.0),
                                            bottomRight: Radius.circular(30.0),
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey,
                                            width: 2.0,
                                          ),
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(30.0),
                                            bottomRight: Radius.circular(30.0),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey,
                                            width: 2.0,
                                          ),
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(30.0),
                                            bottomRight: Radius.circular(30.0),
                                          ),
                                        ),
                                        label: Text(
                                          'Current Interest',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontFamily: 'Nunito',
                                            fontWeight: FontWeight.bold,
                                            height: 0.11,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      
                       
                        ],
                      ),
                      Padding(
                        padding:  EdgeInsets.only(left: 54.0,top: error != ""?395:360),
                        child: Container(
                          width: 300,
                          height: 45,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: _validateInput(amountController.text)
                                  .isEmpty
                                  ? AssetImage('assets/Images/Button.png')
                                  : AssetImage(
                                  "assets/Images/unactivebutton.png"),
                              fit: BoxFit.cover,
                            ),
                            color: Color(0xFFE5E6EB),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          // {" message":"SSA calculation for 15 years deposit and 6 years without deposit","monthly_contribution":"5000","interest_rate":"8.2","totaldeposit":900000,"total_interest":1873058,"totalclosingbalance":2773058,"data":[{"year":1,"interest_cf":2665,"total_deposit":60000,"opening_balance":0,"closing_balance":62665,"interest_rate":"8.2","annual_interest":2665},{"year":2,"interest_cf":7804,"total_deposit":60000,"opening_balance":62665,"closing_balance":130469,"interest_rate":"8.2","annual_interest":7804},{"year":3,"interest_cf":13363,"total_deposit":60000,"opening_balance":130469,"closing_balance":203832,"interest_rate":"8.2","annual_interest":13363},{"year":4,"interest_cf":19379,"total_deposit":60000,"opening_balance":203832,"closing_balance":283211,"interest_rate":"8.2","annual_interest":19379},{"year":5,"interest_cf":25888,"total_deposit":60000,"opening_balance":283211,"closing_balance":369099,"interest_rate":"8.2","annual_interest":25888},{"year":6,"interest_cf":32931,"total_deposit":60000,"opening_balance":369
                        
                          child: ElevatedButton(
                            onPressed: errorMessageNumber.isEmpty?() async {
                              OnTapDataEntry(context);
                              try {
                                final response = await dio.post(
                                    "https://admin.vcubetechservices.com/api/ssa/add",
                                    queryParameters: {
                                      "ac_number":NumberController.text.trim(),
                                      "name":GirlChildName.text.trim(),
                                      "ac_opening_date":acOpeningDate.text.trim().replaceAll("/", "-"),
                                      "dob":DateofBirth.text.trim().replaceAll("/", "-"),
                                      "opening_interest":interestControler.text.replaceAll("%", ""),
                                      "age_at_ac_opening":formatDateDifferenceforapi(acOpeningDate.text),
                                      "initial_contribution":initalContributionController.text.trim().replaceAll(",", ""),
                                      "current_age":formatDateDifferenceforapi(DateofBirth.text),
                                      "user_id":id,
                                    });
                                print(json.decode(response.toString()));
                                Map<String,dynamic> ssaResponse=json.decode(response.toString());
                                     String ssa_id=ssaResponse["data"]['id'];


                                  print(ssaResponse);
                                  print(ssa_id);


                              } catch (e) {
                                print(e);
                              }

                            }:(){},
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              padding: EdgeInsets.all(16.0),
                            ),
                            child: Text(
                              'Data Entry',
                              style: TextStyle(
                                color: _validateInput(amountController.text)
                                    .isEmpty
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
                      ),
                    ],
                  )),

            ]),
          )),
    );
  }

  String validateName(String name) {
    // Trim any leading and trailing whitespace
    name = name.trim();

    // Check the maximum length
    if (name.length > 20) {
      return "Maximum 20 letters allowed.";
    }

    // Check for numbers
    if (name.contains(RegExp(r'[0-9]'))) {
      return "No numbers allowed.";
    }

    // Check for special characters
    if (name.contains(RegExp(r'[^a-zA-Z ]'))) {
      return "No special characters allowed.";
    }

    // Count the number of alphabetic characters
    int letterCount = name.replaceAll(' ', '').length;

    // Check the minimum number of letters
    if (letterCount < 3) {
      return "Please enter a minimum of 3 letters for your name.";
    }

    // If all checks passed, no error
    return "";
  }
  String validateInitialContribution(String contributionStr) {
    // Remove any commas for thousands and parse the string to an integer
    int? amount = int.tryParse(contributionStr.replaceAll(',', '').trim());

    // Check if parsing was successful
    if (amount == null) {
      return "Invalid amount format. Please enter a valid number.";
    }

    // Check the minimum amount
    if (amount < 250) {
      return "Minimum initial contribution must be ₹250.";
    }

    // Check the multiplicity of ₹50
    if (amount % 50 != 0) {
      return "Initial contribution must be in multiples of ₹50.";
    }

    // Check the maximum amount
    if (amount > 150000) {
      return "Maximum initial contribution is ₹1,50,000.";
    }

    // If all checks passed, no error
    return "";
  }}

String _validateInput(String value) {
  if (value.isEmpty) {
    return 'Please enter an amount';
  }
  int? amount = int.tryParse(value);
  if (amount == null || amount < 50 || amount % 50 != 0 || value.length > 5) {
    if (amount! < 50) {
      return 'Minimum monthly contribution must be ₹ 50/-';
    } else if ( amount>12500) {
      return 'A Maximum monthly contribution is ₹ 12,500/- ';
    }else if (amount % 50 != 0) {
      return 'Monthly contribution must be in multiples of ₹ 50/-';
    } else if (value.length > 5) {
      return 'A Maximum monthly contribution is ₹ 12,500/- ';
    }
    else {
      return 'Invalid amount';
    }
  }
  return '';
}

class Employee {
  Employee(this.FinancialYear, this.OpeningBalance, this.TotalDeposit,
      this.AnnualInterest, this.ClosingBalance);
  final String FinancialYear;
  final String OpeningBalance;
  final String TotalDeposit;
  final String AnnualInterest;
  final String ClosingBalance;
}

class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource({required List<Employee> employees}) {
    _employees = employees
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(
                  columnName: 'Financial Year', value: '${e.FinancialYear}'),
              DataGridCell<String>(
                  columnName: 'Opening Balance', value: '₹${e.OpeningBalance}'),
              DataGridCell<String>(
                  columnName: 'Total Deposit', value: '₹${e.TotalDeposit}'),
              DataGridCell<String>(
                  columnName: 'Annual Interest', value: '₹${e.AnnualInterest}'),
              DataGridCell<String>(
                  columnName: 'Closing Balance', value: '₹${e.ClosingBalance}'),
            ]))
        .toList();
  }

  List<DataGridRow> _employees = [];

  @override
  List<DataGridRow> get rows => _employees;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
        alignment: (dataGridCell.columnName == 'id' ||
                dataGridCell.columnName == 'salary')
            ? Alignment.centerRight
            : Alignment.centerLeft,
        padding: EdgeInsets.all(16.0),
        child: Text(dataGridCell.value.toString()),
      );
    }).toList());
  }
}

String addCommasToNumber(String number) {
  String strippedNumberString = number.replaceAll(',', '');
  String numString = strippedNumberString;
  String result = '';
  int commaIndex = numString.length % 2;

  int remainingLength = numString.length - commaIndex;
  int startIndex = 0;

  if (remainingLength > 3) {
    int firstPartLength = remainingLength % 2 == 1 ? 1 : 2;
    result += numString.substring(startIndex, startIndex + firstPartLength) + ',';
    startIndex += firstPartLength;
  }

  while (startIndex < remainingLength - 2) {
    result += numString.substring(startIndex, startIndex + 2) + ',';
    startIndex += 2;
  }

  result += numString.substring(startIndex); // Add remaining digits
  return result;
}

String _formatDate(String input) {
  // Remove non-numeric characters
  input = input.replaceAll(RegExp(r'[^0-9]'), '');

  // Trim to 8 characters (ddmmyyyy)
  if (input.length > 8) {
    input = input.substring(0, 8);
  }

  // Add a slash after the first two characters
  if (input.length >= 3) {
    input = input.substring(0, 2) + '/' + input.substring(2);
  }

  // Add a slash after the next two characters
  if (input.length >= 6) {
    input = input.substring(0, 5) + '/' + input.substring(5);
  }

  // Add leading zero if day is a single digit
  if (input.length >= 1 && input.length <= 2) {
    String day = input.substring(0, 1);
    if (!RegExp(r'[0-9]').hasMatch(day)) {
      input = '0' + input;
    }
  }

  return input;
}

class FourDigitInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Only allow numeric characters and limit the length to 4
    String newText = newValue.text.replaceAll(RegExp('[^0-9]'), '');
    if (newText.length > 4) {
      newText = newText.substring(0, 4);
    }

    // Add visual "****" masking and spaces for user input
    newText = "**** **** " + newText.padRight(4, ' ').substring(0, 4);

    // Ensure the cursor is always at the end after the space
    int cursorPosition = newText.length;

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: cursorPosition),
    );
  }
}