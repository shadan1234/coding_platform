import 'dart:convert';

import 'package:coding_platform/data/question_answer_data.dart';
import 'package:coding_platform/database/database_helper.dart';
import 'package:coding_platform/pages/question_ans.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';



class ChatBot extends StatefulWidget {
  const ChatBot({Key? key}) : super(key: key);

  @override
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {

  final TextEditingController _textController = TextEditingController();
  late Future<List<QuestionAnswerPair>> pairs ;

  Future<String> callAPI() async {
    final String apiUrl =
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=AIzaSyB8I-R-oDmMAVmoYtm21sB4FR1Hbs_fFs4";

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final Map<String, dynamic> requestBody = {
      "contents": [
        {
          "parts": [
            {
              "text": "${_textController.text}"
            }
          ]
        }
      ]
    };

    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      final some=jsonDecode(response.body)['candidates'][0]['content']['parts'][0]['text'];
      print(some); // Output the response body (JSON) to the console
      return some;
      // Handle the response data here
    } else {
      throw Exception('Failed to call API: ${response.statusCode}');
    }
  }
  Future<List<QuestionAnswerPair>> fetchDataFromDB() async{
    DatabaseHelper databaseHelper=DatabaseHelper();
    pairs=databaseHelper.getQuestionAnswerList();
    // final questionAnswerData=Provider.of<QuestionAnswerData>(context);
    // questionAnswerData.qaPair=await pairs;
    return pairs;
  }
@override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
  pairs=fetchDataFromDB();
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: pairs,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        }else if(snapshot.hasError)
          return Center(child: Text('${snapshot.error}'),);
        else
        return Scaffold(
          appBar: AppBar(
            title: Text('Chat Bot'),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  // reverse: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Question: ${snapshot.data[index].question}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text('Answer: ${snapshot.data[index].answer}'),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Divider(height: 1),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _textController,
                          decoration: InputDecoration(
                            hintText: 'Enter your question...',
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: ()async {
                        String ans= await callAPI();
                        DatabaseHelper database =DatabaseHelper();

                        await database.insertQuestionAnswer(QuestionAnswerPair(question: _textController.text, answer: ans));
                        setState(() {
                          // Add a new QuestionAnswerPair with the entered question and an empty answer
                          snapshot.data.add(

                            QuestionAnswerPair(
                              question: _textController.text,
                              answer: ans,
                            ),
                          );
                          _textController.clear();
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },

    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
