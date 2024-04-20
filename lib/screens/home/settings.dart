import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sockeyway/utils/colors.dart';

import '../../utils/size_config.dart';
import '../dialogs/logout_dialog.dart';
import '../dialogs/user_agreements.dart';
import '../dialogs/user_privacy.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _switchValue = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white24,
      body: SafeArea(
        child: SizedBox(
          height: SizeConfig.heightMultiplier * 100,
          width: SizeConfig.widthMultiplier * 100,
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.heightMultiplier * 2,
              ),
              Text(
                'Settings',
                style: TextStyle(
                    fontSize: SizeConfig.textMultiplier * 2.5,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w500),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  // height: SizeConfig.heightMultiplier * 40,
                  width: SizeConfig.widthMultiplier * 100,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Text(
                            'General'.toUpperCase(),
                            style: TextStyle(
                                fontSize: SizeConfig.textMultiplier * 1.8,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(CupertinoIcons.bell,
                                  size: 20,
                                  color: AppColors.primaryColor,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    'Notification',
                                    style: TextStyle(
                                        fontSize: SizeConfig.textMultiplier * 2,
                                        color: AppColors.primaryColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                            Transform.scale(
                              scale: 0.7,
                              child: CupertinoSwitch(
                                value: _switchValue,
                                onChanged: (value) {
                                  setState(() {
                                    _switchValue = value;
                                  });
                                  print('Switch value $_switchValue');
                                },
                                activeColor: const Color(0xFF0B7689),
                                trackColor: Colors.black12,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            'About'.toUpperCase(),
                            style: TextStyle(
                                fontSize: SizeConfig.textMultiplier * 1.8,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Column(
                          children: [
                            InkWell(
                              onTap: (){
                                showBottomSheet(
                                  context: context,
                                  builder: (_) => const UserAgreements(),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(CupertinoIcons.lock_fill,
                                          size: 20,
                                          color: AppColors.primaryColor,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            'User Agreement',
                                            style: TextStyle(
                                                fontSize: SizeConfig.textMultiplier * 2,
                                                color: AppColors.primaryColor,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Transform.scale(
                                        scale: 0.8,
                                        child:  const Icon(
                                            CupertinoIcons.forward,
                                          color: AppColors.primaryColor)
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(color: Colors.grey.shade300),
                            InkWell(
                              onTap: (){
                                showBottomSheet(
                                    context: context,
                                    builder: (_) => const TermsAndConditions()
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.text_snippet,
                                          size: 20,
                                          color: AppColors.primaryColor,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            'Terms and Conditions',
                                            style: TextStyle(
                                                fontSize: SizeConfig.textMultiplier * 2,
                                                color: AppColors.primaryColor,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Transform.scale(
                                        scale: 0.8,
                                        child:  const Icon(
                                            CupertinoIcons.forward,
                                          color: AppColors.primaryColor,)
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(color: Colors.grey.shade300),
                            // InkWell(
                            //   onTap: (){},
                            //   child: Container(
                            //     child: Padding(
                            //       padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                            //       child: Row(
                            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //         children: [
                            //           Row(
                            //             children: [
                            //               const Icon(
                            //                 Icons.share,
                            //                 size: 20,
                            //                 color: AppColors.primaryColor,
                            //               ),
                            //               Padding(
                            //                 padding: const EdgeInsets.only(left: 8.0),
                            //                 child: Text(
                            //                   'Tell a Friend',
                            //                   style: TextStyle(
                            //                       fontSize: SizeConfig.textMultiplier * 2,
                            //                       color: AppColors.primaryColor,
                            //                       fontWeight: FontWeight.w500),
                            //                 ),
                            //               ),
                            //             ],
                            //           ),
                            //           Transform.scale(
                            //               scale: 0.8,
                            //               child:  const Icon(
                            //                   CupertinoIcons.forward,
                            //                 color: AppColors.primaryColor,
                            //               )
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            // Divider(color: Colors.grey.shade300),
                            // InkWell(
                            //   onTap: (){},
                            //   child: Padding(
                            //     padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                            //     child: Row(
                            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //       children: [
                            //         Row(
                            //           children: [
                            //             const Icon(
                            //               Icons.help_outline,
                            //               size: 20,
                            //               color: AppColors.primaryColor,
                            //             ),
                            //             Padding(
                            //               padding: const EdgeInsets.only(left: 8.0),
                            //               child: Text(
                            //                 'Help Center',
                            //                 style: TextStyle(
                            //                     fontSize: SizeConfig.textMultiplier * 2,
                            //                     color: AppColors.primaryColor,
                            //                     fontWeight: FontWeight.w500),
                            //               ),
                            //             ),
                            //           ],
                            //         ),
                            //         Transform.scale(
                            //             scale: 0.8,
                            //             child:  const Icon(
                            //                 CupertinoIcons.forward,
                            //               color: AppColors.primaryColor,
                            //             )
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            // Divider(color: Colors.grey.shade300),
                            InkWell(
                              onTap: (){
                                showDialog(context: context, builder: (_) => const LogoutDialog());
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.logout,
                                          size: 20,
                                          color: AppColors.primaryColor,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            'Logout',
                                            style: TextStyle(
                                                fontSize: SizeConfig.textMultiplier * 2,
                                                color: AppColors.primaryColor,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Transform.scale(
                                        scale: 0.8,
                                        child:  const Icon(
                                            CupertinoIcons.forward,
                                          color: AppColors.primaryColor,
                                        )
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(color: Colors.grey.shade300),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0, bottom: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Build Information'.toUpperCase(),
                                style: TextStyle(
                                    fontSize: SizeConfig.textMultiplier * 1.8,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                '2024.1.1.0'.toUpperCase(),
                                style: TextStyle(
                                    fontSize: SizeConfig.textMultiplier * 2,
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
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
    );
  }

  // Future<void> share() async {
  //   if (Platform.isAndroid) {
  //     await FlutterShare.share(
  //         title: 'Check out this Dira App',
  //         text: 'Check out this Awsome Dira App',
  //         linkUrl: 'https://play.google.com/store/apps/details?id=Zanzibar',
  //         chooserTitle: 'Example Chooser Title');
  //   } else if (Platform.isIOS) {
  //     await FlutterShare.share(
  //         title: 'Check out this Dira App',
  //         text: 'Check out this Awsome Dira App',
  //         linkUrl: 'https://apps.apple.com/app/Zanzibar',
  //         chooserTitle: 'Example Chooser Title');
  //   } else {
  //     await FlutterShare.share(
  //         title: 'Check out this Dira App',
  //         text: 'Check out this Awsome Dira App',
  //         linkUrl: 'https://dirapp.com',
  //         chooserTitle: 'Example Chooser Title');
  //   }
  // }
}
