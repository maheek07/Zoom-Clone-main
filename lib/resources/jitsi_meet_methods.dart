import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
import 'package:zoom_meet/resources/auth_methods.dart';
import 'package:zoom_meet/resources/firestore_methods.dart';

class JitsiMeetMethods {
  final AuthMethods _authMethods = AuthMethods();
  final FirestoreMethods _firestoreMethods = FirestoreMethods();
  void createMeeting({
    required String roomName,
    required bool isAudioMuted,
    required bool isVideoMuted,
    String userName = '',
  }) async {
    try {
      String name;
      if (userName.isEmpty) {
        name = _authMethods.user.displayName!;
      } else {
        name = userName;
      }
      var options = JitsiMeetConferenceOptions(
        room: roomName,
        userInfo: JitsiMeetUserInfo(
          displayName: name,
          email: _authMethods.user.email,
          avatar: _authMethods.user.photoURL,
        ),
        configOverrides: {
          "startWithAudioMuted": isAudioMuted,
          "startWithVideoMuted": isVideoMuted,
        },
      );
      _firestoreMethods.addToMeetingHistory(roomName);
      var jitsiMeet = JitsiMeet();
      await jitsiMeet.join(options);
    } catch (e) {
      print(e.toString());
    }
  }
}
