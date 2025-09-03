import 'package:flutter/material.dart';
import 'package:movies/core/app_colors.dart';
import 'package:movies/core/app_Images.dart';
import 'package:movies/core/app_icons.dart';
import 'package:movies/core/app_routes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.black,
      body:
      Column(
        children: [
          Container(
            color: MColors.dgrey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Column(
                              children: const [
                                CircleAvatar(
                                  radius: 50,
                                  backgroundImage: AssetImage(MImages.avatar2),
                                ),
                                SizedBox(height: 15),
                                Text(
                                  "Team Three",
                                  style: TextStyle(
                                    color: MColors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 50),
                          // Watch List count
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "12",
                                style: TextStyle(
                                  fontSize: 36,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Watch List",
                                style: TextStyle(
                                  color: MColors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 24),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "10",
                                style: TextStyle(
                                  fontSize: 36,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "History",
                                style: TextStyle(
                                  color: MColors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: MColors.yellow,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                              ),
                              onPressed: () {Navigator.pushNamed(context, APPROUTES.editProfileScreen);},
                              child: const Text("Edit Profile",
                                  style: TextStyle(
                                      color: MColors.black,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: MColors.red,
                                padding: const EdgeInsets.symmetric(vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {Navigator.pushNamed(context, APPROUTES.loginScreen);},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Exit",
                                    style: TextStyle(
                                      color: MColors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Image.asset(
                                    MIcons.logout,
                                    height: 20,
                                    width: 20,
                                    color: MColors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(child: _buildTabItem(0, MIcons.items, "Watch List")),
                    Expanded(child: _buildTabItem(1, MIcons.folder, "History")),
                  ],
                ),
              ],
            ),
          ),

          Expanded(
            child: Center(
              child: Image.asset(
                MImages.popcorn,
                height: 200,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTabItem(int index, String assetPath, String label) {
    bool isSelected = selectedTab == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = index;
        });
      },
      child: Column(
        children: [
          Image.asset(
            assetPath,
            height: 28,
            width: 28,
            color: isSelected ? MColors.yellow : MColors.white,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? MColors.yellow : MColors.white,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          if (isSelected)
            Container(
              margin: const EdgeInsets.only(top: 6),
              height: 3,
              width: double.infinity,
              color: MColors.yellow,
            ),
        ],
      ),
    );
  }
}
