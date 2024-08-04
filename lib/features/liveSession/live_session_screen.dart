import 'dart:io';

import 'package:eco_focus/features/liveSession/live_session_view_model.dart';
import 'package:eco_focus/features/treeGrowth/tree_growth_widget.dart';
import 'package:eco_focus/models/category/category_model.dart';
import 'package:eco_focus/models/session/session_model.dart';
import 'package:eco_focus/shared/widgets/custom_dialog.dart';
import 'package:eco_focus/shared/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/v4.dart';

class LiveSessionScreen extends StatefulWidget {
  final CategoryModel selectedCategory;
  final String selectedTime;
  const LiveSessionScreen({
    super.key,
    required this.selectedCategory,
    required this.selectedTime,
  });

  @override
  State<LiveSessionScreen> createState() => _LiveSessionScreenState();
}

class _LiveSessionScreenState extends State<LiveSessionScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  Duration setDuration = const Duration();

  @override
  void initState() {
    super.initState();

    setState(() {
      setDuration = _parseDuration("10:10");
    });

    _animationController =
        AnimationController(vsync: this, duration: setDuration);

    _animationController.addListener(() {
      setState(() {});
      if (_animationController.isAnimating) {
        //setState(() => growthLevel = _animationController.value.toInt());
        if (_parseTimer((setDuration * (1 - _animationController.value))) ==
            "10:04") {
          setState(() => growthLevel = 2);
        }
        if (_parseTimer((setDuration * (1 - _animationController.value))) ==
            "09:50") {
          setState(() => growthLevel = 3);
        }
        if (_parseTimer((setDuration * (1 - _animationController.value))) ==
            "09:40") {
          setState(() => growthLevel = 4);
        }
        if (_parseTimer((setDuration * (1 - _animationController.value))) ==
            "09:30") {
          setState(() => growthLevel = 5);
        }
        if (_parseTimer((setDuration * (1 - _animationController.value))) ==
            "09:20") {
          setState(() => growthLevel = 6);
        }
        if (_parseTimer((setDuration * (1 - _animationController.value))) ==
            "09:10") {
          setState(() => growthLevel = 7);
        }
      }
      if (_animationController.isCompleted) {
        print('Completed!');
        _onSaveSession();
      }
    });

    // Start session
    _animationController.forward();
  }

  Duration _parseDuration(String duration) {
    List<String> parts = duration.split(':');
    int minutes = int.parse(parts[0]);
    int seconds = int.parse(parts[1]);
    return Duration(minutes: minutes, seconds: seconds);
  }

  String _parseTimer(Duration duration) {
    String minutes = duration.inMinutes.toString().padLeft(2, '0');
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  _onCancel(BuildContext context) {
    _stopTimer();
    CustomDialog().confirmDialog(
      context: context,
      content: "This session will be removed.",
      onProceed: () {
        Navigator.pop(context);
        Navigator.pop(context);
      },
      onCancel: () {
        Navigator.pop(context);
        _startTimer();
      },
    );
  }

  _onSaveSession() {
    var id = const UuidV4().generate();
    final liveSessionViewModel =
        Provider.of<LiveSessionViewModel>(context, listen: false);
    // TODO: CHANGE DATE
    liveSessionViewModel
        .saveSession(
          SessionModel(
              id: id.toString(),
              name: widget.selectedCategory.name,
              categoryId: widget.selectedCategory.name,
              targetTime: widget.selectedTime.toString(),
              focusedTime: widget.selectedTime.toString(),
              createdTime:
                  DateTime.now().add(const Duration(days: 1)).toString(),
              createdDate:
                  DateTime.now().add(const Duration(days: 6)).toString(),
              treeGrowthLevel: "1"),
        )
        .then(
          (a) => CustomDialog().infoDialog(
            context: context,
            title: 'Session Completed!',
            content: 'You have completed your focus session.',
            onProceed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
        );
  }

  void _startTimer() => _animationController.forward();
  void _stopTimer() => _animationController.stop();
  void _restartTimer() => _animationController.forward(from: 0);
  var growthLevel = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                TextWidgets.titleText(text: widget.selectedCategory.name),
                TextWidgets.secondaryTitleText(
                    text: 'Target Time: ${widget.selectedTime}'),
                const SizedBox(height: 50.0),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      child: SizedBox(
                        height: 250.0,
                        width: 250.0,
                        child: CircularProgressIndicator(
                          value: _animationController.value,
                          strokeWidth: 20,
                          backgroundColor: Colors.grey,
                          valueColor:
                              const AlwaysStoppedAnimation<Color>(Colors.blue),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 250,
                      width: 250,
                      child: TreeGrowthWidget(growthLevel: growthLevel),
                    ),
                  ],
                ),
                const SizedBox(height: 40.0),
                TextWidgets.titleText(
                  text: _parseTimer(
                      (setDuration * (1 - _animationController.value))),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 70.0, vertical: 50.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () => _onCancel(context),
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          CustomDialog().infoDialog(
                            context: context,
                            title: 'Session Completed!',
                            content: 'You have completed your focus session.',
                            onProceed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                          );
                        },
                        child: const Text('Start'),
                      ),
                    ],
                  ),
                ),
                Consumer<LiveSessionViewModel>(
                  builder: (context, value, child) {
                    return ElevatedButton(
                      onPressed: () => _onSaveSession(),
                      child: const Text('Save'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
