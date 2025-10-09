import 'package:equatable/equatable.dart';

abstract class FormEvent extends Equatable {
  const FormEvent();

  @override
  List<Object> get props => [];
}

class NameChanged extends FormEvent {
  final String name;

  const NameChanged(this.name);

  @override
  List<Object> get props => [name];
}

class RollChanged extends FormEvent {
  final String roll;

  const RollChanged(this.roll);

  @override
  List<Object> get props => [roll];
}

class BranchChanged extends FormEvent {
  final String branch;

  const BranchChanged(this.branch);

  @override
  List<Object> get props => [branch];
}

class CollegeChanged extends FormEvent {
  final String college;

  const CollegeChanged(this.college);

  @override
  List<Object> get props => [college];
}

class EmailChanged extends FormEvent {
  final String email;

  const EmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class MobileChanged extends FormEvent {
  final String mobile;

  const MobileChanged(this.mobile);

  @override
  List<Object> get props => [mobile];
}

class FormSubmitted extends FormEvent {
  const FormSubmitted();
}

class FormReset extends FormEvent {
  const FormReset();
}
