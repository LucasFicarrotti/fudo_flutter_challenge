import 'package:flutter/material.dart';

import '../../../common/presentation/widgets/custom_card.dart';
import '../../domain/models/user.dart';

class UserCard extends StatelessWidget {
  final User user;
  const UserCard({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: CustomCard(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name,
                style: textTheme.titleMedium,
              ),
              Text('@${user.username}'),
              const SizedBox(height: 15),
              Text(
                user.website,
                style: textTheme.titleSmall,
              )
            ],
          ),
        ),
      ),
    );
  }
}
