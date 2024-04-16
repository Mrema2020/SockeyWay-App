import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/size_config.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: SizeConfig.widthMultiplier * 100,
          height: SizeConfig.heightMultiplier * 100,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _newsFeed())
              ],
            ),
          ),
        ),
      ),
    );
  }

  _newsFeed(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Latest News',
          style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: SizeConfig.textMultiplier * 2.5,
              fontWeight: FontWeight.bold
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: SizeConfig.heightMultiplier * 1),
        Expanded(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('news').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
                if (!snapshot.hasData) {
                  return const Center(child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  ));
                }
                return ListView(
                  children: snapshot.data!.docs.map((doc) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: SizeConfig.widthMultiplier * 100,
                        height: SizeConfig.heightMultiplier * 15,
                        child: Row (
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: SizeConfig.widthMultiplier * 40,
                              height: SizeConfig.heightMultiplier * 20,
                              alignment: Alignment.center,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(doc['imageUrl'],
                                  fit: BoxFit.cover,
                                  height: SizeConfig.heightMultiplier * 20,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      doc['title'],
                                      style: TextStyle(
                                          color: AppColors.primaryColor.withOpacity(0.5),
                                          fontSize: SizeConfig.textMultiplier * 2,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    SizedBox(height: SizeConfig.heightMultiplier * 1),
                                    Text(
                                      getFirstTenWords(doc['description']),
                                      style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: SizeConfig.textMultiplier * 2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList()
                );
              }),
        )
      ],
    );
  }

  String getFirstTenWords(String paragraph) {
    // Split the paragraph into words
    List<String> words = paragraph.split(' ');

    // Take the first 10 words
    List<String> firstTenWords = words.take(10).toList();

    // Join the first 10 words back into a single string
    String result = firstTenWords.join(' ');

    return result;
  }
}
