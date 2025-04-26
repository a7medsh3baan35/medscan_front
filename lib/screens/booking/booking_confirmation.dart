import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/bookings_provider.dart';
import '../../models/booking_model.dart';

class BookingConfirmationScreen extends StatelessWidget {
  final String labName;
  final String serviceName;

  const BookingConfirmationScreen({
    super.key,
    required this.labName,
    required this.serviceName,
  });
  @override
  Widget build(BuildContext context) {
    final bookingProvider = Provider.of<BookingProvider>(context);
    final booking = bookingProvider.getBooking(labName, serviceName);

    return Scaffold(
      appBar: AppBar(title: Text('Booking Confirmation')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            booking != null
                ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Lab: $labName',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Service: $serviceName',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Booking Status: ${booking.status.toString().split('.').last}',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color:
                            booking.status == BookingStatus.confirmed
                                ? Colors.green.shade100
                                : booking.status == BookingStatus.canceled
                                ? Colors.red.shade100
                                : Colors.yellow.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Service: $serviceName',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Status: ${booking.status.toString().split('.').last}',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        bookingProvider.confirmBooking(booking.id);
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/booking history',
                          (route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green, // لتأكيد الحجز
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text(
                        'Confirm Booking',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),

                    SizedBox(height: 10), // فاصل بين الأزرار

                    ElevatedButton(
  onPressed: () {
    // إلغاء الحجز وحذفه من قائمة الحجوزات
    bookingProvider.cancelBooking(booking.id);

    // الانتقال إلى صفحة الـ Home بدون إرسال أي بيانات
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/home',  // تأكد من أن هذا هو مسار الصفحة الرئيسية لديك
      (route) => false,  // إزالة جميع المسارات السابقة
    );
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.red, // للإلغاء
    minimumSize: const Size(double.infinity, 50),
  ),
  child: const Text(
    'Cancel Booking',
    style: TextStyle(color: Colors.white70),
  ),
),

                  ],
                )
                : Center(
                  child: Text("No booking found for this lab and service."),
                ),
      ),
    );
  }
}
