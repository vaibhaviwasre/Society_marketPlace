import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showNotifications;
  final bool showMessages;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final VoidCallback? onNotificationPressed;
  final VoidCallback? onMessagePressed;

  const CustomAppBar({
    super.key,
    this.title = 'NeighborConnect',
    this.showNotifications = true,
    this.showMessages = true,
    this.showBackButton = false,
    this.onBackPressed,
    this.onNotificationPressed,
    this.onMessagePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (showBackButton)
                  IconButton(
                    onPressed: onBackPressed ?? () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios),
                    iconSize: 20,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                if (showBackButton) const SizedBox(width: 8),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                if (showNotifications)
                  IconButton(
                    onPressed: onNotificationPressed ?? () {},
                    icon: const Icon(Icons.notifications_none),
                    iconSize: 24,
                  ),
                if (showMessages)
                  IconButton(
                    onPressed: onMessagePressed ?? () {},
                    icon: const Icon(Icons.message_outlined),
                    iconSize: 24,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
