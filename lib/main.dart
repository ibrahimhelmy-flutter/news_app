import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/views/buble_bottom_navigation.dart';
import 'package:news_app/views/home_page.dart';

void main() => runApp(MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => AwsomeBottomNavigation(),
      },
    ));
