
import 'package:flutter/material.dart';
import 'package:jewelry_app/components/notifications/sucess_notification.dart';

class SuccessPasswordPage extends StatelessWidget {
  const SuccessPasswordPage({super.key});

  Widget _buildBody(BuildContext context) {
    return const SuccessNotification(
      message: "Password reset succesful",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: null,
      body: _buildBody(context),
    );
  }
}