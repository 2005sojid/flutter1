import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter1/components/chat_bubble.dart';
import 'package:flutter1/components/my_textfield.dart';
import 'package:flutter1/services/auth/auth_service.dart';
import 'package:flutter1/services/chat/chat_service.dart';

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverId;
  ChatPage({super.key, required this.receiverEmail, required this.receiverId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();

  final AuthService authService = AuthService();

  final ChatService chatService = ChatService();

  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
scrollDown();
      }
    });
        Future.delayed(const Duration(milliseconds: 500), () => scrollDown());

  }

  @override
  void dispose() {
    myFocusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  final ScrollController _scrollController = ScrollController();

  void scrollDown() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
  }

  void sendMessage() async {
    if (_controller.text.isNotEmpty) {
      await chatService.sendMessage(widget.receiverId, _controller.text);

      _controller.clear();
       scrollDown();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(widget.receiverEmail),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      body: Column(
        children: [Expanded(child: _buildMessageList()), _buildMessageInput()],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderId = authService.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: chatService.getMessages(widget.receiverId, senderId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Error");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading...');
          }

          return ListView(
            controller: _scrollController,
            children: snapshot.data!.docs
                .map((doc) => _buildMessageItem(doc))
                .toList(),
          );
        });
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool isCurrentUser = data['senderId'] == authService.getCurrentUser()!.uid;
    var align = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
        alignment: align,
        child: Column(
          crossAxisAlignment:
              isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            ChatBubble(isCurrentUser: isCurrentUser, message: data['message'])
          ],
        ));
  }

  Widget _buildMessageInput() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: MyTextField(
                focusNode: myFocusNode,
                controller: _controller,
                textHint: 'Type a message',
                obscureText: false,
              ),
            ),
            Container(
                decoration: const BoxDecoration(
                    color: Colors.green, shape: BoxShape.circle),
                margin: const EdgeInsets.only(right: 25.0),
                child: IconButton(
                    onPressed: sendMessage,
                    icon: const Icon(Icons.arrow_upward)))
          ],
        ),
        const SizedBox(
          height: 5,
        )
      ],
    );
  }
}
