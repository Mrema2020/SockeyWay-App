import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sockeyway/utils/colors.dart';

import '../../utils/size_config.dart';
import '../dialogs/dialo_builder.dart';

class TicketPurchasePage extends StatefulWidget {
  const TicketPurchasePage({super.key});

  @override
  _TicketPurchasePageState createState() => _TicketPurchasePageState();
}

class _TicketPurchasePageState extends State<TicketPurchasePage> {
  int _activeStepIndex = 0;
  int selectedValue = 0;
  String? _selectMatch;
  String? _selectedSeats;
  String? _selectedTickets;
  List<DropdownMenuItem<String>> _matchItems = [];
  final List<String> _seatItems = <String>['VIP A', 'VIP B', 'VIP C', 'Regular', 'Orange Seats', 'Purple Seats'];
  final List<String> _ticketItems = <String>['1', '2', '3', '4', '5'];

  @override
  void initState() {
    _fetchMatches();
    super.initState();
  }

  TextEditingController providerController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController paymentPhoneController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Widget _buildPayment() {
    return const Column(
      children: [
        Text('Summary', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        // Add payment logic here
      ],
    );
  }

  List<Widget> get _steps => [
        _address(),
        _paymentConfirmation(),
        _summary(),
      ];

  void _onStepContinue() {
    setState(() {
      if (_activeStepIndex < _steps.length - 1) {
        _activeStepIndex++;
      }
    });
  }

  void _onStepCancel() {
    setState(() {
      if (_activeStepIndex > 0) {
        _activeStepIndex--;
      }
    });
  }

  Future<void> _fetchMatches() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('matches').get();
      List<DropdownMenuItem<String>> items = snapshot.docs.map((doc) {
        String match = '${doc['home_team']} Vs ${doc['away_team']}';
        return DropdownMenuItem<String>(
          value: match,
          child: Text(match),
        );
      }).toList();

      setState(() {
        _matchItems = items;
      });
    } catch (e) {
      print('Error fetching matches: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Buy Your Tickets',
          style: TextStyle(
            color: AppColors.primaryColor,
            fontSize: SizeConfig.textMultiplier * 2.5,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            EasyStepper(
              activeStep: _activeStepIndex,
              onStepReached: (index) {
                setState(() {
                  _activeStepIndex = index;
                });
              },
              steps: const [
                EasyStep(
                  title: 'Details',
                  icon: Icon(Icons.sports_soccer),
                ),
                EasyStep(
                  title: 'Payment',
                  icon: Icon(Icons.monetization_on),
                ),
                EasyStep(
                  title: 'Summary',
                  icon: Icon(Icons.book),
                ),
              ],
            ),
            Expanded(
              child: _steps[_activeStepIndex],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_activeStepIndex >= 0)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                          onPressed: _onStepCancel,
                          child: const Text(
                            'Back',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      decoration: BoxDecoration(
                        color: _activeStepIndex == _steps.length - 1 ? Colors.green[800] : AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextButton(
                        onPressed: () {
                          if (_activeStepIndex == _steps.length - 1) {
                            postTicket();
                          } else {
                            if (nameController.text.trim() == '' ||
                                phoneController.text.trim() == '' ||
                                _selectMatch == null ||
                                _selectedSeats == null ||
                                _selectedTickets == null) {
                              Flushbar(
                                flushbarPosition: FlushbarPosition.TOP,
                                backgroundColor: Colors.red,
                                margin: const EdgeInsets.only(left: 8, right: 8),
                                borderRadius: BorderRadius.circular(10),
                                duration: const Duration(seconds: 2),
                                messageText: const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      CupertinoIcons.xmark_circle_fill,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "Please fill all details",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ).show(context);
                            } else {
                              _onStepContinue();
                            }
                          }
                        },
                        child: Text(
                          _activeStepIndex == _steps.length - 1 ? 'Finish' : 'Next',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _address() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.17,
                    child: Text(
                      'Name:',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextField(
                          controller: nameController,
                          cursorColor: Colors.grey[400],
                          decoration: const InputDecoration.collapsed(
                            hintText: '',
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.17,
                    child: Text(
                      'Phone:',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: phoneController,
                          cursorColor: Colors.grey[400],
                          decoration: const InputDecoration.collapsed(
                            hintText: '',
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.17,
                    child: Text(
                      'Match:',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: (_matchItems.isNotEmpty)
                          ? DropdownButtonFormField<String>(
                              hint: Text(
                                'Choose a match',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                              value: _selectMatch,
                              items: _matchItems,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectMatch = newValue;
                                });
                              },
                              decoration: const InputDecoration.collapsed(hintText: ''),
                            )
                          :
                          // Display the selected match
                          const Padding(
                              padding: EdgeInsets.only(top: 16.0),
                              child: Text('Selected Match fvcker'),
                            ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.17,
                    child: Text(
                      'Seat:',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration.collapsed(hintText: ''),
                        hint: Text(
                          'Choose Seat',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                        items: _seatItems.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 15,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedSeats = newValue;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.17,
                    child: Text(
                      'Tickets:',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration.collapsed(hintText: ''),
                        hint: Text(
                          'Number of tickets',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                        items: _ticketItems.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 15,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedTickets = newValue;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _paymentConfirmation() {
    print("Seats value from here = $_selectedSeats");
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Choose your payment method',
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.09,
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: RadioListTile<int>(
                        value: 1,
                        groupValue: selectedValue,
                        onChanged: (int? value) {
                          setState(() {
                            selectedValue = value!;
                          });
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedValue = 1;
                          providerController.text = "Vodacom";
                        });
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.22,
                        height: MediaQuery.of(context).size.width * 0.09,
                        child: Image.asset(
                          'assets/images/m_pesa.JPG',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.09,
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: RadioListTile<int>(
                        value: 2,
                        groupValue: selectedValue,
                        onChanged: (int? value) {
                          setState(() {
                            selectedValue = value!;
                          });
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedValue = 2;
                          providerController.text = "Tigo Zantel";
                        });
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.22,
                        height: MediaQuery.of(context).size.width * 0.09,
                        child: Image.asset(
                          'assets/images/tigo.png',
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.09,
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: RadioListTile<int>(
                          value: 3,
                          groupValue: selectedValue,
                          onChanged: (int? value) {
                            setState(() {
                              selectedValue = value!;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedValue = 3;
                              providerController.text = "Airtel";
                            });
                          },
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: MediaQuery.of(context).size.width * 0.09,
                            child: Image.asset(
                              'assets/images/airtel.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Text(
              'Phone number:',
              style: TextStyle(color: Colors.grey[800], fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Container(
              height: MediaQuery.of(context).size.height * 0.06,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 4,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextField(
                    controller: paymentPhoneController,
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.grey[400],
                    decoration: const InputDecoration.collapsed(
                      hintText: '',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            Text(
              'Provider:',
              style: TextStyle(color: Colors.grey[800], fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Container(
              height: MediaQuery.of(context).size.height * 0.06,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextField(
                    controller: providerController,
                    readOnly: true,
                    cursorColor: Colors.grey[400],
                    decoration: const InputDecoration.collapsed(
                      hintText: '',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _summary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Name:",
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 15,
              ),
            ),
            Text(
              "Phone Number:",
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 15,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              nameController.text,
              style: const TextStyle(
                color: AppColors.primaryColor,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              phoneController.text,
              style: const TextStyle(
                color: AppColors.primaryColor,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        // SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        const Divider(),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Match:",
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 15,
              ),
            ),
            Text(
              "Seat",
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 15,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _selectMatch == null ? '' : _selectMatch!,
              style: const TextStyle(
                color: AppColors.primaryColor,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              _selectedSeats == null ? '' : _selectedSeats!,
              style: const TextStyle(
                color: AppColors.primaryColor,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const Divider(),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Match:",
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 15,
              ),
            ),
            Text(
              "Seat",
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 15,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _selectMatch == null ? '' : _selectMatch!,
              style: const TextStyle(
                color: AppColors.primaryColor,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              _selectedSeats == null ? '' : _selectedSeats!,
              style: const TextStyle(
                color: AppColors.primaryColor,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const Divider(),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Provider",
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 15,
              ),
            ),
            Text(
              "Amount",
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 15,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              providerController.text,
              style: const TextStyle(
                color: AppColors.primaryColor,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              '30,000 Tzs',
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> postTicket() async {
    if (paymentPhoneController.text.trim() == '') {
      Flushbar(
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Colors.red,
        margin: const EdgeInsets.only(left: 8, right: 8),
        borderRadius: BorderRadius.circular(10),
        duration: const Duration(seconds: 2),
        messageText: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              CupertinoIcons.xmark_circle_fill,
              color: Colors.white,
            ),
            SizedBox(width: 10),
            Text(
              "Please enter payment phone number",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ).show(context);
    }
    try {
      DialogBuilder(context).showLoadingIndicator('Posting..');
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance.collection('tickets').add({
          'Name': nameController.text,
          'userId': user.uid,
          'phoneNumber': phoneController.text,
          'match': _selectMatch,
          'seat': _selectedSeats,
          'tickets': _selectedTickets,
          'paymentNumber': paymentPhoneController.text,
          'provider': providerController.text,
          'amount': '30,000 Tzs',
          'status': 'Pending Payment',
          'timestamp': FieldValue.serverTimestamp(),
        });
        DialogBuilder(context).hideOpenDialog();
        Navigator.pop(context);
        Flushbar(
          flushbarPosition: FlushbarPosition.TOP,
          backgroundColor: Colors.green,
          margin: const EdgeInsets.only(left: 8, right: 8),
          borderRadius: BorderRadius.circular(10),
          duration: const Duration(seconds: 5),
          messageText: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                CupertinoIcons.check_mark_circled_solid,
                color: Colors.white,
              ),
              SizedBox(width: 10),
              Text(
                "Ticket Placed Successfully",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ).show(context);
      } else {
        DialogBuilder(context).hideOpenDialog();
        // Handle user not signed in
      }
    } catch (e) {
      DialogBuilder(context).hideOpenDialog();
      print("Error on buying ticket $e");
    }
  }
}
