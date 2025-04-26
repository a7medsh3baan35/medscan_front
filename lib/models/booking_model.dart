enum BookingStatus { pending, confirmed, canceled }

class Booking {
  final String id;
  final String serviceName;
  final String labName;
  final BookingStatus status;
  
  Booking({required this.id, required this.serviceName, required this.labName, required this.status});

  // إضافة دالة نسخ لتعديل الحجز (للـ confirm أو cancel)
  Booking copyWith({BookingStatus? status}) {
    return Booking(
      id: this.id,
      serviceName: this.serviceName,
      labName: this.labName,
      status: status ?? this.status,
    );
  }
}
