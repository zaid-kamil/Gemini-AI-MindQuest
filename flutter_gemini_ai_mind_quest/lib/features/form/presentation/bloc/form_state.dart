import 'package:equatable/equatable.dart';
import '../../domain/validators/form_validators.dart';

enum FormStatus { initial, submitting, success, failure }

class FormBlocState extends Equatable {
  final Name name;
  final RequiredField roll;
  final RequiredField branch;
  final RequiredField college;
  final Email email;
  final Mobile mobile;
  final FormStatus status;
  final String? errorMessage;
  final bool isValid;

  const FormBlocState({
    this.name = const Name.pure(),
    this.roll = const RequiredField.pure(),
    this.branch = const RequiredField.pure(),
    this.college = const RequiredField.pure(),
    this.email = const Email.pure(),
    this.mobile = const Mobile.pure(),
    this.status = FormStatus.initial,
    this.errorMessage,
    this.isValid = false,
  });

  FormBlocState copyWith({
    Name? name,
    RequiredField? roll,
    RequiredField? branch,
    RequiredField? college,
    Email? email,
    Mobile? mobile,
    FormStatus? status,
    String? errorMessage,
    bool? isValid,
  }) {
    return FormBlocState(
      name: name ?? this.name,
      roll: roll ?? this.roll,
      branch: branch ?? this.branch,
      college: college ?? this.college,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      status: status ?? this.status,
      errorMessage: errorMessage,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object?> get props => [
        name,
        roll,
        branch,
        college,
        email,
        mobile,
        status,
        errorMessage,
        isValid,
      ];
}
