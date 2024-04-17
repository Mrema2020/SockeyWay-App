import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogBuilder {
  DialogBuilder(this.context);
  final BuildContext context;

  showLoadingIndicator([String? text]) {
    showDialog(
        context: context,
        barrierDismissible: true,
        barrierColor: null,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(3.0),
                ),
              ),
              elevation: 0.0,
              backgroundColor: const Color(0xFF121314).withOpacity(0.5),
              content: LoadingIndicator(text: text),
            ),
          );
        });
  }

  void hideOpenDialog() {
    Navigator.of(context).pop();
  }

  void popDialog() {
    Navigator.of(context, rootNavigator: true).pop();
  }
}

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({this.text = ''});
  final String? text;

  @override
  Widget build(BuildContext context) {
    var displayedText = text!;

    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          _getLoadingIndicator(),
          _getText(displayedText),
          _getHeading(context),
        ],
      ),
    );
  }

  Padding _getLoadingIndicator() {
    return const Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: SizedBox(
        width: 40,
        height: 40,
        child: CircularProgressIndicator(
          strokeWidth: 3.0,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    );
  }

  Widget _getHeading(context) {
    return  const Padding(
      padding: EdgeInsets.only(bottom: 4),
      child: Text(
        'Please wait',
        style: TextStyle(
          color: Colors.white70,
          fontSize: 16,
        ),
      ),
    );
  }

  Text _getText(String displayedText) {
    return Text(
      displayedText,
      style: const TextStyle(color: Colors.white, fontSize: 14),
      textAlign: TextAlign.center,
    );
  }
}