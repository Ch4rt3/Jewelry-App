import 'package:flutter/material.dart';
import 'package:jewelry_app/components/layouts/auth_background.dart';
import 'package:jewelry_app/components/buttons/large_button.dart';
import 'package:jewelry_app/components/forms/large_text_form_field.dart';
import 'package:jewelry_app/components/auth/sign_in_with_account.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  Widget _buildBody(BuildContext context) {
    return AuthBackground(
      titulo: "Forget Password", 
      children: [
        const SizedBox(height: 30,),
        LargeTextFormField(
          titulo: "Your email", 
          onChanged: (value){}
        ),
        const SizedBox(height: 50),
        LargeButton(
          titulo: "Send Email", 
          onPressed: (){
            Navigator.pushNamed(context, "/recovery-password");
          }
        ),
        const SignInWithAccount(),
      ],
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