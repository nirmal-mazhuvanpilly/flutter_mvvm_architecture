import 'package:flutter/services.dart';

class TextInputFormats {
  static TextInputFormatter get emirateIdFormatter => _EmiratesIDFormatter();

  static TextInputFormatter get currencyFormatter =>
      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,3}'));

  static TextInputFormatter get digitsFormatter =>
      FilteringTextInputFormatter.digitsOnly;

  static TextInputFormatter get removeWhiteSpaceFormatter =>
      FilteringTextInputFormatter.deny(RegExp(r'\s'));

  static TextInputFormatter get removeFirstDot => FirstCharNotDotFormatter();

  static TextInputFormatter get alphaNumeric =>
      FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z-@.]"));

  static TextInputFormatter get noWhiteSpaceFormatterForInitials =>
      NoTextNoWhiteSpaceFormatter();

  static TextInputFormatter get creditCardFormatter => CreditCardFormatter();

  static TextInputFormatter get currencyFormatterForRecipient =>
      CurrencyFormatter();

  static TextInputFormatter get alphabetsFormatter => AlphabetInputFormatter();

  static TextInputFormatter get multilineFormatter =>
      MultiLineAlphabetInputFormatter();
}

class _EmiratesIDFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final String formatted = _formatEmiratesID(newValue.text);
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  String _formatEmiratesID(String value) {
    value = value.replaceAll(RegExp(r'\D'), '');
    if (value.length <= 3) {
      return value;
    } else if (value.length <= 7) {
      return '${value.substring(0, 3)}-${value.substring(3)}';
    } else if (value.length <= 14) {
      return '${value.substring(0, 3)}-${value.substring(3, 7)}-${value.substring(7)}';
    } else {
      return '${value.substring(0, 3)}-${value.substring(3, 7)}-${value.substring(7, 14)}-${value.substring(14, 15)}';
    }
  }
}

class NoTextNoWhiteSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.trim().isEmpty && oldValue.text.trim().isEmpty) {
      return oldValue;
    }
    return newValue;
  }
}

class CreditCardFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove any non-digit characters
    String inputText = newValue.text.replaceAll(RegExp(r'\D'), '');

    // Limit the length to 16 digits
    if (inputText.length > 16) {
      inputText = inputText.substring(0, 16);
    }

    // Add spaces every 4 digits
    StringBuffer newText = StringBuffer();
    for (int i = 0; i < inputText.length; i++) {
      if (i > 0 && i % 4 == 0) {
        newText.write(' ');
      }
      newText.write(inputText[i]);
    }

    return newValue.copyWith(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

class CurrencyFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove any non-digit characters
    String inputText = newValue.text.replaceAll(RegExp(r'[^\d.]'), '');

    // Split the text into integer and decimal parts
    List<String> parts = inputText.split('.');

    // Format the integer part with commas
    String formattedInteger = _formatInteger(parts[0]);

    // Combine the formatted parts with a dot
    String formattedText = formattedInteger;
    if (parts.length > 1) {
      formattedText += '.${parts[1]}';
    }

    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }

  String _formatInteger(String value) {
    if (value.isEmpty) {
      return '';
    }

    int intValue = int.parse(value);
    String formattedValue = intValue.toString();
    String result = '';

    for (int i = 0; i < formattedValue.length; i++) {
      if (i > 0 && (formattedValue.length - i) % 3 == 0) {
        result += ',';
      }
      result += formattedValue[i];
    }

    return result;
  }
}

class AlphabetInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Use only alphabets
    String newText = newValue.text.replaceAll(RegExp(r'[^a-zA-Z\s]'), '');

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.fromPosition(
        TextPosition(offset: newText.length),
      ),
    );
  }
}

class FirstCharNotDotFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isNotEmpty && newValue.text[0] == '.') {
      return oldValue;
    }
    return newValue;
  }
}

class MultiLineAlphabetInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Use only alphabets
    String newText = newValue.text
        // Step 1: Remove all characters except letters,dot, spaces, and newlines
        .replaceAll(RegExp(r'[^a-zA-Z 0-9 . \n]'), '')
        // Step 2: Replace multiple spaces with a single space
        .replaceAll(RegExp(r' {2,}'), ' ')
        // Step 3: Replace multiple newlines with a single newline
        .replaceAll(RegExp(r'\n{2,}'), '\n')
        // Step 4: Trim leading spaces and newlines
        .replaceAll(RegExp(r'^[ \n]+'), '');
    return newValue.copyWith(
      text: newText,
      selection: TextSelection.fromPosition(
        TextPosition(offset: newText.length),
      ),
    );
  }
}
