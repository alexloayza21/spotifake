import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotifake/common/appbar/app_bar.dart';
import 'package:spotifake/common/helpers/is_dark_mode.dart';
import 'package:spotifake/common/widgets/button/basic_app_button.dart';
import 'package:spotifake/core/config/assets/app_images.dart';
import 'package:spotifake/core/config/assets/app_vectors.dart';
import 'package:spotifake/presentation/auth/pages/signin.dart';
import 'package:spotifake/presentation/auth/pages/signup.dart';

class SignUpOrSignInPage extends StatelessWidget {
  const SignUpOrSignInPage({super.key});

  @override
  Widget build(BuildContext context) {

    Color colorText = IsDarkMode(context).isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      appBar: BasicAppBar(),
      body: Stack(
        children: [

          Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset(
              AppImages.authBackground,
              fit: BoxFit.cover,
            ),
          ),

          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(
              AppVectors.topPattern,
              fit: BoxFit.cover,
            ),
          ),

          Align(
            alignment: Alignment.bottomRight,
            child: SvgPicture.asset(
              AppVectors.bottomPattern,
              fit: BoxFit.cover,
            ),
          ),

          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 10,
                children: [

                  SvgPicture.asset(
                    AppVectors.logo,
                    height: 70,
                    width: 70,
                  ),
                  SizedBox(height: 45),

                  Text(
                    'Enjoy Listening to Music',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: colorText
                    )
                  ),
                  SizedBox(height: 10),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Spotify is a proprietary Swedish audio streaming and media services provider',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        color: Color(0xff797979),
                        
                      )
                    ),
                  ),
                  SizedBox(height: 20),

                  Row(
                    spacing: 20,
                    children: [

                      Expanded(
                        child: BasicAppButton(
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage())), 
                          title: 'Register'
                        ),
                      ),

                      Expanded(
                        child: TextButton(
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage())),
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: colorText,
                            )
                          ),
                        ),
                      ),
                      
                    ],
                  )

                ],
              ),
            ),
          ),

        ],
      )
    );
  }
}