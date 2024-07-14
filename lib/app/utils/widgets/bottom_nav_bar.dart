import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class NavBar extends StatelessWidget {
  final int currentIndex;
  final List<BottomBarItem> items;
  final void Function(int)? onTap;

  const NavBar(
      {super.key, required this.currentIndex, required this.items, this.onTap});

  @override
  Widget build(BuildContext context) {
    return StylishBottomBar(
      backgroundColor: Color(0xFF1A1C1E),
      // backgroundColor: Color(0xFF191C1A),
        option: AnimatedBarOptions(
          iconSize: 23,
          barAnimation: BarAnimation.blink,
          iconStyle: IconStyle.animated,

          padding: const EdgeInsets.only(top: 8),
          
          opacity: 0.3,
        ),
        // option: BubbleBarOptions(
        //   barStyle: BubbleBarStyle.horizotnal,
        //   // barStyle: BubbleBarStyle.vertical,
        //   bubbleFillStyle: BubbleFillStyle.fill,
        //   // bubbleFillStyle: BubbleFillStyle.outlined,
        //   opacity: 0.3,
        // ),
        items: items,
        
        // fabLocation: StylishBarFabLocation.center,
        hasNotch: true,
        currentIndex: currentIndex,
        onTap: onTap);
  }
}
