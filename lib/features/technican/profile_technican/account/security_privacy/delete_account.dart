import 'package:flutter/material.dart';

class DeleteAccountScreen extends StatefulWidget {
  static String routeName = "deleteAccount";
  @override
  _DeleteAccountScreenState createState() => _DeleteAccountScreenState();
}
class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  final TextEditingController _confirmController = TextEditingController();
  // متغير للتحكم في حالة الزرار (مفعل أو معطل)
  bool _isButtonEnabled = false;
  @override
  void initState() {
    super.initState();
    // مراقبة النص أثناء الكتابة
    _confirmController.addListener(() {
      setState(() {
        // الزرار يتفعل فقط لو كتب المستخدم كلمة DELETE بالظبط
        _isButtonEnabled = _confirmController.text.trim().toUpperCase() == "DELETE";
      });
    });
  }
  @override
  void dispose() {
    _confirmController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20), // شكل سهم أشيك
            onPressed: () =>  Navigator.pop(context)
        ),
        title: Text("Delete Account", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // مربع التحذير (Warning Box)
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.warning_amber_rounded, color: Colors.orange[800]),
                      SizedBox(width: 8),
                      Text("This action is irreversible",
                          style: TextStyle(color: Colors.red[800], fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    "All your data, requests, reviews, and chat history will be permanently deleted.",
                    style: TextStyle(color: Colors.grey[700], fontSize: 14),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),

            // حقل الإدخال
            Text("Type DELETE to confirm", style: TextStyle(fontWeight: FontWeight.w500)),
            SizedBox(height: 10),
            TextField(
              controller: _confirmController,
              decoration: InputDecoration(
                hintText: "DELETE",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
              ),
            ),
            SizedBox(height: 20),

            // زرار الحذف النهائي
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isButtonEnabled ? Colors.red[700] : Colors.red[200],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: _isButtonEnabled ? _onDeleteAccount : null,
                child: Text("Permanently Delete Account",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
  // دالة اللوجيك عند الضغط على الزرار
  void _onDeleteAccount() {
    // هنا تضعين كود المسح من الـ API أو Firebase
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirm Deletion"),
        content: Text("Are you absolutely sure?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
          TextButton(
              onPressed: () {
                // نفذ عملية الحذف هنا
                print("Account Deleted!");
              },
              child: Text("Delete", style: TextStyle(color: Colors.red))
          ),
        ],
      ),
    );
  }
}