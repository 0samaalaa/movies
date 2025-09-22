import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/resources/app_colors.dart';
import '../../../../core/resources/app_icons.dart';
import '../../../browse/presentation/pages/browse_screen.dart';
import '../../../profile/presentation/pages/profile_screen.dart';
import '../../../search/presentation/pages/search_screen.dart';
import '../../../home/presentation/pages/home_screen.dart';
import '../cubit/Layout_cubit.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, LayoutState>(
      builder: (context, state) {
        final screens = [
          const HomeScreen(),
          const SearchScreen(),
          BrowseScreen(initialGenre: state.initialGenre),
          const ProfileScreen(),
        ];

        return Scaffold(
          extendBody: true,
          body: screens[state.selectedIndex],
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 28),
            child: PhysicalModel(
              color: Colors.transparent,
              shadowColor: MColors.black,
              elevation: 12,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: MColors.dgrey,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildNavItem(context, icon: MIcons.home, index: 0),
                    _buildNavItem(context, icon: MIcons.search, index: 1),
                    _buildNavItem(context, icon: MIcons.explore, index: 2),
                    _buildNavItem(context, icon: MIcons.profile, index: 3),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavItem(BuildContext context,
      {required String icon, required int index}) {
    final state = context.watch<LayoutCubit>().state;
    final bool isSelected = state.selectedIndex == index;

    return GestureDetector(
      onTap: () => context.read<LayoutCubit>().changeTab(index),
      child: Container(
        height: 40,
        width: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
        ),
        child: Center(
          child: ImageIcon(
            AssetImage(icon),
            size: 26,
            color: isSelected ? MColors.yellow : MColors.white,
          ),
        ),
      ),
    );
  }
}
