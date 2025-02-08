import 'package:adam_group/Screens/Widgets/settings_grid_item.dart';
import 'package:flutter/material.dart';

class SettingsGrid extends StatelessWidget {
  final List<Map<String, dynamic>> settings;

  const SettingsGrid({super.key, required this.settings});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width * 0.04),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: MediaQuery.sizeOf(context).width * 0.06,
        mainAxisSpacing: MediaQuery.sizeOf(context).height * 0.03,
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
