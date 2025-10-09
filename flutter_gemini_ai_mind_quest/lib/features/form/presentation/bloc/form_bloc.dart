import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../../data/models/user_data.dart';
import '../../data/repositories/firebase_repository.dart';
import '../../domain/validators/form_validators.dart';
import 'form_event.dart';
import 'form_state.dart';

class FormBloc extends Bloc<FormEvent, FormBlocState> {
  final FirebaseRepository _repository;

  FormBloc({required FirebaseRepository repository})
      : _repository = repository,
        super(const FormBlocState()) {
    on<NameChanged>(_onNameChanged);
    on<RollChanged>(_onRollChanged);
    on<BranchChanged>(_onBranchChanged);
    on<CollegeChanged>(_onCollegeChanged);
    on<EmailChanged>(_onEmailChanged);
    on<MobileChanged>(_onMobileChanged);
    on<FormSubmitted>(_onFormSubmitted);
    on<FormReset>(_onFormReset);
  }

  void _onNameChanged(NameChanged event, Emitter<FormBlocState> emit) {
    final name = Name.dirty(event.name);
    emit(
      state.copyWith(
        name: name,
        isValid: Formz.validate([
          name,
          state.roll,
          state.branch,
          state.college,
          state.email,
          state.mobile,
        ]),
      ),
    );
  }

  void _onRollChanged(RollChanged event, Emitter<FormBlocState> emit) {
    final roll = RequiredField.dirty(event.roll);
    emit(
      state.copyWith(
        roll: roll,
        isValid: Formz.validate([
          state.name,
          roll,
          state.branch,
          state.college,
          state.email,
          state.mobile,
        ]),
      ),
    );
  }

  void _onBranchChanged(BranchChanged event, Emitter<FormBlocState> emit) {
    final branch = RequiredField.dirty(event.branch);
    emit(
      state.copyWith(
        branch: branch,
        isValid: Formz.validate([
          state.name,
          state.roll,
          branch,
          state.college,
          state.email,
          state.mobile,
        ]),
      ),
    );
  }

  void _onCollegeChanged(CollegeChanged event, Emitter<FormBlocState> emit) {
    final college = RequiredField.dirty(event.college);
    emit(
      state.copyWith(
        college: college,
        isValid: Formz.validate([
          state.name,
          state.roll,
          state.branch,
          college,
          state.email,
          state.mobile,
        ]),
      ),
    );
  }

  void _onEmailChanged(EmailChanged event, Emitter<FormBlocState> emit) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([
          state.name,
          state.roll,
          state.branch,
          state.college,
          email,
          state.mobile,
        ]),
      ),
    );
  }

  void _onMobileChanged(MobileChanged event, Emitter<FormBlocState> emit) {
    final mobile = Mobile.dirty(event.mobile);
    emit(
      state.copyWith(
        mobile: mobile,
        isValid: Formz.validate([
          state.name,
          state.roll,
          state.branch,
          state.college,
          state.email,
          mobile,
        ]),
      ),
    );
  }

  Future<void> _onFormSubmitted(
    FormSubmitted event,
    Emitter<FormBlocState> emit,
  ) async {
    if (!state.isValid) return;

    emit(state.copyWith(status: FormStatus.submitting));

    try {
      final userData = UserData(
        name: state.name.value,
        roll: state.roll.value,
        branch: state.branch.value,
        college: state.college.value,
        email: state.email.value,
        mobile: state.mobile.value,
        timestamp: DateTime.now().millisecondsSinceEpoch,
        createdAt: DateTime.now().toIso8601String(),
      );

      await _repository.saveUserData(userData);

      emit(state.copyWith(status: FormStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: FormStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void _onFormReset(FormReset event, Emitter<FormBlocState> emit) {
    emit(const FormBlocState()); // Reset to initial state
  }
}
