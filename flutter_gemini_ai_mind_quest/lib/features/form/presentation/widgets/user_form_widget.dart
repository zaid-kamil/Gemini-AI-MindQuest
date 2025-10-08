import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/url_launcher_service.dart';
import '../bloc/form_bloc.dart';
import '../bloc/form_event.dart';
import '../bloc/form_state.dart';

class UserFormWidget extends StatelessWidget {
  const UserFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<FormBloc, FormBlocState>(
      listener: (context, state) {
        if (state.status == FormStatus.success) {
          _showSuccessDialog(context, state.name.value);
        } else if (state.status == FormStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? 'An error occurred'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildFormFields(context),
              const SizedBox(height: 32),
              _buildSubmitButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormFields(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildNameField()),
            const SizedBox(width: 16),
            Expanded(child: _buildRollField()),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(child: _buildBranchField()),
            const SizedBox(width: 16),
            Expanded(child: _buildCollegeField()),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(child: _buildEmailField()),
            const SizedBox(width: 16),
            Expanded(child: _buildMobileField()),
          ],
        ),
      ],
    );
  }

  Widget _buildNameField() {
    return BlocBuilder<FormBloc, FormBlocState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return TextField(
          onChanged: (value) =>
              context.read<FormBloc>().add(NameChanged(value)),
          decoration: InputDecoration(
            labelText: 'Name',
            hintText: 'John Doe',
            prefixIcon: const Icon(Icons.person),
            errorText: state.name.displayError != null
                ? 'Name must be at least 2 characters'
                : null,
          ),
        );
      },
    );
  }

  Widget _buildRollField() {
    return BlocBuilder<FormBloc, FormBlocState>(
      buildWhen: (previous, current) => previous.roll != current.roll,
      builder: (context, state) {
        return TextField(
          onChanged: (value) =>
              context.read<FormBloc>().add(RollChanged(value)),
          decoration: InputDecoration(
            labelText: 'Roll Number',
            hintText: 'e.g., 21CS001',
            prefixIcon: const Icon(Icons.numbers),
            errorText: state.roll.displayError != null
                ? 'Roll number is required'
                : null,
          ),
        );
      },
    );
  }

  Widget _buildBranchField() {
    return BlocBuilder<FormBloc, FormBlocState>(
      buildWhen: (previous, current) => previous.branch != current.branch,
      builder: (context, state) {
        return TextField(
          onChanged: (value) =>
              context.read<FormBloc>().add(BranchChanged(value)),
          decoration: InputDecoration(
            labelText: 'Branch',
            hintText: 'Computer Science',
            prefixIcon: const Icon(Icons.code),
            errorText: state.branch.displayError != null
                ? 'Branch is required'
                : null,
          ),
        );
      },
    );
  }

  Widget _buildCollegeField() {
    return BlocBuilder<FormBloc, FormBlocState>(
      buildWhen: (previous, current) => previous.college != current.college,
      builder: (context, state) {
        return TextField(
          onChanged: (value) =>
              context.read<FormBloc>().add(CollegeChanged(value)),
          decoration: InputDecoration(
            labelText: 'College / University',
            hintText: 'University of Technology',
            prefixIcon: const Icon(Icons.school),
            errorText: state.college.displayError != null
                ? 'College/University is required'
                : null,
          ),
        );
      },
    );
  }

  Widget _buildEmailField() {
    return BlocBuilder<FormBloc, FormBlocState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          onChanged: (value) =>
              context.read<FormBloc>().add(EmailChanged(value)),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Email ID',
            hintText: 'you@example.com',
            prefixIcon: const Icon(Icons.email),
            errorText: state.email.displayError != null
                ? 'Please enter a valid email'
                : null,
          ),
        );
      },
    );
  }

  Widget _buildMobileField() {
    return BlocBuilder<FormBloc, FormBlocState>(
      buildWhen: (previous, current) => previous.mobile != current.mobile,
      builder: (context, state) {
        return TextField(
          onChanged: (value) =>
              context.read<FormBloc>().add(MobileChanged(value)),
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            labelText: 'Mobile Number',
            hintText: '+1 (555) 123-4567',
            prefixIcon: const Icon(Icons.phone),
            errorText: state.mobile.displayError != null
                ? 'Please enter a valid mobile number'
                : null,
          ),
        );
      },
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return BlocBuilder<FormBloc, FormBlocState>(
      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.isValid != current.isValid,
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state.isValid && state.status != FormStatus.submitting
              ? () => context.read<FormBloc>().add(const FormSubmitted())
              : null,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 20),
          ),
          child: state.status == FormStatus.submitting
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : const Text(
                  'Submit and Open Tabs',
                  style: TextStyle(fontSize: 18),
                ),
        );
      },
    );
  }

  void _showSuccessDialog(BuildContext context, String name) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => _SuccessDialog(userName: name),
    );
  }
}

class _SuccessDialog extends StatefulWidget {
  final String userName;

  const _SuccessDialog({required this.userName});

  @override
  State<_SuccessDialog> createState() => _SuccessDialogState();
}

class _SuccessDialogState extends State<_SuccessDialog> {
  int _countdown = 3;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() async {
    for (int i = 3; i > 0; i--) {
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        setState(() => _countdown = i - 1);
      }
    }
    if (mounted) {
      _openTabs();
    }
  }

  void _openTabs() async {
    final urls = [
      'https://google.com',
      'https://github.com',
      'https://linkedin.com',
      'https://facebook.com',
      'https://twitter.com',
    ];

    await UrlLauncherService.openMultipleUrls(urls, delayMs: 500);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      content: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 64,
            ),
            const SizedBox(height: 16),
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Color(0xFFA78BFA), Color(0xFF60A5FA)],
              ).createShader(bounds),
              child: const Text(
                '🎉 Success!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Thank you, ${widget.userName}!',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              'Your information has been saved to the database.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            if (_countdown > 0)
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.open_in_new, color: Color(0xFFA78BFA)),
                      const SizedBox(width: 8),
                      Text(
                        'Opening tabs in $_countdown...',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      5,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: _countdown <= 3 - index
                              ? const Color(0xFFA78BFA)
                              : Colors.grey.withValues(alpha: 0.3),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            else
              Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_circle, color: Colors.green),
                      SizedBox(width: 8),
                      Text(
                        'Tabs Opened Successfully!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Opening: Google, GitHub, LinkedIn, Facebook, Twitter',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(_countdown == 0 ? 'Done' : 'Close'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
