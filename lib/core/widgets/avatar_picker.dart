import 'package:flutter/material.dart';

import '../resources/app_Images.dart';
import '../resources/app_colors.dart';


class AvatarPicker extends StatefulWidget {
  const AvatarPicker({Key? key}) : super(key: key);

  @override
  State<AvatarPicker> createState() => _AvatarPickerState();
}

class _AvatarPickerState extends State<AvatarPicker> {
  final PageController _pageController = PageController(viewportFraction: 0.3);
  int _currentPage = 0;

  final List<String> avatars = [
    MImages.avatar1,
    MImages.avatar2,
    MImages.avatar3,
    MImages.avatar4,
    MImages.avatar5,
    MImages.avatar6,
    MImages.avatar7,
    MImages.avatar8,
    MImages.avatar9,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 160,
          child: PageView.builder(
            controller: _pageController,
            itemCount: avatars.length,
            onPageChanged: (index) {
              setState(() { _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              double scale = _currentPage == index ? 1.2 : 0.8;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal:10.0),
                child: TweenAnimationBuilder(
                  duration: const Duration(milliseconds: 300),
                  tween: Tween<double>(begin: scale, end: scale),
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: value,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _currentPage = index;
                            _pageController.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          });
                        },
                        child: CircleAvatar(
                          radius: 55,
                          backgroundColor: _currentPage == index
                              ? MColors.black
                              : Colors.transparent,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage(avatars[index]),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
