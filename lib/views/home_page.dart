import 'package:flutter/material.dart';
import 'package:flutter_moviedb/widgets/getnowplay_vertical.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Flutter-Movie'.toUpperCase(),
          style: Theme.of(context).textTheme.caption.copyWith(
                color: Colors.black45,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
        ),
        centerTitle: true,
      ),
      body: GetNowPlay(),
    );
  }
}
