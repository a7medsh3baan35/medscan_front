import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/booking_model.dart';
import '../../providers/bookings_provider.dart';

class BookingsHistoryScreen extends StatelessWidget {
  const BookingsHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookings = Provider.of<BookingProvider>(context).bookings;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking History'),
        // This will automatically add a back button if this screen was pushed
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/home'); // Replace with your home route
      },
        ),
      ),
      body: bookings.isEmpty
          ? const Center(child: Text('No bookings yet.'))
          : ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (ctx, index) {
                final booking = bookings[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  elevation: 5,
                  child: ListTile(
                    title: Text(booking.serviceName),
                    subtitle: Text('Lab: ${booking.labName}'),
                    trailing: _getBookingStatusWidget(booking.status),
                  ),
                );
              },
            ),
    );
  }

  Widget _getBookingStatusWidget(BookingStatus status) {
    switch (status) {
      case BookingStatus.pending:
        return const Chip(label: Text('Pending'));
      case BookingStatus.confirmed:
        return const Chip(label: Text('Confirmed'));
      case BookingStatus.canceled:
        return const Chip(label: Text('Canceled'));
      default:
        return const SizedBox.shrink();
    }
  }
}