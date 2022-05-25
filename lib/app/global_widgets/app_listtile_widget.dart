import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../core/theme/app_colors.dart';
import '../core/utils/app_masks.dart';

class ListTileWidget extends StatelessWidget {
  final dynamic visualDensity;
  final dynamic minVerticalPadding;
  final Text? title;
  final Text? subtitle;
  final Column? trailing;
  final String titleName;
  final DateTime date;
  final dynamic value;
  final Color color;
  final VoidCallback? onTap;

  const ListTileWidget({
    Key? key,
    this.visualDensity,
    this.minVerticalPadding,
    this.title,
    this.subtitle,
    this.trailing,
    required this.titleName,
    required this.date,
    required this.value,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      visualDensity: VisualDensity(vertical: -3),
      minVerticalPadding: 0,
      title: Text(
        titleName,
        style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold, color: AppColors.bodyTextPagesColor),
      ),
      subtitle: Text(
        DateFormat('dd/MM/yyyy').format(date),
        style: TextStyle(color: AppColors.bodyTextPagesColor),
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Text(
              moneyFormatter.format(value),
              style: TextStyle(color: AppColors.bodyTextPagesColor, fontSize: 15.5),
            ),
          ),
          Icon(
            Icons.done_outline,
            color: color,
            size: 20.0,
          ),
        ],
      ),
    );
  }
}
