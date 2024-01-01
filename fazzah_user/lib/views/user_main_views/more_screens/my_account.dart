import 'package:fazzah_user/models/user_model.dart';
import 'package:fazzah_user/utils/extentions/navigaton_extentions.dart';
import 'package:fazzah_user/utils/extentions/size_extentions.dart';
import 'package:fazzah_user/utils/helpers/appbar_creator.dart';
import 'package:fazzah_user/views/user_main_views/more_screens/pay_ways.dart';
import 'package:flutter/material.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({super.key, this.user});
  final UserModel? user;

  @override
  _MyAccountScreenState createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user?.name);
    _phoneController = TextEditingController(text: widget.user?.phoneNumber);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<UserModel?> updateuser() async {
    final String? id = supabase.auth.currentUser?.id;
    if (id != null) {
      try {
        UserModel updatedUser = UserModel(
          id: id,
          name: _nameController.text,
          phoneNumber: _phoneController.text,
        );

        final response =
            await supabase.from('users').upsert(updatedUser.toJson());
        if (response.error == null &&
            response.data != null &&
            response.data.isNotEmpty) {
          return UserModel.fromJson(response.data[0]);
        } else {
          throw Exception('Failed to update user.');
        }
      } catch (error) {
        print(error.toString());
        return null;
      }
    } else {
      print('User ID is null');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar(
          context: context,
          title: 'حسابي',
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                context.popScreen();
              },
              icon: const Icon(Icons.arrow_back_ios_new_rounded))),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(30),
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person, color: Colors.grey),
                hintText: 'Name',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(30),
            child: TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.phone, color: Colors.grey),
                hintText: 'Phone Number',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              UserModel? updatedUser = await updateuser();
              if (updatedUser != null) {}
            },
            child: Container(
              width: context.getWidth(divide: 1.2),
              height: context.getHeight(divide: 16),
              decoration: BoxDecoration(
                color: const Color(0xffeff0eb),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Center(
                child: Text(
                  "حدث البيانات",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
