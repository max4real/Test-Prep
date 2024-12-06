import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:test_prep/models/m_user_model.dart';

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
            user.name[0],
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
        _buildDetailRow(icon: Icons.email, text: user.email),
        _buildDetailRow(
          icon: Icons.home,
          text:
              "${user.address.suite}, ${user.address.street}, ${user.address.city}",
          maxLines: 3,
        ),
        _buildDetailRow(icon: Icons.phone, text: user.phone),
        _buildDetailRow(icon: Icons.business_outlined, text: user.company),
      ],
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String text,
    int maxLines = 1,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 15),
        const Gap(10),
        Expanded(
          child: Text(
            text,
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
