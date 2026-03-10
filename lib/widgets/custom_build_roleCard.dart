import 'package:flutter/material.dart';

class RoleCard extends StatelessWidget {
  final int index;
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const RoleCard({
    super.key,
    required this.index,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: Colors.blue.withValues(alpha: 0.1),
              blurRadius: 10,
              spreadRadius: 2,
            )
          ]
              : [],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                // هنا التعديل: العميل (1) بياخد أزرق، الفني (2) بياخد أخضر
                color: index == 1
                    ? Colors.blue.withValues(alpha: 0.1)
                    : Colors.green.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                // لون الأيقونة برضه بيتغير حسب الدور
                color: index == 1 ? Colors.blue.shade700 : Colors.green.shade700,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.blue : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
