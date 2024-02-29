import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShaduleCompletedCard extends StatelessWidget {
  String fromlocation,
      toLocation,
      distance,
      price,
      customername,
      customercontactnumber,
      datetime;

  VoidCallback onstart;
  VoidCallback onnavigate;
  ShaduleCompletedCard({
    required this.customercontactnumber,
    required this.customername,
    required this.distance,
    required this.fromlocation,
    required this.price,
    required this.toLocation,
    required this.datetime,
    required this.onstart,
    required this.onnavigate,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.amber[400],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.lock_clock),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Scheduled',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [Text(datetime)],
                ),
              )
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('From - ' + fromlocation),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("To - " + toLocation),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Customer Name -  ' + customername),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    Text('Customer Contact number - ' + customercontactnumber),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: onstart,
                  child: Text('  Complete  '),
                ),
              ),
              SizedBox(width: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: onnavigate,
                  child: Text('  Navigate  '),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
