import 'package:fazzah_user/bloc/payments_bloc/payments_bloc.dart';
import 'package:fazzah_user/bloc/payments_bloc/payments_event.dart';
import 'package:fazzah_user/bloc/payments_bloc/payments_state.dart';
import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/constant/layout.dart';
import 'package:fazzah_user/models/payment_method.dart';
import 'package:fazzah_user/utils/extentions/navigaton_extentions.dart';
import 'package:fazzah_user/utils/extentions/size_extentions.dart';
import 'package:fazzah_user/utils/helpers/appbar_creator.dart';
import 'package:fazzah_user/views/user_main_views/more_screens/costum/pay_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    context.read<PayBloc>().add(RequestallPaymentsEvent());
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: createAppBar(
          context: context,
          title: ' طرق الدفع',
          centerTitle: true,
          trailing: IconButton(
            onPressed: () {
              context.read<PayBloc>().add(RequestallPaymentsEvent());
            },
            icon: const Icon(
              Icons.refresh,
              size: 25,
            ),
          ),
          leading: IconButton(
              onPressed: () {
                context.popScreen();
              },
              icon: const Icon(Icons.arrow_back_ios_new_rounded))),
      body: Column(
        children: [
          const SizedBox(height: 100),
          SizedBox(
              height: context.getHeight(divide: 2),
              width: context.getWidth(divide: 1),
              child: buildUpcomingPaysTab(context)),
          InkWell(
            onTap: () {
              _showPaymentBottomSheet(context);
            },
            child: Container(
              width: context.getWidth(divide: 1.2),
              height: context.getHeight(divide: 16),
              decoration: const BoxDecoration(
                color: Color(0xffeff0eb),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: const Center(
                child: Text(
                  "اضف طريقة الدفع",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
            ),
          ),
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
                  ListTile(
                    title: const Text('ApplePay'),
                    onTap: () {
                      setState(() => selectedPaymentMethod = 'ApplePay');
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
                title: const Text('تاكيد الحذف '),
                content: const Text('هل انت متاكد من حذف البطاقه؟'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('الغاء'),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                  ),
                  TextButton(
                    child: const Text('حذف'),
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

  GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Add this line

  void _showInfoInputDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ادخل المعلومات'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: ListBody(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(1),
                    child: TextFormField(
                      controller: cardnameController,
                      decoration: InputDecoration(
                          hintText: " الاسم",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الرجاء ادخال الاسم';
                        }
                        return null;
                      },
                    ),
                  ),
                  height20,
                  if (selectedPaymentMethod == 'Visa')
                    Padding(
                      padding: EdgeInsets.all(1),
                      child: TextFormField(
                        controller: cardNumberController,
                        decoration: InputDecoration(
                            hintText: 'رقم البطاقة',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء ادخال رقم البطاقه ';
                          }
                          return null;
                        },
                      ),
                    ),
                  height20,
                  if (selectedPaymentMethod == 'PayPal' ||
                      selectedPaymentMethod == 'ApplePay')
                    Padding(
                      padding: EdgeInsets.all(1),
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                            hintText: 'البريد الإلكتروني',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء ادخال البريد الالكتروني';
                          }
                          return null;
                        },
                      ),
                    ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: TextFormField(
                      controller: expiresAtController,
                      decoration: InputDecoration(
                          hintText: 'تاريخ الانتهاء',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الرجاء ادخال تاريخ الانتهاء';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('حفظ'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.of(context).pop();
                  _savePaymentMethod();
                  context.read<PayBloc>().add(RequestallPaymentsEvent());
                }
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
    String last4Digits = cardNumberController.text.substring(
        cardNumberController.text.length - 5,
        cardNumberController.text.length - 1);
    String encrypted = '****-****-****-$last4Digits';

    var paymentMethod = PaymentMethod(
      userId: id,
      name: selectedPaymentMethod,
      email: emailController.text,
      cardNumber: selectedPaymentMethod == 'Visa' ? encrypted : null,
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
