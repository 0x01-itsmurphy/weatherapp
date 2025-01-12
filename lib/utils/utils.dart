extension StringExtensions on String {
  String capitalizeEachWord() {
    if (isEmpty) {
      return this;
    }
    return split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }
}

class Utils {
  String convertToDayString(DateTime dateTime) {
    final now = DateTime.now();

    // Normalize both dates by removing the time part
    final currentDate = DateTime(now.year, now.month, now.day);
    final targetDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    final difference = targetDate.difference(currentDate).inDays;

    if (difference == 0) {
      return 'Today, ${_formatDate(dateTime)}';
    } else if (difference == 1) {
      return 'Tomorrow, ${_formatDate(dateTime)}';
    } else if (difference == -1) {
      return 'Yesterday, ${_formatDate(dateTime)}';
    } else {
      return '${_getDayOfWeek(dateTime.weekday)}, ${_formatDate(dateTime)}';
    }
  }

  String _formatDate(DateTime dateTime) {
    return '${dateTime.day.toString().padLeft(2, '0')} ${_getMonthName(dateTime.month)}';
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return '';
    }
  }

  String _getDayOfWeek(int weekday) {
    switch (weekday) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return '';
    }
  }
}
