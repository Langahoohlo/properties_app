//create a statefull widget
import 'package:flutter/material.dart';

class ChatPilot extends StatefulWidget {
  const ChatPilot({super.key});

  @override
  _ChatPilotState createState() => _ChatPilotState();
}

//chatpilot state
class _ChatPilotState extends State<ChatPilot> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Pilot'),
      ),
      //firebase chat api here
      body: Container(
        child: const Text('Chat Pilot'),
      ),
    );
  }
}
