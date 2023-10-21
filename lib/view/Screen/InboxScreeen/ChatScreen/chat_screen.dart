import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal:16.w),
              itemCount: 10, // Replace with actual message count
              itemBuilder: (context, index) {
                return ChatMessage('Hello', isMe: index % 2 == 0);
              },
            ),
          ),
          const Divider(height: 1.0),
          _buildInputField(),
        ],
      ),
    );
  }

  Widget _buildInputField() {
    return Container(
      margin:  EdgeInsets.symmetric(horizontal: 8.w),
      child: Row(
        children: [
          const Expanded(
            child: TextField(
              decoration: InputDecoration.collapsed(
                hintText: 'Type your message...',
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              // Send message logic
            },
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isMe;

  const ChatMessage(this.text, {super.key, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  EdgeInsets.symmetric(vertical:5.h),
      child: Row(
        mainAxisAlignment:
        isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe) ...[

            CircleAvatar(
              radius: 20.r,
              backgroundColor: Colors.grey,
              // backgroundImage: AssetImage('assets/profile_image_me.png'),
            ),
            SizedBox(width:8.w),
          ],
          Container(
            padding:  EdgeInsets.all(10.sp),
            decoration: BoxDecoration(
              color: isMe ? Colors.blue : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              text,
              style: TextStyle(
                color: isMe ? Colors.white : Colors.black,
              ),
            ),
          ),
          if (isMe) ...[
            SizedBox(width:8.w),
            CircleAvatar(
              radius: 20.r,
              backgroundColor: Colors.grey,
              // backgroundImage: AssetImage('assets/profile_image_me.png'),
            ),
          ],
        ],
      ),
    );
  }
}