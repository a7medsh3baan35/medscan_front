import 'package:flutter/material.dart';
import '../models/booking_model.dart';

class BookingProvider with ChangeNotifier {
  List<Booking> _bookings = [];

  // الحصول على جميع الحجوزات
  List<Booking> get bookings => _bookings;

  // إضافة حجز جديد
  void addBooking(Booking booking) {
    _bookings.add(booking);
    notifyListeners();
  }

  Booking getBooking(String labName, String serviceName) {
  return _bookings.firstWhere(
    (booking) => booking.labName == labName && booking.serviceName == serviceName,
    orElse: () => throw Exception("Booking not found"),
  );
}


  // تأكيد الحجز
  void confirmBooking(String bookingId) {
    final bookingIndex = _bookings.indexWhere((booking) => booking.id == bookingId);
    if (bookingIndex >= 0) {
      _bookings[bookingIndex] = _bookings[bookingIndex].copyWith(status: BookingStatus.confirmed);
      notifyListeners();
    }
  }

  void cancelBooking(String bookingId) {
  _bookings.removeWhere((booking) => booking.id == bookingId);
  notifyListeners();
}

}
