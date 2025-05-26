import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotifake/common/appbar/app_bar.dart';
import 'package:spotifake/common/snackbar/snackbar.dart';
import 'package:spotifake/common/widgets/button/basic_app_button.dart';
import 'package:spotifake/core/config/assets/app_vectors.dart';
import 'package:spotifake/data/models/auth/create_user_req.dart';
import 'package:spotifake/domain/usecases/auth/signup_usecase.dart';
import 'package:spotifake/presentation/auth/pages/signin.dart';
import 'package:spotifake/presentation/root/pages/root.dart';
import 'package:spotifake/services_locator.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: SvgPicture.asset(AppVectors.logo, height: 40, width: 40),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 20,
            children: [
              
              _registerText(),
              const SizedBox(height: 20),
              _fullNameTextField(context),
              _emailTextField(context),
              _passwordTextField(context),
              BasicAppButton(
                onPressed: () async{
                  var result = await sl<SignUpUseCase>().call(
                    params: CreateUserReq(
                      fullName: _fullNameController.text.toString().trim(), 
                      email: _emailController.text.toString().trim(), 
                      password: _passwordController.text.toString().trim()
                    )
                  );

                  result.fold((left) {
                    // Handle error
                    snackBar(context, content: left, backgroundColor: Colors.red);

                  }, (right) {
                    // Handle success
                    snackBar(context, content: right, backgroundColor: Colors.green);
                    Navigator.pushAndRemoveUntil(
                      context, 
                      MaterialPageRoute(builder: (context) => const RootPage()),
                      (route) => false
                    );                           
                  });

                }, 
                title: 'Create Account',
              ),
              _signInText(context),
          
            ],
          ),
        ),
      )
    );
  }

  Widget _registerText() {
    return const Text(
      'Register',
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _fullNameTextField(BuildContext context) {
    return TextField(
      controller: _fullNameController,
      decoration: InputDecoration(
        hintText: 'Full Name',
      ).applyDefaults(Theme.of(context).inputDecorationTheme), 
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
    );
  }

  Widget _emailTextField(BuildContext context) {
    return TextField(
      controller: _emailController,
      decoration: InputDecoration(
        hintText: 'Enter Email',
      ).applyDefaults(Theme.of(context).inputDecorationTheme), 
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
    );
  }

  Widget _passwordTextField(BuildContext context) {
    return TextField(
      controller: _passwordController,
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

  Widget _signInText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          const Text(
            'Do you have an account?',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          
          TextButton(
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInPage())),
            child: const Text(
              'Sign In',
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