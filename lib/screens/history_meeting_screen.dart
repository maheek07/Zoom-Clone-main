import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zoom_meet/resources/firestore_methods.dart';
import 'package:zoom_meet/utils/colors.dart';

class HistoryMeetingScreen extends StatelessWidget {
  const HistoryMeetingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: backgroundColor,
        title: const Text('Meeting History'),
      ),
      body: StreamBuilder(
          stream: FirestoreMethods().meetingHistory,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            
            return ListView.builder(
              itemCount: (snapshot.data! as dynamic).docs.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(
                  'Room Id: ${(snapshot.data! as dynamic).docs[index]['meetingName']}',
                ),
                subtitle: Text(
                  'Joined On: ${DateFormat.yMMMMd().format((snapshot.data! as dynamic).docs[index]['createdAt'].toDate())}',
                ),
                trailing: IconButton(
                  onPressed: () {
                    FirestoreMethods().deleteMeetingHistory(snapshot.data!.docs[index].id);
                  },
                  icon: const Icon(Icons.delete),
                ),
              ),
            );
          }),
    );
  }
}
