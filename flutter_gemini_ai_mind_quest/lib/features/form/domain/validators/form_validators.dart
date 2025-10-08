import 'package:formz/formz.dart';

enum NameValidationError { empty, tooShort }

class Name extends FormzInput<String, NameValidationError> {
  const Name.pure() : super.pure('');
  const Name.dirty([super.value = '']) : super.dirty();

  @override
  NameValidationError? validator(String value) {
    if (value.isEmpty) return NameValidationError.empty;
    if (value.length < 2) return NameValidationError.tooShort;
    return null;
  }
}

enum EmailValidationError { empty, invalid }

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');
  const Email.dirty([super.value = '']) : super.dirty();

  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  @override
  EmailValidationError? validator(String value) {
    if (value.isEmpty) return EmailValidationError.empty;
    if (!_emailRegex.hasMatch(value)) return EmailValidationError.invalid;
    return null;
  }
}

enum RequiredFieldError { empty }

class RequiredField extends FormzInput<String, RequiredFieldError> {
  const RequiredField.pure() : super.pure('');
  const RequiredField.dirty([super.value = '']) : super.dirty();

  @override
  RequiredFieldError? validator(String value) {
    if (value.isEmpty) return RequiredFieldError.empty;
    return null;
  }
}

enum MobileValidationError { empty, invalid }

class Mobile extends FormzInput<String, MobileValidationError> {
  const Mobile.pure() : super.pure('');
  const Mobile.dirty([super.value = '']) : super.dirty();

  static final RegExp _mobileRegex = RegExp(r'^\+?[0-9\s\-()]+$');

  @override
  MobileValidationError? validator(String value) {
    if (value.isEmpty) return MobileValidationError.empty;
    if (value.length < 10) return MobileValidationError.invalid;
    if (!_mobileRegex.hasMatch(value)) return MobileValidationError.invalid;
    return null;
  }
}
