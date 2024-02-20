import 'package:familydriver/Api/Get_User_Detail_End_Point.dart';
import 'package:familydriver/model/UserModel.dart';
import 'package:flutter/material.dart';

class Mytest extends StatefulWidget {
  const Mytest({super.key});

  @override
  State<Mytest> createState() => _MytestState();
}

class _MytestState extends State<Mytest> {
  late Future<List<User>> _userDetails;
  @override
  void initState() {
    _userDetails = GetUserDetail.getUserDetails(
        '10|A9sKOw7mIBgoL963HV1XLZpFtn538XKAVwKbmE6Ea8c6b04e');
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<User>>(
              future: _userDetails,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text('No data available'),
                  );
                } else {
                  List<User> userDetails = snapshot.data!;

                  return ListView.builder(
                    itemCount: userDetails.length,
                    itemBuilder: (context, index) {
                      User user = userDetails[index];
                      return ListTile(
                        title: Text(user.name),
                        subtitle: Text(user.email),
                        // Add other user details as needed
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
