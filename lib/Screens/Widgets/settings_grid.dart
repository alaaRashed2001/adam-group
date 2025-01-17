import 'package:adam_group/Screens/Widgets/settings_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsGrid extends StatelessWidget {
  final List<Map<String, dynamic>> settings;

  const SettingsGrid({super.key, required this.settings});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true, // لتجنب overflow
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 24.0,
        mainAxisSpacing: 24.0,
      ),
      itemCount: settings.length,
      itemBuilder: (context, index) {
        final item = settings[index];
        return SettingsGridItem(
          image: item['image'],
          title: item['title'],
          onTap: () => item['action'](context),
        );
      },
    );
  }
}
