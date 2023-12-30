import 'package:fazzah_user/bloc/order_bloc/order_event.dart';
import 'package:fazzah_user/bloc/payments_bloc/payments_bloc.dart';
import 'package:fazzah_user/bloc/payments_bloc/payments_event.dart';
import 'package:fazzah_user/bloc/payments_bloc/payments_state.dart';
import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/constant/layout.dart';
import 'package:fazzah_user/models/payment_method.dart';
import 'package:fazzah_user/utils/extentions/size_extentions.dart';
import 'package:fazzah_user/views/user_main_views/coustom_wedgets/user_wedgets.dart';
import 'package:fazzah_user/views/user_main_views/more_screens/costum/pay_custon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Initialize Supabase client with your project details
final supabase = Supabase.instance.client;

class PayWaysScreen extends StatefulWidget {
  const PayWaysScreen({Key? key}) : super(key: key);

  @override
  _PayWaysScreenState createState() => _PayWaysScreenState();
}

class _PayWaysScreenState extends State<PayWaysScreen> {
  String selectedPaymentMethod = '';
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController expiresAtController = TextEditingController();
  final TextEditingController cardnameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("طرق الدفع"),
        leading: IconButton(
            onPressed: () {
              context.read<PayBloc>().add(RequestallPaymentsEvent());
            },
            icon: const Icon(Icons.refresh)),
      ),
      body: Column(
        children: [
          const SizedBox(height: 100),
          SizedBox(
              height: context.getHeight(divide: 2),
              width: context.getWidth(divide: 1),
              child: buildUpcomingPaysTab(context)),

          ElevatedButton(
            onPressed: () {
              _showPaymentBottomSheet(context);
            },
            child: const Text('اضف طريقة الدفع'),
          ),
          const SizedBox(height: 16),
          // The rest of your UI here
        ],
      ),
    );
  }

  void _showPaymentBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('اختر وسيلة الدفع'),
                  const SizedBox(height: 16),
                  ListTile(
                    title: const Text('Visa'),
                    onTap: () {
                      setState(() => selectedPaymentMethod = 'Visa');
                      Navigator.pop(context);
                      _showInfoInputDialog(context);
                    },
                  ),
                  ListTile(
                    title: const Text('PayPal'),
                    onTap: () {
                      setState(() => selectedPaymentMethod = 'PayPal');
                      Navigator.pop(context);
                      _showInfoInputDialog(context);
                    },
                  ),
                  // Add more payment options as needed
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget buildUpcomingPaysTab(BuildContext context) {
    return BlocBuilder<PayBloc, PayState>(
      builder: (context, state) {
        if (state is PayLoadingState) {
          return const Center(child: CircularProgressIndicator(color: green));
        } else if (state is ShowAllPaymentsState) {
          if (state.isdonelist.isEmpty) {
            return Container();
          }
          return buildProvidersList(context, state.isdonelist);
        } else if (state is PayErrorState) {
          return Center(child: Text(state.error));
        }
        return const Center(child: Text('No data available'));
      },
    );
  }

  Widget buildProvidersList(
      BuildContext context, List<PaymentMethod> PaymentsList) {
    return ListView.separated(
      itemCount: PaymentsList.length,
      itemBuilder: (context, index) => PaymentCard(
        paymentinfo: PaymentsList[index],
        onDelete: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Confirm Delete'),
                content: Text(
                    'Are you sure you want to delete this payment method?'),
                actions: <Widget>[
                  TextButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                  ),
                  TextButton(
                    child: Text('Delete'),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                      deletePaymentMethod(PaymentsList[index].id!);
                      context.read<PayBloc>().add(RequestallPaymentsEvent());
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
      separatorBuilder: (BuildContext context, int index) => height20,
    );
  }

  void _showInfoInputDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ادخل المعلومات'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: cardnameController,
                  decoration: const InputDecoration(labelText: 'الاسم'),
                ),
                if (selectedPaymentMethod == 'Visa')
                  TextField(
                    controller: cardNumberController,
                    decoration: const InputDecoration(labelText: 'رقم البطاقة'),
                  ),
                if (selectedPaymentMethod == 'PayPal' ||
                    selectedPaymentMethod == 'Visa')
                  TextField(
                    controller: emailController,
                    decoration:
                        const InputDecoration(labelText: 'البريد الإلكتروني'),
                  ),
                TextField(
                  controller: expiresAtController,
                  decoration:
                      const InputDecoration(labelText: 'تاريخ الانتهاء'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('حفظ'),
              onPressed: () {
                Navigator.of(context).pop();
                _savePaymentMethod();
                context.read<PayBloc>().add(RequestallPaymentsEvent());
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _savePaymentMethod() async {
    final String? id = supabase.auth.currentUser?.id;
    if (id == null) {
      print('Error: User is not authenticated.');
      return;
    }

    var paymentMethod = PaymentMethod(
      userId: id,
      name: selectedPaymentMethod,
      email: emailController.text,
      cardNumber:
          selectedPaymentMethod == 'Visa' ? cardNumberController.text : null,
      expiresAt: expiresAtController.text,
      cardname: cardnameController.text,
    );

    try {
      final response =
          await supabase.from('payment_methods').insert(paymentMethod.toJson());

      if (response.error != null) {
        print('Error when inserting: ${response.error!.message}');
        return;
      }
      context.read<PayBloc>().add(RequestallPaymentsEvent());

      print('Payment method added successfully');
      // Clear the text fields after saving
      nameController.clear();
      cardNumberController.clear();
      emailController.clear();
      expiresAtController.clear();
    } catch (e) {
      print('Error when inserting: $e');
    }
  }

  // Function to delete a payment method
  Future<void> deletePaymentMethod(int paymentMethodId) async {
    try {
      final response = await supabase
          .from('payment_methods')
          .delete()
          .eq('id', paymentMethodId);

      if (response.error != null) {
        print('Error when deleting: ${response.error!.message}');
        return;
      }

      print('Payment method deleted successfully');
      // Refresh the list of payment methods
      context.read<PayBloc>().add(RequestallPaymentsEvent());
    } catch (e) {
      print('Error when deleting: $e');
    }
  }
}
