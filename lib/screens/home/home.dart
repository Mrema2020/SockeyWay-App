import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sockeyway/utils/size_config.dart';

import '../../utils/colors.dart';

class HomePage extends StatefulWidget {
  final dynamic username;
  const HomePage({super.key, this.username});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  User? user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Post> posts = [];


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: SizeConfig.widthMultiplier * 100,
          height: SizeConfig.heightMultiplier * 100,
          child: Padding(
            padding: EdgeInsets.only(
              left: SizeConfig.widthMultiplier * 2,
              right: SizeConfig.widthMultiplier * 2,
              top: SizeConfig.heightMultiplier * 2,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [_header(), Expanded(child: _posts())],
            ),
          ),
        ),
      ),
    );
  }

  _header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Text(
                'Welcome!',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: SizeConfig.textMultiplier * 2,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: user == null
                ? Text(
                'Hamis',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: SizeConfig.textMultiplier * 3.5,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ) :
              Text(
                '${user?.displayName}',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: SizeConfig.textMultiplier * 3.5,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              )
              ,
            ),
          ],
        ),
        SizedBox(height: SizeConfig.heightMultiplier * 3),
        Text(
          'Next Matches',
          style: TextStyle(
            color: AppColors.primaryColor,
            fontSize: SizeConfig.textMultiplier * 2.5,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: SizeConfig.heightMultiplier * 1),
        StreamBuilder<QuerySnapshot>(
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
            return SizedBox(
              height: SizeConfig.heightMultiplier * 12,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: snapshot.data!.docs.map((doc) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 18.0),
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
              ),
            );
          },
        )
      ],
    );
  }

  _posts() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Posts',
              style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: SizeConfig.textMultiplier * 2.5,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('posts').snapshots(),
            builder: (context, snapshot){
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text('No posts available'));
              }
              return ListView(
                children: snapshot.data!.docs.map((doc) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                      width: SizeConfig.widthMultiplier * 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade300)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            child: Container(
                              height: SizeConfig.heightMultiplier * 30,
                              width: SizeConfig.widthMultiplier * 100,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(doc['imageUrl']),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Sockeyway ',
                                    style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: SizeConfig.textMultiplier * 1.5,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text:doc['description'],
                                    style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: SizeConfig.textMultiplier * 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: SizeConfig.heightMultiplier * 4.5,
                            decoration: const BoxDecoration(
                              color: AppColors.primaryColor,
                            ),
                            child: TextButton(
                              onPressed: (){},
                              child: Text(
                                "Comment",
                                style: TextStyle(
                                    color: AppColors.textColor,
                                    fontSize: SizeConfig.textMultiplier * 2,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
                );
            },
          )
        )
      ],
    );
  }
}

class Post {
  final String imageUrl;
  final String description;

  Post(this.imageUrl, this.description);

  Post.fromSnapshot(DocumentSnapshot snapshot)
      : imageUrl = snapshot['imageUrl'],
        description = snapshot['description'];
}
