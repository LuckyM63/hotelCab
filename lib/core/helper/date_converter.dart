import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:booking_box/core/utils/my_strings.dart';

class DateConverter {
  static String formatDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd hh:mm:ss').format(dateTime);
  }

  static String formatValidityDate(String dateString){
    var inputDate=DateFormat('yyyy-MM-dd hh:mm:ss').parse(dateString);
    var outputFormat=DateFormat('dd MMM yyyy').format(inputDate);
    return outputFormat;
  }

  static String isoToLocalDateAndTime(String dateTime,{String errorResult='--'}) {
    String date = '';
    if(dateTime.isEmpty || dateTime=='null'){
      date = '';
    }
    try{
      date = DateFormat('dd MMM yyyy').format(isoStringToLocalDate(dateTime));
    } catch(v){
      date = '';
    }
    String time = isoStringToLocalTimeOnly(dateTime);
    return '$date, $time';
  }

  static String formatDepositTimeWithAmFormat(String dateString){

    var newStr = '${dateString.substring(0,10)} ${dateString.substring(11,23)}';
    DateTime dt = DateTime.parse(newStr);

    String formattedDate= DateFormat("yyyy-MM-dd").format(dt);

    return formattedDate;
  }

  static String estimatedDate(DateTime dateTime) {
    return DateFormat('dd MMM yyyy').format(dateTime);
  }

  static DateTime convertStringToDatetime(String dateTime) {
    return DateFormat("yyyy-MM-ddTHH:mm:ss.mmm").parse(dateTime);
  }

  static String convertIsoToString(String dateTime){
    DateTime time=convertStringToDatetime(dateTime);
    String result=DateFormat('dd MMM yyyy hh:mm aa',).format(time);
    return result;
  }

  static DateTime isoStringToLocalDate(String dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').parse(dateTime, true).toLocal();
  }

  static String isoToLocalTimeSubtract(String dateTime){
    DateTime date=isoStringToLocalDate(dateTime);
    final currentDate=DateTime.now();
    final difference=currentDate.difference(date).inDays;
    return difference.toString();
  }

  static String isoStringToLocalTimeOnly(String dateTime) {
    return DateFormat('hh:mm aa').format(isoStringToLocalDate(dateTime));
  }

  static String isoStringToLocalAMPM(String dateTime) {
    return DateFormat('a').format(isoStringToLocalDate(dateTime));
  }

  static String isoStringToLocalDateOnly(String dateTime) {
    try{
      return DateFormat('dd MMM yyyy').format(isoStringToLocalDate(dateTime));
    }catch(v){
      return "--";
    }
  }
  static String isoStringToLocalFormattedDateOnly(String dateTime) {
    try{
      return DateFormat('dd MMM, yyyy').format(isoStringToLocalDate(dateTime));
    }catch(v){
      return "--";
    }
  }

  static String localDateTime(DateTime dateTime) {
    return DateFormat('dd-MM-yyyy').format(dateTime.toUtc());
  }

  static String localDateToIsoString(DateTime dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(dateTime.toUtc());
  }

  static String convertTimeToTime(String time) {
    return DateFormat('hh:mm a').format(DateFormat('hh:mm:ss').parse(time));
  }

  static String nextReturnTime(String dateTime) {
    final date = DateFormat("dd MMM, yyyy hh:mm a").format(DateTime.parse(dateTime));
    return date;
  }


  static String formattedDate(String date){
    DateTime parsedDate = DateFormat('MMM d, y').parse(date);
    String formattedDate = DateFormat('y-MM-dd').format(parsedDate);
    return formattedDate;
  }

  static String formatDateInDayMonth(String date){
    DateTime parsedDate = DateFormat('MMM d, y').parse(date);
    String formattedDate = DateFormat('dd MMM').format(parsedDate);
    return formattedDate;
  }

  static String formatDateInEDayMonth(String inputDateString) {

    DateTime inputDate = DateTime.parse(inputDateString);

    String formattedDate = DateFormat('E, d MMM').format(inputDate);

    return formattedDate;
  }

  static String calculateNumberOfNights(String checkInDate, String checkOutDate) {


    DateTime entryDate = DateTime.parse(checkInDate);
    DateTime outDate = DateTime.parse(checkOutDate);

    Duration duration = outDate.difference(entryDate);
    int numberOfNights = duration.inHours ~/ 24;

    return numberOfNights.toString();
  }

  static String formatDateTime(String inputDateTime, {String formattedDate = 'dd/MM/yy'}) {

    try{
      DateTime parsedDateTime = DateTime.parse(inputDateTime);
      String formattedDateTime = DateFormat(formattedDate).format(parsedDateTime);
      return formattedDateTime;
    }catch(e){
      return MyStrings.dateIsNotFormatted.tr;
    }

  }

  static String getFormatedSubtractTime(String time,{ bool numericDates=false}){

    final date1 = DateTime.now();
    final isoDate = isoStringToLocalDate(time);
    final difference = date1.difference(isoDate);

    if ((difference.inDays / 365).floor() >= 1) {
      int year = (difference.inDays/365).floor();
      return '$year year ago';
    }else if((difference.inDays / 30).floor() >= 1){
      int month = (difference.inDays/30).floor();
      return '$month month ago';
    }
    else if((difference.inDays / 7).floor() >= 1){
      int week = (difference.inDays/7).floor();
      return '$week week ago';
    }
    else if (difference.inDays >= 1) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} hours ago';
    }  else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} minutes ago';
    }  else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }


  static String formatStringDateTime(String dateTimeString, {bool onlyDate = false}) {

    DateTime dateTime = DateTime.parse(dateTimeString);

    final String month = _getMonthAbbreviation(dateTime.month);
    final String day = dateTime.day.toString();
    final String year = dateTime.year.toString();
    final String hour = dateTime.hour.toString().padLeft(2, '0');
    final String minute = dateTime.minute.toString().padLeft(2, '0');
    final String period = (dateTime.hour < 12) ? 'AM' : 'PM';

    if(onlyDate){
      return '$day $month, $year';
    }else{
      return '$day $month, $year $hour:$minute $period';
    }
  }

  static String formatDateYearPunctuation(String inputDate) {
    try {
      DateTime dateTime = DateTime.parse(inputDate);
      String formattedDate = "${dateTime.day} ${_getMonthAbbreviation(dateTime.month)}`${dateTime.year % 100}";
      return formattedDate;
    } catch (e) {
      return '';
    }
  }


  static String _getMonthAbbreviation(int month) {
    switch (month) {
      case 1: return 'Jan';
      case 2: return 'Feb';
      case 3: return 'Mar';
      case 4: return 'Apr';
      case 5: return 'May';
      case 6: return 'Jun';
      case 7: return 'Jul';
      case 8: return 'Aug';
      case 9: return 'Sep';
      case 10: return 'Oct';
      case 11: return 'Nov';
      case 12: return 'Dec';
      default: return '';
    }
  }




}