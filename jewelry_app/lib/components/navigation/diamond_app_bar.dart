import 'package:flutter/material.dart';
import 'package:jewelry_app/configs/colors.dart';

class DiamondAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double screenHeight;
  final String message;
  final bool showDiamond;
  final bool automaticallyImplyLeading;

  const DiamondAppBar({
    super.key,
    required this.screenHeight,
    required this.message,
    required this.showDiamond, 
    required this.automaticallyImplyLeading,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
            automaticallyImplyLeading: automaticallyImplyLeading,
            title: Row(
              children: [
                if (showDiamond) ...[
                  SizedBox(
                    width: screenHeight * 0.12,
                    child: Image.asset(
                      'public/diamond.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
                Flexible(
                  child: Text(
                    message,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondTextColor,
                      letterSpacing: 1.5,
                    ),
                    softWrap: true, 
                    overflow: TextOverflow.visible,
                  ),
                ),
              ],
            ),
            toolbarHeight: screenHeight * (showDiamond ? 0.12 : 0.08),
          );
  }

  @override
  Size get preferredSize => Size.fromHeight(screenHeight * (showDiamond ? 0.12 : 0.08));
}
