import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotifake/common/widgets/appbar/app_bar.dart';
import 'package:spotifake/common/helpers/is_dark_mode.dart';
import 'package:spotifake/core/config/assets/app_images.dart';
import 'package:spotifake/core/config/assets/app_vectors.dart';
import 'package:spotifake/core/config/theme/app_colors.dart';
import 'package:spotifake/presentation/home/widgets/news_songs.dart';
import 'package:spotifake/presentation/home/widgets/play_list.dart';
import 'package:spotifake/presentation/profile/pages/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

  late TabController? _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
  
  Color colorText = IsDarkMode(context).isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      appBar: BasicAppBar(
        title: SvgPicture.asset(AppVectors.logo, height: 40, width: 40),
        hideBackButton: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.person, size: 30),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()))
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              _homeTopCard(),
              _tabs(colorText),
              SizedBox(
                height: 260,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    NewsSongs(),
                    Container(),
                    Container(),
                    Container(),
                  ]
                ),
              ),
          
              SizedBox(height: 10),
              PlayList(),
            ],
          ),
        )
      )
    );
  }

  Widget _homeTopCard() {
    return Center(
      child: SizedBox(
        height: 140,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(
                AppVectors.homeTopCard,
              ),
            ),

            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 80),
                child: Image.asset(
                  AppImages.homeArtist
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tabs(Color colorText) {
    return TabBar(
      controller: _tabController,
      labelColor: colorText,
      unselectedLabelColor: colorText.withAlpha(100),
      dividerColor: Colors.transparent,
      indicatorColor: AppColors.primary,
      labelStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      isScrollable: true,
      padding: const EdgeInsets.symmetric(vertical: 20),
      tabs: [
        Tab(text: 'News'),
        Tab(text: 'Videos'),
        Tab(text: 'Artists'),
        Tab(text: 'Podcasts'),
      ]
    );
  }
}