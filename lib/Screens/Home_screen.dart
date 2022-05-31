import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String quats = "";
  String author = "";
  int indexOfQuote = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Center(child: Text('Quotes App')),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  '$quats',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "- $author",
                      style: TextStyle(fontSize: 18),
                    )),
              ),
              Center(
                child: ElevatedButton(
                  child: Text('Get Quote!'),
                  onPressed: () async {
                    var url = Uri.parse(
                        'http://quotes.stormconsultancy.co.uk/popular.json');
                    // 'https://opentdb.com/api.php?amount=10&category=9&difficulty=medium&type=boolean');
                    var response = await http.post(
                      url,
                    );
                    print('Response status: ${response.statusCode}');
                    // print('Response body: ${response.body}');
                    var data = jsonDecode(response.body);
                    quats = (data[indexOfQuote]["quote"]);
                    author = (data[indexOfQuote]["author"]);

                    setState(() {
                      indexOfQuote++;
                      if (indexOfQuote == data.length - 1) {
                        indexOfQuote = 0;
                      } else {
                        indexOfQuote++;
                      }
                    });
                    print(data.length);

                    // print(incorrect_answers);

                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //       builder: (context) => SecondScreen(
                    //             quote: quats,
                    //             author: author,
                    //           )),
                    // );
                  },
                ),
              ),
            ],
          )),
    );
  }
}
