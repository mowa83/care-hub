import 'package:flutter/material.dart';
import 'package:graduation_project/core/route_utils/route_utils.dart';
import 'package:graduation_project/core/utils/colors.dart';
import 'package:graduation_project/core/utils/validator.dart';
import 'package:graduation_project/core/shared_widgets/header_row.dart';
import 'package:graduation_project/screens/login/login_screen.dart';
import 'package:graduation_project/screens/reset_password/services/reset_password_model.dart';
import 'package:graduation_project/screens/reset_password/services/reset_password_service.dart';
import 'package:graduation_project/widgets/app_button.dart';
import 'package:graduation_project/widgets/app_head_line.dart';
import 'package:graduation_project/widgets/app_text.dart';
import 'package:graduation_project/widgets/app_text_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final ResetPasswordService _authService = ResetPasswordService();
  bool _isLoading = false;

  Future<void> resetPassword() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final request = ResetPasswordRequest(
        password: _passwordController.text.trim(),
        confirmPassword: _confirmPasswordController.text.trim(),
      );

      await _authService.resetPassword(request);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password reset successful')),
      );

      RouteUtils.push(context, const LoginScreen());
    } catch (e) {
      if (!mounted) return;

      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const HeaderRow(
              text: 'Verify Your Email',
            ),
            const SizedBox(height: 30),
            Center(
              child: AppText(
                title: 'At least 9 characters, with uppercase,',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: AppColors.grey,
              ),
            ),
            Center(
              child: AppText(
                title: 'lowercase letters and numbers',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: AppColors.grey,
              ),
            ),
            const SizedBox(height: 60),
             AppHeadLine(photo: 'lock', labal: 'Password'),
            AppTextField(
              hint: 'Enter Your Password',
              secure: true,
              validator: Validator.password,
              controller: _passwordController,
            ),
            const SizedBox(height: 16),
             AppHeadLine(photo: 'lock', labal: 'Confirm Password'),
            AppTextField(
              hint: 'Confirm Your Password',
              secure: true,
              validator: Validator.password,
              controller: _confirmPasswordController,
            ),
            const SizedBox(height: 40),
            AppButton(
              title: _isLoading ? 'Loading...' : 'Send',
              onTap: _isLoading ? null : resetPassword,
            ),
          ],
        ),
      ),
    );
  }
}
