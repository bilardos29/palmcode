import 'package:flutter/material.dart';

class MenuIcon extends StatelessWidget {
  const MenuIcon({
    required this.icons,
    required this.menu,
    this.isActive = false,
    required this.onClick,
    Key? key,
  }) : super(key: key);

  final IconData icons;
  final String menu;
  final bool isActive;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: SizedBox(
        height: 60,
        width: 60,
        child: Column(
          children: [
            Icon(
              icons,
              size: 28,
              color: isActive ? Colors.indigo : Colors.black45,
            ),
            const SizedBox(height: 2),
            Text(
              menu,
              style: TextStyle(
                fontSize: 12,
                color: isActive ? Colors.indigo : Colors.black45,
              ),
            )
          ],
        ),
      ),
    );
  }
}