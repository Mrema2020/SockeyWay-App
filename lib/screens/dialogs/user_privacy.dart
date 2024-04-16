import 'package:flutter/material.dart';

import '../../utils/size_config.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({super.key});

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.widthMultiplier * 100,
      height: SizeConfig.heightMultiplier * 62,
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
            padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 5, left: 8, right: 8),
            child:  Column(
              children: [
                Center(
                  child: Text(
                    'Terms And Conditions ✍️'.toUpperCase(),
                    style: TextStyle(
                      fontSize: SizeConfig.textMultiplier * 2,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Divider(),
                Expanded(
                  child: ListView(
                    children: [
                      Text(
                        'These terms and conditions are an agreement between SMZ '
                            'and users regarding the use of DIRA application.',
                        style: TextStyle(
                          fontSize: SizeConfig.textMultiplier * 2,
                          color: Colors.black,
                          fontStyle: FontStyle.italic
                        ),
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 1),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 0.6, right: 5),
                            child: Container(
                              width: SizeConfig.widthMultiplier * 1,
                              height: SizeConfig.heightMultiplier * 1,
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'By using this App, you represent and warrant that you are of legal age to form a binding '
                                  'contract with the Company and meet all of the foregoing eligibility requirements.',
                              style: TextStyle(
                                  fontSize: SizeConfig.textMultiplier * 1.8,
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
                            padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 0.6, right: 5),
                            child: Container(
                              width: SizeConfig.widthMultiplier * 1,
                              height: SizeConfig.heightMultiplier * 1,
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'The App and its original content, features, and functionality are owned by SMZ and are protected by '
                                  'international copyright, trademark, patent, trade secret, and other intellectual property or proprietary rights laws.',
                              style: TextStyle(
                                  fontSize: SizeConfig.textMultiplier * 1.8,
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
                            padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 0.6, right: 5),
                            child: Container(
                              width: SizeConfig.widthMultiplier * 1,
                              height: SizeConfig.heightMultiplier * 1,
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'We may terminate or suspend your account and bar access to the App immediately, without prior notice or liability, under our '
                                  'sole discretion, for any reason whatsoever and without limitation, including but not limited to a breach of the Terms.',
                              style: TextStyle(
                                  fontSize: SizeConfig.textMultiplier * 1.8,
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
                            padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 0.6, right: 5),
                            child: Container(
                              width: SizeConfig.widthMultiplier * 1,
                              height: SizeConfig.heightMultiplier * 1,
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'By submitting any content to the App, you grant us a perpetual, irrevocable, non-terminable, worldwide, '
                                  'non-exclusive, royalty-free, and fully sublicensable license to use, reproduce, modify, adapt, publish, '
                                  'translate, create derivative works from, distribute, and display such content throughout the world in any media.',
                              style: TextStyle(
                                  fontSize: SizeConfig.textMultiplier * 1.8,
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
                            padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 0.6, right: 5),
                            child: Container(
                              width: SizeConfig.widthMultiplier * 1,
                              height: SizeConfig.heightMultiplier * 1,
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'By accessing or using the App, you agree to be bound by these Terms. If you '
                                  'disagree with any part of the terms, then you may not access the App.',
                              style: TextStyle(
                                  fontSize: SizeConfig.textMultiplier * 1.8,
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
                            padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 0.6, right: 5),
                            child: Container(
                              width: SizeConfig.widthMultiplier * 1,
                              height: SizeConfig.heightMultiplier * 1,
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'If you have any questions about these Terms, please contact us at:',
                              style: TextStyle(
                                  fontSize: SizeConfig.textMultiplier * 1.8,
                                  color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 1.5),
                      Column(
                        children: [
                          Text(
                            'Serikali Ya Mapinduzi Zanzibar (SMZ)',
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
                            'Zanzibar, Tanzania',
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
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.cancel_outlined,
                color: Colors.black,
                size: SizeConfig.widthMultiplier * 8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
