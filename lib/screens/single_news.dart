import 'package:flutter/material.dart';
import 'package:sockeyway/utils/size_config.dart';

import '../utils/colors.dart';

class SingleNewsScreen extends StatefulWidget {
  final dynamic imageUrl;
  final dynamic title;
  final dynamic description;
  const SingleNewsScreen({super.key, this.imageUrl, this.title, this.description});

  @override
  State<SingleNewsScreen> createState() => _SingleNewsScreenState();
}

class _SingleNewsScreenState extends State<SingleNewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: SizeConfig.heightMultiplier  * 100,
          width: SizeConfig.widthMultiplier  * 100,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      icon: Container(
                        decoration: const BoxDecoration(
                          color: AppColors.primaryColor,
                          shape: BoxShape.circle
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: Icon(Icons.arrow_back_ios,
                            size: 15,
                              color: AppColors.textColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'News Feed',
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: SizeConfig.textMultiplier * 2.5,
                            fontWeight: FontWeight.bold
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                Image(
                    image: NetworkImage(widget.imageUrl),
                  width: SizeConfig.widthMultiplier  * 100,
                ),
                SizedBox(height: SizeConfig.heightMultiplier  * 3),
                Text(
                  widget.title,
                  style: TextStyle(
                      fontSize: SizeConfig.textMultiplier * 2.5,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor.withOpacity(0.8)),
                ),
                SizedBox(height: SizeConfig.heightMultiplier  * 1),
                Expanded(
                  child: ListView(
                    children: [
                      Text(
                        widget.description,
                        style: TextStyle(
                            fontSize: SizeConfig.textMultiplier * 2,
                            color: AppColors.primaryColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
