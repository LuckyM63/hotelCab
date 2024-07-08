class BookingRequestModel{
  final String checkIn;
  final String checkOut;
  final String ownerId;
  final String contactName;
  final String contactNumber;
  final String totalAdults;
  final String totalChildren;

  BookingRequestModel({
    required this.checkIn,
    required this.checkOut,
    required this.ownerId,
    required this.contactName,
    required this.contactNumber,
    required this.totalAdults,
    required this.totalChildren,
  });
}