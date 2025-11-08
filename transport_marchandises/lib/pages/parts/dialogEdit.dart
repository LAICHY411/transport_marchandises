import 'package:flutter/material.dart';

class ConfirmEditDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  final actionAModifier;

  const ConfirmEditDialog({
    super.key,
    required this.onConfirm,
    required this.onCancel,
    required this.actionAModifier,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Modifier le ${actionAModifier} ?',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Vous êtes sur ${actionAModifier}.'),
          const SizedBox(height: 8),
        ],
      ),
      actions: [
        TextButton(onPressed: onCancel, child: const Text('Annuler')),
        ElevatedButton(onPressed: onConfirm, child: const Text('Confirmer')),
      ],
    );
  }
}
