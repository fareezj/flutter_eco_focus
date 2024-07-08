import 'package:eco_focus/shared/widgets/text_widgets.dart';
import 'package:flutter/material.dart';

class CustomDialog {
  void confirmDialog({
    required BuildContext context,
    required String content,
    required VoidCallback onProceed,
    required VoidCallback onCancel,
  }) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextWidgets.titleText(text: 'Alert!'),
              const SizedBox(height: 15),
              TextWidgets.secondaryTitleText(
                text: content,
                textAlign: TextAlign.center,
                fontSize: 16.0,
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: onCancel,
                    child: const Text('Close'),
                  ),
                  TextButton(
                    onPressed: onProceed,
                    child: const Text('Proceed'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void infoDialog({
    required BuildContext context,
    required String title,
    required String content,
    required VoidCallback onProceed,
  }) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextWidgets.titleText(text: title),
              const SizedBox(height: 15),
              TextWidgets.secondaryTitleText(
                text: content,
                textAlign: TextAlign.center,
                fontSize: 16.0,
              ),
              const SizedBox(height: 15),
              Center(
                child: TextButton(
                  onPressed: onProceed,
                  child: const Text('Proceed'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
