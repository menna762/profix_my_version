import 'package:flutter/material.dart';
import 'package:app/features/customer/auth/home_screen/tabs/profile_tab/account/address.dart';
import 'package:app/widgets/custom_address_card.dart';
import 'package:app/widgets/custom_new_address_form.dart';

class TechnicalAddress extends StatefulWidget {

  static String routeName = "technicalAddress";

  @override
  State<TechnicalAddress> createState() => _TechnicalAddressState();
}

class _TechnicalAddressState extends State<TechnicalAddress> {
  bool isAdding = false;
  Map<String, dynamic>? editingAddress; // متغير لحفظ العنوان اللي بنعدله حالياً

  List<Map<String, dynamic>> addresses = [
    {
      'id': 1,
      'title': 'Home',
      'icon': Icons.home_outlined,
      'isDefault': true,
      'address': '123 Main Street, Apt 4B\nNew York',
    },
    {
      'id': 2,
      'title': 'Work',
      'icon': Icons.work_outline,
      'isDefault': false,
      'address': '456 Business Ave, Floor 3\nNew York',
      'note': 'Use side entrance',
    }
  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20), // شكل سهم أشيك
            onPressed: () =>  Navigator.pop(context)//of(context).pushReplacementNamed(ProfileTab.routeName)
        ),
        title: const Text('My Addresses', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ...addresses.map((addr) => Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: AddressCard(
              icon: addr['icon'],
              title: addr['title'],
              isDefault: addr['isDefault'],
              address: addr['address'],
              note: addr['note'],
              onDelete: () => deleteAddress(addr['id']),
              onEdit: () {
                setState(() {
                  editingAddress = addr; // تحديد العنوان المراد تعديله
                  isAdding = true; // فتح الفورم
                });
              },
            ),
          )),
          if (!isAdding)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: OutlinedButton(
                onPressed: () => setState(() {
                  editingAddress = null;
                  isAdding = true;
                }),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.grey.shade400),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, color: Colors.black87),
                    SizedBox(width: 8),
                    Text('Add New Address', style: TextStyle(color: Colors.black87, fontSize: 16)),
                  ],
                ),
              ),
            )
          else
            NewAddressForm(
              initialData: editingAddress, // تمرير البيانات القديمة للفورم
              onCancel: () => setState(() {
                isAdding = false;
                editingAddress = null;
              }),
              onSave: (label, address, note) => saveAddress(label, address, note),
            ),
        ],
      ),
    );
  }
  void deleteAddress(int id) {
    setState(() {
      addresses.removeWhere((element) => element['id'] == id);
    });
  }
  void saveAddress(String label, String fullAddress, String note) {
    setState(() {
      if (editingAddress != null) {
        // حالة التعديل: ابحث عن العنصر بالـ ID وغير بياناته
        int index = addresses.indexWhere((element) => element['id'] == editingAddress!['id']);
        addresses[index] = {
          ...addresses[index],
          'title': label,
          'address': fullAddress,
          'note': note.isEmpty ? null : note,
          'icon': label == "Home" ? Icons.home_outlined : (label == "Work" ? Icons.work_outline : Icons.location_on_outlined),
        };
      } else {
        // حالة الإضافة الجديدة
        addresses.add({
          'id': DateTime.now().millisecondsSinceEpoch,
          'title': label,
          'icon': label == "Home" ? Icons.home_outlined : (label == "Work" ? Icons.work_outline : Icons.location_on_outlined),
          'isDefault': false,
          'address': fullAddress,
          'note': note.isEmpty ? null : note,
        });
      }
      isAdding = false;
      editingAddress = null; // تصفير حالة التعديل
    });
  }
  }

