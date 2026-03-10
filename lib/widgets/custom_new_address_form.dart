import 'package:flutter/material.dart';
import 'package:app/widgets/custom_text_Widget.dart';
import 'package:app/widgets/custom_text_field.dart';

class NewAddressForm extends StatefulWidget {
  final VoidCallback onCancel;
  final Function(String label, String address, String note) onSave;
  final Map<String, dynamic>? initialData; // بيانات العنوان القديم

  const NewAddressForm({super.key, required this.onCancel, required this.onSave, this.initialData});

  @override
  State<NewAddressForm> createState() => _NewAddressFormState();
}

class _NewAddressFormState extends State<NewAddressForm> {
  late String selectedLabel;
  late TextEditingController _addressController;
  late TextEditingController _noteController;
  @override
  void initState() {
    super.initState();
    // إذا كان هناك بيانات قديمة (تعديل)، نضعها في الحقول، وإلا نتركها افتراضية
    selectedLabel = widget.initialData?['title'] ?? "Home";
    _addressController = TextEditingController(text: widget.initialData?['address'] ?? "");
    _noteController = TextEditingController(text: widget.initialData?['note'] ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.initialData == null ? "New Address" : "Edit Address",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildLabelChip("Home"),
              _buildLabelChip("Work"),
              _buildLabelChip("Other"),
            ],
          ),
          const SizedBox(height: 16),
          CustomTextWidget(text: "Full Address", textStyle:TextStyle(fontWeight: FontWeight.w500) ),
          SizedBox(height: 8,),
          CustomTextField(hintText:"Street, Apt, Building" ,controller: _addressController,),
          SizedBox(height: 16),
          CustomTextWidget(text:" Notes (optional)", textStyle:TextStyle(fontWeight: FontWeight.w500) ),
          SizedBox(height: 8,),
          CustomTextField(hintText: "Delivery instructions...",controller: _noteController,maxLines: 3,),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (_addressController.text.isNotEmpty) {
                      widget.onSave(selectedLabel, _addressController.text, _noteController.text);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text("Save", style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: widget.onCancel,
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text("Cancel", style: TextStyle(color: Colors.black)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
  Widget _buildLabelChip(String text) {
    bool isSelected = selectedLabel == text;
    return GestureDetector(
      onTap: () => setState(() => selectedLabel = text),
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(text, style: TextStyle(color: isSelected ? Colors.white : Colors.black, fontSize: 13)),
      ),
    );
  }

}