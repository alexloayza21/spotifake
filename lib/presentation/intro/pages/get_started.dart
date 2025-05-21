import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotifake/common/widgets/button/basic_app_button.dart';
import 'package:spotifake/core/config/assets/app_images.dart';
import 'package:spotifake/core/config/assets/app_vectors.dart';
import 'package:spotifake/core/config/theme/app_colors.dart';
import 'package:spotifake/presentation/choose_mode/pages/choose_mode.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  AppImages.introBackground
                  ),
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
                    'Enjoy Listing to Music',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    )
                  ),
              
                  Text(
                    'Duis tempor consequat fugiat fugiat quis magna qui cillum proident non ex consectetur occaecat minim. Minim esse aliquip excepteur elit culpa velit amet. Sit mollit ipsum est minim velit duis elit duis Lorem.',
                    style: TextStyle(
                      fontSize: 17,
                      color: AppColors.grey,
                    ),
                    textAlign: TextAlign.center
                  ),
                  SizedBox(height: 10),
              
                  BasicAppButton(
                    onPressed: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => const ChooseModePage())
                      );
                    }, 
                    title: 'Get Started',
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