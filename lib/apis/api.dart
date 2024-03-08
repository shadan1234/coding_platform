// // Get the current time in milliseconds since the Unix epoch
// DateTime currentTimeUtc = DateTime.now().toUtc();
//
// // Adjust the current time to Moscow Standard Time (UTC+3)
// DateTime moscowTime = currentTimeUtc.subtract(Duration(hours: 5,minutes: 30));
//
// // Convert the adjusted time to Unix timestamp (seconds since the Unix epoch)
// int unixTimestamp = moscowTime.millisecondsSinceEpoch ~/ 1000;
// // Generate the apiSig
// String baseUrl='https://codeforces.com/api';
// String apiKey = '5c92d67b2893de7e5c13bcdb75bcea680661f5b8';
// String secret = 'b977c23339063af145f6d7f3cdd7fba9dedb3b24';
// String rand = '234567'; // Choose random 6 characters
// String methodName = 'user.info';
// // String methodName = 'contest.hack';
// String parameters = 'handles=shadan122'; // Add other parameters as needed
// // String parameters = ''; // Add other parameters as needed
// // String parameters = 'contestId=566'; // Add other parameters as needed
// String concatenatedString = '$rand/$methodName?$apiKey&$parameters&$unixTimestamp#$secret';
// String hashedString = sha512.convert(utf8.encode(concatenatedString)).toString();
// String apiSig = '$rand$hashedString';
// String req='$baseUrl/$methodName?$parameters&$apiKey&$unixTimestamp&$apiSig';
//
// print('Generated apiSig: $apiSig');
// print("Final call: $req");
import 'dart:convert';

import 'package:http/http.dart' as http;

class Api{
 static const String BaseUrl='https://codeforces.com/';
 static const String userInfo='api/user.info?handles=shadan122;&checkHistoricHandles=false';
 static const String userSubmissions='api/user.status?handle=shadan122&from=1&count=20';
 static const String contestList='api/contest.list';
 static const String contestPage='contest';


}

// void main() async{
//  print('hello');
//  http.Response response =await http.get(Uri.parse('https://codeforces.com/api/user.info?handles=shadan122;&checkHistoricHandles=false'));
//  Map<String,dynamic> mp= jsonDecode(response.body) as Map<String,dynamic>;
//  print(mp["result"][0]["firstName"]);
// }