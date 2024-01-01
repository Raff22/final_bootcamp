import 'package:fazzah_user/bloc/auth_bloc/auth_bloc.dart';
import 'package:fazzah_user/bloc/auth_bloc/auth_event.dart';
import 'package:fazzah_user/bloc/auth_bloc/auth_state.dart';
import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/constant/layout.dart';
import 'package:fazzah_user/models/user_model.dart';
import 'package:fazzah_user/utils/extentions/navigaton_extentions.dart';
import 'package:fazzah_user/utils/extentions/size_extentions.dart';
import 'package:fazzah_user/utils/helpers/appbar_creator.dart';
import 'package:fazzah_user/utils/helpers/show_message_green.dart';
import 'package:fazzah_user/views/auth_views/login_view/login_view.dart';
import 'package:fazzah_user/views/user_main_views/more_screens/pay_ways.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            email: widget.user!.email!);
        final response =
            await supabase.from('users').upsert(updatedUser.toJson()).select();
        if (response.isNotEmpty) {
          return UserModel.fromJson(response[0]);
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
            padding: const EdgeInsets.all(30),
            child: TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person, color: Colors.grey),
                hintText: 'Name',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: TextField(
              controller: _phoneController,
              decoration: const InputDecoration(
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
              if (updatedUser != null) {
                showMessageDialog(
                    context: context, message: 'حُدثت بياناتك بنجاح');
              }
            },
            child: Container(
              width: context.getWidth(divide: 1.2),
              height: context.getHeight(divide: 16),
              decoration: const BoxDecoration(
                color: green,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: const Center(
                child: Text(
                  "حدث البيانات",
                  style: TextStyle(fontSize: 20, color: lightGreen),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
