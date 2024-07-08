import 'package:eco_focus/features/liveSession/live_session_view_model.dart';
import 'package:eco_focus/models/session/session_model.dart';
import 'package:eco_focus/shared/widgets/custom_dialog.dart';
import 'package:eco_focus/shared/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LiveSessionScreen extends StatefulWidget {
  final String selectedCategory;
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
      setDuration = _parseDuration(widget.selectedTime);
    });

    _animationController =
        AnimationController(vsync: this, duration: setDuration);

    _animationController.addListener(() {
      setState(() {});
      if (_animationController.isCompleted) {
        print('Completed!');
        _onSaveSession();
      }
    });

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
    final liveSessionViewModel =
        Provider.of<LiveSessionViewModel>(context, listen: false);
    liveSessionViewModel
        .saveSession(
          SessionModel(
              id: '2',
              name: 'test',
              categoryId: '2',
              targetTime: widget.selectedTime.toString(),
              focusedTime: widget.selectedTime.toString(),
              createdTime: DateTime.now().toString(),
              createdDate: DateTime.now().toString(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                TextWidgets.titleText(text: widget.selectedCategory),
                TextWidgets.secondaryTitleText(
                    text: 'Target Time: ${widget.selectedTime}'),
                const SizedBox(height: 50.0),
                SizedBox(
                  height: 200,
                  width: 200,
                  child: CircularProgressIndicator(
                    value: _animationController.value,
                    strokeWidth: 20,
                    backgroundColor: Colors.grey,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
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
                      onPressed: () => value.saveSession(SessionModel(
                          id: '1',
                          name: 'test',
                          categoryId: '1',
                          targetTime: widget.selectedTime.toString(),
                          focusedTime: widget.selectedTime.toString(),
                          createdTime: DateTime.now().toString(),
                          createdDate: DateTime.now().toString(),
                          treeGrowthLevel: "1")),
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
    super.dispose();
    _animationController.dispose();
  }
}
