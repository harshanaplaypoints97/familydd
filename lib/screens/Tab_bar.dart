import 'package:flutter/material.dart';

class TripDetails extends StatefulWidget {
  const TripDetails({super.key});

  @override
  State<TripDetails> createState() => _TripDetailsState();
}

class _TripDetailsState extends State<TripDetails> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tab bar'),
        ),
        body: Column(
          children: [
            TabBar(tabs: [
              Tab(
                icon: Icon(
                  Icons.pending,
                  color: Colors.black,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.join_right,
                  color: Colors.black,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.cancel,
                  color: Colors.black,
                ),
              ),
            ]),
            Expanded(
              child: TabBarView(children: [
                Container(
                  color: Colors.amber,
                  child: Center(
                    child: Text('1st Tab'),
                  ),
                ),
                Container(
                  color: Colors.black,
                  child: Center(
                    child: Text('1st Tab'),
                  ),
                ),
                Container(
                  color: Colors.blue,
                  child: Center(
                    child: Text('1st Tab'),
                  ),
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
