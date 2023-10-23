import 'package:SoulSync/widgets/utils.dart';
import 'package:flutter/material.dart';

class Message {
  final String text;
  final bool isUser;

  Message(this.text, this.isUser);
}

class PythonChat extends StatefulWidget {
  const PythonChat({super.key});

  @override
  PythonChatState createState() => PythonChatState();
}

class PythonChatState extends State<PythonChat> {
  final TextEditingController _textEditingController = TextEditingController();
  final List<Message> _messages = [];
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0, -1),
            end: Alignment(0, 1),
            colors: [
              Color(0xFF033F50),
              Color(0xC9155465),
              Color(0xD0135163),
              Color(0x6C35778A),
              Color(0x6D357789),
              Color(0x45204853),
              Color(0x45428699),
              Color(0x005AA0B4),
            ],
            stops: [0, 0.208, 0.208, 0.589, 0.76, 0.818, 0.849, 1],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  // therapyQ6B (105:38)
                  margin: EdgeInsets.fromLTRB(
                      0 * fem, 0 * fem, 0 * fem, 34.5 * fem),
                  child: Text(
                    'Personal AI ChatBot',
                    style: SafeGoogleFont(
                      'Inter',
                      fontSize: 39 * ffem,
                      fontWeight: FontWeight.w900,
                      height: 1.2125 * ffem / fem,
                      color: const Color(0xffffffff),
                    ),
                  ),
                ),
                Text(
                  "Write your thoughts and feelings and the AI will give you feedback based on your response.",
                  style: SafeGoogleFont(
                    'Livvic',
                    fontSize: 16 * ffem,
                    color: const Color(0xffffffff),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final message = _messages[index];
                      return Align(
                        alignment: message.isUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisAlignment: message.isUser
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            children: [
                              message.isUser
                                  ? const SizedBox()
                                  : const CircleAvatar(
                                      child: ImageIcon(
                                          AssetImage("images/bot-icon.png"))),
                              Container(
                                decoration: BoxDecoration(
                                    color: message.isUser
                                        ? Colors.grey
                                        : Colors.blueGrey,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Container(
                                  width: message.isUser
                                      ? 200
                                      : MediaQuery.of(context).size.width - 150,
                                  padding: const EdgeInsets.all(8.0),
                                  margin: const EdgeInsets.all(4.0),
                                  child: Text(
                                    message.text,
                                    softWrap: true,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                TextField(
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    hintText: "Enter your message",
                    suffix: IconButton(
                        onPressed: () {
                          if (_textEditingController.text != "") {
                            sendMessage(_textEditingController.text);
                          }
                        },
                        icon: const Icon(
                          Icons.send,
                          color: Colors.blueGrey,
                        )),
                  ),
                  // onSubmitted: ,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  sendMessage(String userInput) {
    _textEditingController.clear();
    String response = "";

    _messages.add(Message(userInput, true));

    List<String> words = userInput.toLowerCase().split(' ');

    double sentimentScore = 0.0;
    if (words.contains("Hi") ||
        words.contains("Hello") ||
        words.contains("Hey") ||
        words.contains("hi") ||
        words.contains("hello") ||
        words.contains("hey")) {
      response = "Hello! How can I assist you today?";
    } else {
      if (words.contains("quit") && words.contains("life")) {
        sentimentScore = -3.0;
      }

      if (words.contains("hate") && words.contains("life")) {
        sentimentScore = -3.0;
      }

      if (words.contains("pressure") &&
          words.contains("handle") &&
          (words.contains("can't") ||
              words.contains("can") ||
              words.contains("not"))) {
        sentimentScore = -3.0;
      }

      if (words.contains("pressure") &&
          words.contains("unable") &&
          (words.contains("can't") ||
              words.contains("can") ||
              words.contains("not"))) {
        sentimentScore = -3.0;
      }

      if (words.contains("quit") &&
          words.contains("want") &&
          words.contains("to")) {
        sentimentScore = -3.0;
      }
      if (sentimentScore <= -3.0) {
        response =
            "I'm really sorry to hear that you're feeling this way. It's important to talk to someone who can help. Consider reaching out to a mental health professional or a support hotline for immediate assistance.";
      } else if (sentimentScore <= -0.3 && sentimentScore > -3.0) {
        response =
            "I'm here to listen. Please remember that you're not alone. It's crucial to seek support from a therapist or a trusted friend or family member. They can provide you with the help and care you need.";
      } else if (sentimentScore <= 0.0 && sentimentScore >= -0.3) {
        if (words.contains("help")) {
          response =
              "I'm glad you're reaching out for help. You're taking a positive step.";
        } else if (words.contains("lonely") || words.contains("alone")) {
          response =
              "Feeling lonely can be tough. It's essential to connect with friends or loved ones.";
        } else {
          response =
              "I'm sorry to hear that. Can you tell me more about what's on your mind?";
        }
      }
    }
    _messages.add(Message(response, false));
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );

    setState(() {});
  }
}
