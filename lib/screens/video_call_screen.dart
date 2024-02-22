import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zoom_meet/resources/auth_methods.dart';
import 'package:zoom_meet/resources/jitsi_meet_methods.dart';
import 'package:zoom_meet/utils/colors.dart';
import 'package:zoom_meet/widgets/meeting_option.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  final AuthMethods _authMethods = AuthMethods();
  late TextEditingController meetingIdController;
  late TextEditingController nameController;
  final JitsiMeetMethods _jitsiMeetMethods = JitsiMeetMethods();

  bool isAudioMuted = true;
  bool isVideoMuted = true;

  @override
  void initState() {
    meetingIdController = TextEditingController();
    nameController = TextEditingController(text: _authMethods.user.displayName);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    meetingIdController.dispose();
    nameController.dispose();
  }

  _joinMeeting() {
    _jitsiMeetMethods.createMeeting(
      roomName: meetingIdController.text.trim(),
      isAudioMuted: isAudioMuted,
      isVideoMuted: isVideoMuted,
      userName: nameController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text(
          'Join a Meeting',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 60,
            child: TextField(
              controller: meetingIdController,
              keyboardType: TextInputType.number,
              maxLines: 1,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                  fillColor: secondaryBackgroundColor,
                  filled: true,
                  hintText: 'Room ID',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.fromLTRB(16, 8, 0, 0)),
            ),
          ),
          SizedBox(
            height: 60,
            child: TextField(
              controller: nameController,
              keyboardType: TextInputType.name,
              maxLines: 1,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                  fillColor: secondaryBackgroundColor,
                  filled: true,
                  hintText: 'Name',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.fromLTRB(16, 8, 0, 0)),
            ),
          ),
          const SizedBox(height: 20),
          CupertinoButton(
            onPressed: _joinMeeting,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Join',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          MeetingOption(
            text: 'Turn off my Audio',
            isMute: isAudioMuted,
            onChange: onAudioMuted,
          ),
          MeetingOption(
            text: 'Turn off my Video',
            isMute: isVideoMuted,
            onChange: onVideoMuted,
          ),
        ],
      ),
    );
  }

  onAudioMuted(bool val) {
    setState(() {
      isAudioMuted = val;
    });
  }

  onVideoMuted(bool val) {
    setState(() {
      isVideoMuted = val;
    });
  }
}
