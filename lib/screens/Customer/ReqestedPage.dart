import 'package:animate_do/animate_do.dart';
import 'package:familydriver/constant/App_color.dart';
import 'package:familydriver/screens/widgets/Rouned_boutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ReqestedPage extends StatefulWidget {
  String token, fromloaction, tolocation;
  double startlongitude, startlatitude, endlatitude, endlongitude, distance;
  int customerid, driver_id;
  ReqestedPage({
    super.key,
    required this.token,
    required this.endlatitude,
    required this.endlongitude,
    required this.startlatitude,
    required this.startlongitude,
    required this.fromloaction,
    required this.tolocation,
    required this.distance,
    required this.customerid,
    required this.driver_id,
  });

  @override
  State<ReqestedPage> createState() => _ReqestedPageState();
}

class _ReqestedPageState extends State<ReqestedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: ZoomIn(
              child: Container(
                height: 400,
                width: 400,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200),
                    border: Border.all(
                      color: Colors.yellow,
                      width: 2,
                    )),
                child: Center(
                  child: Container(
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                        border: Border.all(
                          color: Colors.yellow,
                          width: 2,
                        )),
                    child: Center(
                      child: Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              color: Colors.yellow,
                              width: 2,
                            )),
                        child: Center(
                          child: Container(
                            child: Image.asset(
                              'assets/DriverPic.png',
                              fit: BoxFit.cover,
                            ),
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  color: Colors.yellow,
                                  width: 2,
                                )),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Reqesting.....",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
          ),
          Center(
            child: LoadingAnimationWidget.newtonCradle(
              color: Colors.yellow,
              size: 100,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: RoundedButton(
                buttonText: widget.customerid.toString(),
                onPress: () {},
                color: Colors.green),
          )
        ],
      ),
    );
  }
}
