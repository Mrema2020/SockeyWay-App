import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/size_config.dart';

class TicketsPage extends StatefulWidget {
  const TicketsPage({super.key});

  @override
  State<TicketsPage> createState() => _TicketsPageState();
}

class _TicketsPageState extends State<TicketsPage> {
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Tickets',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: SizeConfig.textMultiplier * 2.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _firestore.collection('tickets').snapshots(),
                  builder: (context, snapshot) {
                    final user = FirebaseAuth.instance.currentUser;
                    String userId = user!.uid;
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text('No tickets available'));
                    }
                    return ListView(
                      children: snapshot.data!.docs.map((doc) {
                        return userId == doc['userId']
                            ? Padding(
                                padding: const EdgeInsets.only(bottom: 18.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          color: Colors.deepOrangeAccent,
                                          width: SizeConfig.widthMultiplier * 35,
                                          height: SizeConfig.heightMultiplier * 18,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                CupertinoIcons.tickets,
                                                color: Colors.white,
                                                size: 60,
                                              ),
                                              Text(
                                                doc['status'],
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: SizeConfig.textMultiplier * 1.8,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Name',
                                                style: TextStyle(
                                                  color: AppColors.primaryColor,
                                                  fontSize: SizeConfig.textMultiplier * 1.5,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              Text(
                                                doc['Name'],
                                                style: TextStyle(
                                                  color: AppColors.primaryColor,
                                                  fontSize: SizeConfig.textMultiplier * 1.5,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              Text(
                                                'Match',
                                                style: TextStyle(
                                                  color: AppColors.primaryColor,
                                                  fontSize: SizeConfig.textMultiplier * 1.5,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              Text(
                                                doc['match'],
                                                style: TextStyle(
                                                  color: AppColors.primaryColor,
                                                  fontSize: SizeConfig.textMultiplier * 1.5,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              Text(
                                                'Seat',
                                                style: TextStyle(
                                                  color: AppColors.primaryColor,
                                                  fontSize: SizeConfig.textMultiplier * 1.5,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              Text(
                                                doc['seat'],
                                                style: TextStyle(
                                                  color: AppColors.primaryColor,
                                                  fontSize: SizeConfig.textMultiplier * 1.5,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              Text(
                                                'Amount',
                                                style: TextStyle(
                                                  color: AppColors.primaryColor,
                                                  fontSize: SizeConfig.textMultiplier * 1.5,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              Text(
                                                doc['amount'],
                                                style: TextStyle(
                                                  color: AppColors.primaryColor,
                                                  fontSize: SizeConfig.textMultiplier * 1.5,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : Center(
                                child: Text(
                                  '',
                                  style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: SizeConfig.textMultiplier * 1.5,
                                  ),
                                ),
                              );
                      }).toList(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
