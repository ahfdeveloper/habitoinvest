import 'package:flutter/material.dart';
import 'package:habito_invest_app/app/global/widgets/app_colors.dart';
import 'package:habito_invest_app/app/global/widgets/divider_horizontal/divider_horizontal.dart';

class InputText extends StatelessWidget {
  final IconData icon;
  final String? initialValue;
  final TextStyle? style;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final onTap;

  const InputText({
    Key? key,
    required this.icon,
    this.initialValue,
    required this.style,
    this.focusNode,
    this.validator,
    this.controller,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        children: [
          TextFormField(
            enableInteractiveSelection: false,
            controller: controller,
            initialValue: initialValue,
            validator: validator,
            onTap: onTap,
            style: style,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
              icon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, color: AppColors.grey600),
                ],
              ),
            ),
          ),
          DividerHorizontal(),
        ],
      ),
    );
  }
}
