import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotifake/common/widgets/button/basic_app_button.dart';
import 'package:spotifake/core/config/assets/app_images.dart';
import 'package:spotifake/core/config/assets/app_vectors.dart';
import 'package:spotifake/presentation/auth/pages/signup_or_signin.dart';
import 'package:spotifake/presentation/choose_mode/bloc/theme_cubit.dart';
import 'package:spotifake/presentation/choose_mode/widgets/mode_button.dart';

class ChooseModePage extends StatelessWidget {
  const ChooseModePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.chooseModeBackground),
                fit: BoxFit.fill,
                colorFilter: ColorFilter.mode(
                  Colors.black.withValues(alpha: 0.15),
                  BlendMode.darken
                )
              )
            ),
          ),

          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                spacing: 21,
                children: [
              
                  SafeArea(
                    child: SvgPicture.asset(
                      AppVectors.logo
                    ),
                  ),
              
                  Spacer(),
              
                  Text(
                    'Choose Mode',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    )
                  ),
                  SizedBox(height: 15),
              
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 36),
                    child: Row(
                      children: [

                        ModeButton(
                          title: 'Dark Mode',
                          child: SvgPicture.asset(
                            AppVectors.moon,
                            fit: BoxFit.none,
                          ),
                          onTap: () => context.read<ThemeCubit>().updateTheme(ThemeMode.dark),
                        ),

                        ModeButton(
                          title: 'Light Mode', 
                          child: SvgPicture.asset(
                            AppVectors.sun,
                            fit: BoxFit.none,
                          ),
                          onTap: () => context.read<ThemeCubit>().updateTheme(ThemeMode.light),
                        )
                        
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
              
                  BasicAppButton(
                    onPressed: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => const SignUpOrSignInPage())
                      );
                    }, 
                    title: 'Continue',
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

