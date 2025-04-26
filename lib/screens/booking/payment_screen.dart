import 'package:flutter/material.dart';
import '../../providers/bookings_provider.dart';
import '../../models/booking_model.dart';
import 'package:provider/provider.dart';


class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? _selectedMethod;
  final _formKey = GlobalKey<FormState>();

  // حقول Credit Card
  String _cardNumber = '';
  String _expiryDate = '';
  String _cvv = '';
  String _holderName = '';

  // حقول Fawry / Vodafone Cash
  String _mobileNumber = '';
  String _fawryReference = '';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final serviceName = args['serviceName']!;
    final labName     = args['labName']!;

    final methods = ['Credit Card', 'Fawry', 'Vodafone Cash'];

    return Scaffold(
      appBar: AppBar(title: const Text('Select Payment Method')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text('Service: $serviceName', style: const TextStyle(fontSize: 18)),
              Text('Lab: $labName',      style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 20),

              // اختيار طريقة الدفع
              ...methods.map((m) => RadioListTile<String>(
                title: Text(m),
                value: m,
                groupValue: _selectedMethod,
                onChanged: (v) => setState(() => _selectedMethod = v),
              )),

              const SizedBox(height: 10),

              // فورم Credit Card
              if (_selectedMethod == 'Credit Card') ...[
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Card Number',
                    hintText: 'XXXX XXXX XXXX XXXX',
                  ),
                  keyboardType: TextInputType.number,
                  maxLength: 19,
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                  onSaved: (v) => _cardNumber = v!.trim(),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Expiry Date',
                    hintText: 'MM/YY',
                  ),
                  keyboardType: TextInputType.datetime,
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                  onSaved: (v) => _expiryDate = v!.trim(),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'CVV',
                    hintText: '3 digits',
                  ),
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  maxLength: 3,
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                  onSaved: (v) => _cvv = v!.trim(),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Card Holder Name',
                  ),
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                  onSaved: (v) => _holderName = v!.trim(),
                ),
                const SizedBox(height: 20),
              ],

              // فورم Fawry
              if (_selectedMethod == 'Fawry') ...[
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Mobile Number',
                    hintText: '01XXXXXXXXX',
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                  onSaved: (v) => _mobileNumber = v!.trim(),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Fawry Reference Number',
                  ),
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                  onSaved: (v) => _fawryReference = v!.trim(),
                ),
                const SizedBox(height: 20),
              ],

              // فورم Vodafone Cash
              if (_selectedMethod == 'Vodafone Cash') ...[
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Vodafone Cash Number',
                    hintText: '01XXXXXXXXX',
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                  onSaved: (v) => _mobileNumber = v!.trim(),
                ),
                const SizedBox(height: 20),
              ],

              const Spacer(),

              ElevatedButton(
                onPressed: _selectedMethod == null
    ? null
    : () {
        if (!_formKey.currentState!.validate()) return;
        _formKey.currentState!.save();

        // 1. إنشاء حجز جديد
        final booking = Booking(
          id: UniqueKey().toString(), // أو استخدم uuid
          labName: labName,
          serviceName: serviceName,
          status: BookingStatus.pending,
        );

        // 2. إضافة الحجز إلى BookingProvider
        Provider.of<BookingProvider>(context, listen: false).addBooking(booking);

        // 3. الانتقال إلى صفحة التأكيد
        Navigator.pushNamed(
          context,
          '/confirmation',
          arguments: {
            'labName': labName,
            'serviceName': serviceName,
          },
        );
      },

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  'Proceed',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
