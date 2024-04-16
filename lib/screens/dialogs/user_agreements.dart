import 'package:flutter/material.dart';

import '../../utils/size_config.dart';

class UserAgreements extends StatelessWidget {
  const UserAgreements({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.heightMultiplier * 60,
      width: SizeConfig.widthMultiplier * 100,
      decoration: BoxDecoration(
        color: const Color(0xFF0B7689).withOpacity(0.2),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Stack(
        children: [
          Padding(
            padding:  EdgeInsets.only(top: SizeConfig.heightMultiplier * 5, left: 8, right: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'SOCKEYWAY APP USER AGREEMENTS 🤝'.toUpperCase(),
                    style: TextStyle(
                      fontSize: SizeConfig.textMultiplier * 2,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Divider(),
                Expanded(
                  child: ListView(
                    children: [
                      Text(
                        'This User Agreement ("Agreement") is between you ("User") and '
                            'Sockey regarding the use of the Sockey App '
                            'By installing or using SOckey, you agree to be bound by the this Agreement.',
                        style: TextStyle(
                            fontSize: SizeConfig.textMultiplier * 1.5,
                            color: Colors.black,
                            fontStyle: FontStyle.italic
                        ),
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 1),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '1.'.toUpperCase(),
                            style: TextStyle(
                              fontSize: SizeConfig.textMultiplier * 1.5,
                              color: Colors.black,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'License Grant: Company grants User a limited, non-exclusive, non-transferable license to '
                                  'use the App for personal, non-commercial purposes. User may not sublicense, distribute, or otherwise transfer the App.',
                              style: TextStyle(
                                fontSize: SizeConfig.textMultiplier * 1.5,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 0.5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '2.'.toUpperCase(),
                            style: TextStyle(
                              fontSize: SizeConfig.textMultiplier * 1.5,
                              color: Colors.black,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Intellectual Property: The App, including all content, features, and functionality, is owned by Sockey and protected by '
                                  'copyright, trademark, and other intellectual property laws. User may not copy, modify, or create derivative works of the App.',
                              style: TextStyle(
                                fontSize: SizeConfig.textMultiplier * 1.5,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 0.5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '3.'.toUpperCase(),
                            style: TextStyle(
                              fontSize: SizeConfig.textMultiplier * 1.5,
                              color: Colors.black,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              ' Restrictions: User agrees not to:',
                              style: TextStyle(
                                fontSize: SizeConfig.textMultiplier * 1.5,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: SizeConfig.textMultiplier * 1.8),
                            child: Text(
                              'a.',
                              style: TextStyle(
                                fontSize: SizeConfig.textMultiplier * 1.5,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Use the App for any unlawful purpose;',
                              style: TextStyle(
                                fontSize: SizeConfig.textMultiplier * 1.5,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: SizeConfig.textMultiplier * 1.8),
                            child: Text(
                              'b.',
                              style: TextStyle(
                                fontSize: SizeConfig.textMultiplier * 1.5,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Attempt to gain unauthorized access to any part of the App;',
                              style: TextStyle(
                                fontSize: SizeConfig.textMultiplier * 1.5,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: SizeConfig.textMultiplier * 1.8),
                            child: Text(
                              'c.',
                              style: TextStyle(
                                fontSize: SizeConfig.textMultiplier * 1.5,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Interfere with the operation of the App;',
                              style: TextStyle(
                                fontSize: SizeConfig.textMultiplier * 1.5,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: SizeConfig.textMultiplier * 1.8),
                            child: Text(
                              'd.',
                              style: TextStyle(
                                fontSize: SizeConfig.textMultiplier * 1.5,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Reverse engineer, decompile, or disassemble the App;',
                              style: TextStyle(
                                fontSize: SizeConfig.textMultiplier * 1.5,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: SizeConfig.textMultiplier * 1.8),
                            child: Text(
                              'e.',
                              style: TextStyle(
                                fontSize: SizeConfig.textMultiplier * 1.5,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Remove or modify any copyright, trademark, or other proprietary notices in the App.',
                              style: TextStyle(
                                fontSize: SizeConfig.textMultiplier * 1.5,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 0.5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '4.'.toUpperCase(),
                            style: TextStyle(
                              fontSize: SizeConfig.textMultiplier * 1.5,
                              color: Colors.black,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Privacy: Company may collect and use certain information about User in accordance with its Privacy Policy, '
                                  'which is incorporated by reference into this Agreement.',
                              style: TextStyle(
                                fontSize: SizeConfig.textMultiplier * 1.5,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 0.5),
                      Text(
                        'By accepting this Agreement, User acknowledges that has read and understood all of the '
                            'terms and conditions set forth herein and agrees to be bound by them.',
                        style: TextStyle(
                          fontSize: SizeConfig.textMultiplier * 1.5,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 1.5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Sockey FC',
                            style: TextStyle(
                                fontSize: SizeConfig.textMultiplier * 1.5,
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            'P O BOX 1298,',
                            style: TextStyle(
                                fontSize: SizeConfig.textMultiplier * 1.5,
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            'Dar es Salaam, Tanzania',
                            style: TextStyle(
                                fontSize: SizeConfig.textMultiplier * 1.5,
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            right: 0,
            child: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(Icons.cancel_outlined),
            ),),
        ],
      ),
    );
  }
}
