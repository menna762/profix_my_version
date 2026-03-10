import 'package:flutter/material.dart';

class AvailabilityCard extends StatefulWidget {
  const AvailabilityCard({super.key});

  @override
  State<AvailabilityCard> createState() => _AvailabilityCardState();
}

class _AvailabilityCardState extends State<AvailabilityCard> {
  bool isOnline = true;

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // تقليل الـ vertical padding
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.wifi_tethering,
            color: isOnline ? Colors.green : Colors.grey,
            size: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Availability",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                Text(
                  isOnline ? "Online — receiving requests" : "Offline",
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? Colors.white54 : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),

          // هنا بنستخدم Switch العادي مع تصغير حجمه عشان ميبقاش ضخم
          Transform.scale(
            scale: 0.8, // دي اللي بتصغر حجم السويتش نفسه
            child: Switch(
              value: isOnline,
              activeColor: Colors.white, // لون الدائرة وهي شغالة
              activeTrackColor: Colors.blue, // لون الخلفية وهي شغالة
              inactiveThumbColor: Colors.white, // لون الدائرة وهي مطفية
              inactiveTrackColor: Colors.grey[300], // لون الخلفية وهي مطفية
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // بيشيل الفراغات اللي حواليه
              onChanged: (newValue) {
                setState(() {
                  isOnline = newValue;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}