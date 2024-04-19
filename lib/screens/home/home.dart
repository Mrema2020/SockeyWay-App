import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sockeyway/utils/size_config.dart';

import '../../utils/colors.dart';
import '../dialogs/dialo_builder.dart';

class HomePage extends StatefulWidget {
  final dynamic username;
  const HomePage({super.key, this.username});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  User? user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _commentController = TextEditingController();
  String? postId;
  bool isLoading = false;


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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Text(
                'Sockeyway App',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: SizeConfig.textMultiplier * 2.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
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
                const Icon(
                  CupertinoIcons.person_alt_circle,
                  color: AppColors.primaryColor,
                  size: 30,
                )
              ],
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
                          StreamBuilder<QuerySnapshot>(
                              stream: _firestore.collection("posts").doc(doc.id).collection('comments').snapshots(),
                              builder: (context, snapshot){
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Center(child: Container());
                                }

                                if (snapshot.hasError) {
                                  return Center(child: Container());
                                }

                                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 8.0, bottom: 5),
                                    child: Text('${snapshot.data!.docs.length} comments',
                                      style: TextStyle(
                                          color: AppColors.primaryColor.withOpacity(0.4),
                                          fontSize: SizeConfig.textMultiplier * 2,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  );
                                }
                                return Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "${snapshot.data!.docs.length} Comments",
                                    style: TextStyle(
                                        color: AppColors.primaryColor.withOpacity(0.5),
                                        fontSize: SizeConfig.textMultiplier * 2,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                );
                              }
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: SizeConfig.heightMultiplier * 4.5,
                              decoration:   BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(5)
                              ),
                              child: TextButton(
                                onPressed: (){
                                  showBottomSheet(
                                      context: context,
                                      builder: (_) => _commentSection(doc.id)
                                  );
                                },
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

  _commentSection(postId){
    return SizedBox(
      width: SizeConfig.widthMultiplier * 100,
      child: Stack(
        children: [
          Positioned(
            top: SizeConfig.heightMultiplier * 1,
            left: SizeConfig.widthMultiplier * 40,
            child: Column(
              children: [
                Container(
                  width: SizeConfig.widthMultiplier * 15,
                  height: SizeConfig.heightMultiplier * 0.3,
                  color: AppColors.primaryColor.withOpacity(0.5),
                ),
                SizedBox( height: SizeConfig.heightMultiplier * 1),
                Text(
                  'Comments',
                  style: TextStyle(
                      fontSize: SizeConfig.textMultiplier * 2.5,
                      color: AppColors.primaryColor.withOpacity(0.7),
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox( height: SizeConfig.heightMultiplier * 5),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: _firestore.collection("posts").doc(postId).collection('comments').snapshots(),
                    builder: (context, snapshot){
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }

                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(child: Text('No comment',
                            style: TextStyle(
                                fontSize: SizeConfig.textMultiplier * 2,
                                color: AppColors.primaryColor.withOpacity(0.5),
                                fontWeight: FontWeight.bold)
                        ));
                      }
                      return SizedBox(
                        height: SizeConfig.heightMultiplier * 30,
                        child: ListView(
                          children: snapshot.data!.docs.map((doc) {
                            return  Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 8.0),
                                      child: Icon(CupertinoIcons.person_alt_circle,
                                        color: AppColors.primaryColor.withOpacity(0.7),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            doc['username'],
                                            style: TextStyle(
                                                color: AppColors.primaryColor,
                                                fontSize: SizeConfig.textMultiplier * 1.8,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                          Text(
                                            doc['text'],
                                            style: TextStyle(
                                                color: AppColors.primaryColor,
                                                fontSize: SizeConfig.textMultiplier * 1.8
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }).toList()
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: SizeConfig.widthMultiplier * 100,
                      child: Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Icon(CupertinoIcons.person_alt_circle,
                              color: AppColors.primaryColor.withOpacity(0.7),
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                width: SizeConfig.widthMultiplier * 70,
                                child: TextField(
                                  controller: _commentController,
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        fontSize: SizeConfig.textMultiplier * 1.8,
                                        color: AppColors.primaryColor
                                            .withOpacity(0.6)),
                                    hintText: 'Add Comment for sockeyway',
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.primaryColor
                                              .withOpacity(0.1)),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.primaryColor
                                              .withOpacity(0.2)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: GestureDetector(
                                onTap: (){
                                  _validate(postId);
                                },
                                child: Container(
                                  height: SizeConfig.heightMultiplier * 4.5,
                                  width: SizeConfig.widthMultiplier * 25,
                                  decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: isLoading
                                      ? const Center(child: CircularProgressIndicator(color: AppColors.textColor))
                                      : Center(
                                    child: Text(
                                      "Post",
                                      style: TextStyle(
                                          color: AppColors.textColor,
                                          fontSize: SizeConfig.textMultiplier * 2,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
                // SizedBox(height: SizeConfig.heightMultiplier * 2),

                SizedBox(height: SizeConfig.heightMultiplier * 2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _validate(postId){
    if(_commentController.text.trim() == ""){
      Flushbar(
        title: "Error",
        message: "Please provide your comment",
        duration: const Duration(seconds: 3),
        backgroundColor: const Color(0Xffc71f37),
        flushbarPosition: FlushbarPosition.TOP,
        margin: const EdgeInsets.all(15),
        icon: const Icon(
          Icons.warning,
          color: Colors.white,
        ),
      ).show(context);
    }else{
      _addComment(_commentController.text, postId);
    }
  }

  Future<void> _addComment(String commentText, String postId, ) async {
    try {
      DialogBuilder(context).showLoadingIndicator('Posting..');
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance.collection('posts').doc(postId).collection('comments').add({
          'text': commentText,
          'userId': user.uid,
          'username': user.displayName,
          'timestamp': FieldValue.serverTimestamp(),
        });
        _commentController.clear();
        DialogBuilder(context).hideOpenDialog();
        Navigator.pop(context);
      } else {
        DialogBuilder(context).hideOpenDialog();
        // Handle user not signed in
      }
    } catch (e) {
      DialogBuilder(context).hideOpenDialog();
      print('Error adding comment: $e');
      // Handle error
    }
  }

}

