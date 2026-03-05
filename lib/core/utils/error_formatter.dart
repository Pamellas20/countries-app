String formatErrorMessage(String message) {
  String formatted = message;

  if (formatted.contains('Client error:')) {
    formatted = formatted.replaceFirst('Client error:', '').trim();
  }

  if (formatted.contains('Server error:')) {
    formatted = formatted.replaceFirst('Server error:', '').trim();
  }

  if (formatted.contains('Network error:')) {
    formatted = formatted.replaceFirst('Network error:', '').trim();
  }
  if (formatted.contains('Network error:')) {
    formatted = formatted.replaceFirst('Network error:', '').trim();
  }

  if (formatted == 'Not Found') {
    return 'Country not found. Please check the country name and try again';
  }

  if (formatted.toLowerCase().contains('timeout')) {
    return 'Request timed out. Please check your internet connection';
  }

  if (formatted.toLowerCase().contains('no internet')) {
    return 'No internet connection. Please check your network';
  }

  return formatted.isEmpty
      ? 'Something went wrong. Please try again'
      : formatted;
}
