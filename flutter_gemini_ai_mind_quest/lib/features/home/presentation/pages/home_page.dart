import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_gemini_ai_mind_quest/features/form/data/repositories/firebase_repository.dart';
import 'package:flutter_gemini_ai_mind_quest/features/form/presentation/bloc/form_bloc.dart';
import 'package:flutter_gemini_ai_mind_quest/features/form/presentation/widgets/user_form_widget.dart';
import 'package:flutter_gemini_ai_mind_quest/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:flutter_gemini_ai_mind_quest/features/theme/presentation/bloc/theme_event.dart';
import 'package:flutter_gemini_ai_mind_quest/features/theme/presentation/bloc/theme_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 900),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTitle(),
                    const SizedBox(height: 8),
                    _buildSubtitle(),
                    const SizedBox(height: 32),
                    BlocProvider(
                      create: (context) => FormBloc(
                        repository: FirebaseRepository(
                          FirebaseDatabase.instance,
                        ),
                      ),
                      child: const UserFormWidget(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 24,
            right: 24,
            child: _buildThemeSwitcher(context),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [Color(0xFFA78BFA), Color(0xFF60A5FA), Color(0xFF9333EA)],
      ).createShader(bounds),
      child: const Text(
        'Gemini AI MindQuest',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 56,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          height: 1.2,
        ),
      ),
    );
  }

  Widget _buildSubtitle() {
    return Text(
      'Fill in your details below. After submission, several tabs will open automatically.',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 18,
        color: Colors.grey[400],
      ),
    );
  }

  Widget _buildThemeSwitcher(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final isDark = state.themeMode == ThemeMode.dark;
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor.withValues(alpha: 0.8),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 8,
                spreadRadius: 2,
              ),
            ],
          ),
          child: IconButton(
            icon: Icon(
              isDark ? Icons.light_mode : Icons.dark_mode,
              color: isDark ? Colors.yellow : const Color(0xFF9333EA),
            ),
            iconSize: 28,
            onPressed: () {
              context.read<ThemeBloc>().add(const ThemeToggled());
            },
            tooltip: isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
          ),
        );
      },
    );
  }
}
