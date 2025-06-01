import 'package:adam_group/generated/assets.dart';
import 'package:flutter/material.dart';

class ImagesNoData extends StatelessWidget {
  const ImagesNoData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(child: Image.asset(Assets.imagesNoData));
  }
}