import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ActivityCancled extends StatelessWidget {
  String fromlocation,
      toLocation,
      distance,
      price,
      customername,
      customercontactnumber,
      datetime;

  ActivityCancled({
    required this.customercontactnumber,
    required this.customername,
    required this.distance,
    required this.fromlocation,
    required this.price,
    required this.toLocation,
    required this.datetime,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromARGB(255, 241, 99, 99),
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
                    child: Icon(Icons.car_crash_sharp),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Trip Cancled',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [Text(datetime)],
                ),
              )
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
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
                child: Text('Customer Name - ' + customername),
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
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Price',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'LKR ' + price,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
