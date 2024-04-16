import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/size_config.dart';

class MatchesPage extends StatefulWidget {
  const MatchesPage({super.key});

  @override
  State<MatchesPage> createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: SizeConfig.heightMultiplier * 100,
          width: SizeConfig.widthMultiplier * 100,
          child: Column(
            children: [
              Expanded(child: _fixtures())
            ],
          ),
        ),
      ),
    );
  }

  _fixtures(){
    return Padding(
      padding:  const EdgeInsets.only(left: 15.0, right: 15, top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Fixtures',
              style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: SizeConfig.textMultiplier * 2.5,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          SizedBox(height: SizeConfig.heightMultiplier * 1),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('matches').snapshots(),
              builder: (context, snapshot){
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
            
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
            
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No matches available'));
                }
                return ListView(
                  children: snapshot.data!.docs.map((doc) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 18.0),
                      child: Container(
                        height: SizeConfig.heightMultiplier * 18,
                        decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 7,
                                left: 0,
                                right: 0,
                                child: SizedBox(
                                  width: SizeConfig.widthMultiplier * 75,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        doc['date'].toString().substring(0,10),
                                        style: TextStyle(
                                          color: AppColors.textColor,
                                          fontSize: SizeConfig.textMultiplier * 1.5,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        doc['time'].toString().substring(10,15),
                                        style: TextStyle(
                                          color: AppColors.textColor,
                                          fontSize: SizeConfig.textMultiplier * 1.5,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: SizeConfig.heightMultiplier * 3),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          doc['home_team'],
                                          style: TextStyle(
                                              color: AppColors.textColor,
                                              fontSize:
                                              SizeConfig.textMultiplier * 2.5,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Vs',
                                          style: TextStyle(
                                            color: AppColors.textColor,
                                            fontSize: SizeConfig.textMultiplier * 2,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          doc['away_team'],
                                          style: TextStyle(
                                              color: AppColors.textColor,
                                              fontSize:
                                              SizeConfig.textMultiplier * 2.5,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
