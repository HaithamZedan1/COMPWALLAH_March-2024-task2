import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../controller/question_controller.dart';
import 'customButton.dart';

class LeaderboardScreen extends StatelessWidget {
  static const routeName = '/leaderboard_screen';

  const LeaderboardScreen({Key? key}) : super(key: key);

  Future<List<dynamic>> fetchLeaderboardData() async {
    final response =
    await http.get(Uri.parse('http://dreamlo.com/lb/65fde4168f40c40fa414b856/json'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> leaderboardData = data['dreamlo']['leaderboard']['entry'];
      return leaderboardData;
    } else {
      throw Exception('Failed to load leaderboard data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Leaderboard'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: fetchLeaderboardData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  print('Error: ${snapshot.error}');
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  List<dynamic> leaderboardData = snapshot.data!;
                  return Container(
                    child: ListView.builder(
                      itemCount: leaderboardData.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            leaderboardData[index]['name'],
                            style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white),
                          ),
                          subtitle: Text(
                            'Score: ${leaderboardData[index]['score']}',
                            style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ),
          Container(
              child:CustomButton(
            onPressed: () {
              Get.find<QuestionController>().startAgain();
            },
            text: 'Start Again',
          )),
        ],
      ),
    );
  }
}
