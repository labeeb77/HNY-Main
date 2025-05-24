import 'package:intl/intl.dart';

class DateFormatter {
  /// Formats the date of birth string to a desired format
  /// 
  /// [dateString] - The input date string that needs to be formatted
  /// Returns formatted date string in 'dd/MM/yyyy' format
  /// Returns empty string if input is null or empty
  static String formatDateOfBirth(String? dateString) {
    if (dateString == null || dateString.isEmpty) {
      return '';
    }

    try {
      // First try to parse the date
      DateTime? date;
      
      // Try different possible input formats
      final List<String> possibleFormats = [
        'yyyy-MM-dd',
        'yyyy/MM/dd',
        'dd-MM-yyyy',
        'dd/MM/yyyy',
        'MM-dd-yyyy',
        'MM/dd/yyyy'
      ];

      for (String format in possibleFormats) {
        try {
          date = DateFormat(format).parse(dateString);
          if (date != null) break;
        } catch (e) {
          continue;
        }
      }

      if (date == null) {
        return '';
      }

      // Format the date to desired output format
      return DateFormat('dd/MM/yyyy').format(date);
    } catch (e) {
      return '';
    }
  }
} 