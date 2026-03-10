import 'package:flutter/material.dart';

class AddressCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String address;
  final bool isDefault;
  final String? note;
  final VoidCallback onDelete;
  final VoidCallback onEdit; // دالة التعديل

  const AddressCard({super.key, required this.icon, required this.title, required this.address, required this.onDelete, required this.onEdit, this.isDefault = false, this.note});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(backgroundColor: Colors.blue.withValues(alpha: 0.1), child: Icon(icon, color: Colors.blue[700])),
                const SizedBox(width: 12),
                Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                if (isDefault) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(4)),
                    child: const Text('Default', style: TextStyle(color: Colors.blue, fontSize: 12)),
                  ),
                ]
              ],
            ),
            const SizedBox(height: 12),
            Text(address, style: TextStyle(color: Colors.grey[700], height: 1.5)),
            if (note != null) Text(note!, style: TextStyle(color: Colors.grey[500], fontStyle: FontStyle.italic)),
            const Divider(height: 30),
            Row(
              children: [
                if (!isDefault) Expanded(child: TextButton.icon(onPressed: () {}, icon: const Icon(Icons.star_border, size: 18), label: const Text('Default', style: TextStyle(fontSize: 11)))),

                // زر التعديل
                Expanded(child: TextButton.icon(onPressed: onEdit, icon: const Icon(Icons.edit_outlined, size: 18), label: const Text('Edit', style: TextStyle(fontSize: 11)))),

                Expanded(child: TextButton.icon(onPressed: onDelete, icon: const Icon(Icons.delete_outline, size: 18, color: Colors.red), label: const Text('Delete', style: TextStyle(color: Colors.red, fontSize: 11)))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
