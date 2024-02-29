import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Schedule_RiderCard extends StatelessWidget {
  String fromlocation,
      toLocation,
      distance,
      price,
      customername,
      customercontactnumber,
      datetime;

  VoidCallback onaccept;
  VoidCallback oncancled;
  Schedule_RiderCard({
    required this.customercontactnumber,
    required this.customername,
    required this.distance,
    required this.fromlocation,
    required this.price,
    required this.toLocation,
    required this.datetime,
    required this.onaccept,
    required this.oncancled,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('From - ' + fromlocation),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("To - " + toLocation),
                ),
              ],
            ),
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
                  onPressed: onaccept,
                  child: Text('  Accept  '),
                ),
              ),
              SizedBox(width: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: oncancled,
                  child: Text('  Cancel  '),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
