import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/url_launcher_service.dart';
import '../bloc/form_bloc.dart';
import '../bloc/form_event.dart';
import '../bloc/form_state.dart';

class UserFormWidget extends StatefulWidget {
  const UserFormWidget({super.key});

  @override
  State<UserFormWidget> createState() => _UserFormWidgetState();
}

class _UserFormWidgetState extends State<UserFormWidget> {
  // Text editing controllers
  final _nameController = TextEditingController();
  final _rollController = TextEditingController();
  final _branchController = TextEditingController();
  final _collegeController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _rollController.dispose();
    _branchController.dispose();
    _collegeController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    final isMediumScreen = MediaQuery.of(context).size.width < 900;
    
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
        // Clear controllers when form is reset
        if (state.status == FormStatus.initial && 
            state.name.isPure && 
            state.roll.isPure) {
          _clearControllers();
        }
      },
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(isSmallScreen ? 16.0 : (isMediumScreen ? 24.0 : 32.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildFormFields(context, isSmallScreen),
              SizedBox(height: isSmallScreen ? 16 : 32),
              _buildSubmitButton(context),
            ],
          ),
        ),
      ),
    );
  }

  void _clearControllers() {
    _nameController.clear();
    _rollController.clear();
    _branchController.clear();
    _collegeController.clear();
    _emailController.clear();
    _mobileController.clear();
  }

  Widget _buildFormFields(BuildContext context, bool isSmallScreen) {
    if (isSmallScreen) {
      // Single column layout for mobile
      return Column(
        children: [
          _buildNameField(),
          const SizedBox(height: 16),
          _buildRollField(),
          const SizedBox(height: 16),
          _buildBranchField(),
          const SizedBox(height: 16),
          _buildCollegeField(),
          const SizedBox(height: 16),
          _buildEmailField(),
          const SizedBox(height: 16),
          _buildMobileField(),
        ],
      );
    }
    
    // Two column layout for tablet and desktop
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
          controller: _nameController,
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
          controller: _rollController,
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
          controller: _branchController,
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
          controller: _collegeController,
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
          controller: _emailController,
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
          controller: _mobileController,
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
                  'Submit Details',
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
  
  final List<Map<String, String>> _links = [
    {
      'title': 'Prompt 1',
      'url': 'https://aiskillshouse.com/student/qr-mediator.html?uid=613&promptId=17',
      'icon': '🎯'
    },
    {
      'title': 'Prompt 2',
      'url': 'https://aiskillshouse.com/student/qr-mediator.html?uid=613&promptId=16',
      'icon': '🚀'
    },
    {
      'title': 'Prompt 3',
      'url': 'https://aiskillshouse.com/student/qr-mediator.html?uid=613&promptId=15',
      'icon': '⭐'
    },
    {
      'title': 'Prompt 4',
      'url': 'https://aiskillshouse.com/student/qr-mediator.html?uid=613&promptId=14',
      'icon': '💡'
    },
    {
      'title': 'Prompt 5',
      'url': 'https://aiskillshouse.com/student/qr-mediator.html?uid=613&promptId=13',
      'icon': '✨'
    },
  ];

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
    final urls = _links.map((link) => link['url']!).toList();
    await UrlLauncherService.openMultipleUrls(urls, delayMs: 500);
  }
  
  void _openSingleTab(String url) async {
    await UrlLauncherService.openInNewTab(url);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;
    final maxWidth = isSmallScreen ? screenWidth * 0.9 : 600.0;
    
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      contentPadding: EdgeInsets.all(isSmallScreen ? 16 : 24),
      content: Container(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: isSmallScreen ? 48 : 64,
              ),
              const SizedBox(height: 16),
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Color(0xFFA78BFA), Color(0xFF60A5FA)],
                ).createShader(bounds),
                child: Text(
                  '🎉 Success!',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 24 : 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Thank you, ${widget.userName}!',
                style: TextStyle(
                  fontSize: isSmallScreen ? 18 : 20,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Your information has been saved to the database.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: isSmallScreen ? 14 : 16),
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
                        Flexible(
                          child: Text(
                            'Opening tabs in $_countdown...',
                            style: TextStyle(
                              fontSize: isSmallScreen ? 16 : 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
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
                          width: isSmallScreen ? 10 : 12,
                          height: isSmallScreen ? 10 : 12,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.check_circle, color: Colors.green, size: 20),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            'Tabs Opened Successfully!',
                            style: TextStyle(
                              fontSize: isSmallScreen ? 16 : 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Click any button below to reopen a link:',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 13 : 14,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    // 5 Buttons for individual links
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.center,
                      children: _links.map((link) {
                        return SizedBox(
                          width: isSmallScreen ? double.infinity : ((maxWidth - 32) / 2),
                          child: OutlinedButton.icon(
                            onPressed: () => _openSingleTab(link['url']!),
                            icon: Text(link['icon']!, style: const TextStyle(fontSize: 20)),
                            label: Text(
                              link['title']!,
                              style: TextStyle(fontSize: isSmallScreen ? 14 : 16),
                            ),
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                vertical: isSmallScreen ? 12 : 16,
                                horizontal: isSmallScreen ? 12 : 16,
                              ),
                              side: const BorderSide(color: Color(0xFFA78BFA), width: 2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    context.read<FormBloc>().add(const FormReset());
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: isSmallScreen ? 14 : 16),
                  ),
                  child: Text(
                    _countdown == 0 ? 'Done' : 'Close',
                    style: TextStyle(fontSize: isSmallScreen ? 16 : 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
