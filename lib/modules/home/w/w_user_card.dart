import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:test_prep/modules/home/m/m_user_model.dart';
import 'package:test_prep/modules/home/w/w_labled_icon.dart';

class UserCard extends StatelessWidget {
  final VoidCallback onPress;
  final UserModel user;
  const UserCard({super.key, required this.user, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const Divider(),
            _buildDetails(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor:
              const Color.fromARGB(255, 85, 94, 228).withOpacity(0.5),
          child: Text(
            user.name[0].toUpperCase(),
            style: const TextStyle(fontSize: 20),
          ),
        ),
        const Gap(10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.name,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "@${user.username}",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        const Spacer(),
        IconButton(
          onPressed: onPress,
          icon: const Icon(Icons.share),
        ),
      ],
    );
  }

  Widget _buildDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabledIconWidget(icon: Icons.email, text: user.email),
        LabledIconWidget(
          icon: Icons.home,
          text:
              "${user.address.suite}, ${user.address.street}, ${user.address.city}",
          maxLines: 3,
        ),
        LabledIconWidget(icon: Icons.phone, text: user.phone),
        LabledIconWidget(icon: Icons.business_outlined, text: user.company),
      ],
    );
  }
}
