import 'package:flutter/material.dart';
import 'package:jewelry_app/components/layouts/auth_background.dart';
import 'package:jewelry_app/components/buttons/large_button.dart';
import 'package:jewelry_app/components/forms/large_text_form_field.dart';
import 'package:jewelry_app/components/auth/sign_in_with_account.dart';

class RecoveryPasswordPage extends StatelessWidget {
  const RecoveryPasswordPage({super.key});

  
  Widget _buildBody(BuildContext context) {
    return AuthBackground(
      titulo: "Recovery Password", 
      children: [
        const SizedBox(height: 10,),
        LargeTextFormField(
          titulo: "Reset Code", 
          onPressed: (){}
        ),
        const SizedBox(height: 20),
        LargeTextFormField(
          titulo: "New Password", 
          onPressed: (){}
        ),
        const SizedBox(height: 20),
        LargeTextFormField(
          titulo: "Confirm Password", 
          onPressed: (){}
        ),
        const SizedBox(height: 20),
        LargeButton(
          titulo: "Change Password", 
          onPressed: (){
            Navigator.pushNamed(context, "/success-password");
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