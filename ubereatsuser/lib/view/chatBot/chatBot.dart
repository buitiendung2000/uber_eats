import 'dart:io';
import 'dart:typed_data';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:image_picker/image_picker.dart';
 
class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});
  

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  ChatUser currentUser=ChatUser(id: "0",firstName: "User");
  ChatUser geminiUser=ChatUser(id: "1",firstName: "Gemini");
  List<ChatMessage> messages=[];
  final Gemini gemini =Gemini.instance;
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(centerTitle: true,title: const Text("Gemini Chat"),),
      body: _buildUI(),
    );
  }
  Widget _buildUI(){
     return DashChat(inputOptions: InputOptions(trailing: [
      IconButton(onPressed: (){
        _sendMediaMessage();
      }, icon: Icon(Icons.image))
     ]),currentUser: currentUser, onSend: _sendMessage, messages: messages);
         
      
      
  }
  void _sendMediaMessage()async{
    ImagePicker picker =ImagePicker();
    XFile? file =await picker.pickImage(source: ImageSource.gallery);
    if (file!=null) {
      ChatMessage chatMessage =ChatMessage(user: currentUser, createdAt: DateTime.now(),text: "Hỗ trợ đặt hàng",
      medias: [ChatMedia(url: file.path, fileName: "", type: MediaType.image)]);
      
      _sendMessage(chatMessage);
    }
  }
  void _sendMessage(ChatMessage chatMessage){
    setState(() {
      messages=[chatMessage,...messages];
    });
    try {
      String question =chatMessage.text;
      List<Uint8List>?images;
      if (chatMessage.medias?.isNotEmpty??false) {
        images=[File(chatMessage.medias![0].url).readAsBytesSync()];
      }
      gemini.streamGenerateContent(question,images: images).listen((event) {
        ChatMessage? lastMessage =messages.firstOrNull;
        if (lastMessage != null&& lastMessage.user==geminiUser) {
          lastMessage =messages.removeAt(0);
           String response =event.content?.parts?.fold("", (previous, current) => "$previous${current.text}")??"";
           lastMessage.text=response;
           setState(() {
             messages=[lastMessage!,...messages];
           });
        }else{
          String response =event.content?.parts?.fold("", (previous, current) => "$previous${current.text}")??"";
          ChatMessage message =ChatMessage(user: geminiUser, createdAt: DateTime.now(),text: response);
           
           setState(() {
          messages=[message, ...messages]; 
        });
        };
        
      });
    } catch (e) {
      print(e);
    }
  }
}