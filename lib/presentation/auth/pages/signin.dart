import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotifake/common/appbar/app_bar.dart';
import 'package:spotifake/common/helpers/is_dark_mode.dart';
import 'package:spotifake/common/widgets/button/basic_app_button.dart';
import 'package:spotifake/core/config/assets/app_vectors.dart';
import 'package:spotifake/presentation/auth/pages/signup.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {

    Color colorText = IsDarkMode(context).isDarkMode ? Color(0xffAEAEAE) : Color(0xff383838);
    
    return Scaffold(
      appBar: BasicAppBar(
        title: SvgPicture.asset(AppVectors.logo, height: 40, width: 40),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              
              _signInText(),
              const SizedBox(height: 40),
              _enterUsernameOrEmailTextField(context),
              const SizedBox(height: 20),
              _passwordTextField(context),
              _recoveryPasswordText(colorText),
              const SizedBox(height: 20),
              BasicAppButton(
                onPressed: () {
                  
                }, 
                title: 'Sign In',
              ),
              _registerText(context),
          
            ],
          ),
        ),
      )
    );
  }

  Widget _signInText() {
    return const Text(
      'Sign In',
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _enterUsernameOrEmailTextField(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Enter Username or Email',
      ).applyDefaults(Theme.of(context).inputDecorationTheme), 
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
    );
  }

  Widget _passwordTextField(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Password',
        suffixIcon: IconButton(
          icon: const Icon(Icons.visibility_off),
          onPressed: () {},
        ),
      ).applyDefaults(Theme.of(context).inputDecorationTheme), 
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
    );
  }

  Widget _recoveryPasswordText(Color colorText) {
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton(
        onPressed: () {},
        child: Text(
          'Recovery Password?',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: colorText,
          ),
        ),
      ),
    );
  }

  Widget _registerText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          const Text(
            'Not A Member?',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          
          TextButton(
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignUpPage())),
            child: const Text(
              'Register Now',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

        ],
      ),
    );
  }

}