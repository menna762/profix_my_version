import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/providers/theme_provider.dart';
import 'package:app/providers/user_provider.dart';
import 'package:app/utils/profix_images.dart';
import 'package:app/core/services/technician_service.dart';

class ServiceCategoriesPage extends StatefulWidget {
  const ServiceCategoriesPage({super.key});
  static String routeName = "serviceCategories";

  @override
  State<ServiceCategoriesPage> createState() => _ServiceCategoriesPageState();
}

class _ServiceCategoriesPageState extends State<ServiceCategoriesPage> {
  final TechnicianService _technicianService = TechnicianService();
  bool _isLoading = false;

  // List of service categories with their images
  final List<Map<String, dynamic>> serviceCategories = [
    {
      'id': 1,
      'name': 'Plumbing',
      'image': ProfixImages.plumbingImage,
      'isSelected': false,
    },
    {
      'id': 2,
      'name': 'Electrical',
      'image': ProfixImages.electricalImage,
      'isSelected': false,
    },
    {
      'id': 3,
      'name': 'Carpentry',
      'image': ProfixImages.carpentryImage,
      'isSelected': false,
    },
    {
      'id': 4,
      'name': 'Painting',
      'image': ProfixImages.paintingImage,
      'isSelected': false,
    },
    {
      'id': 5,
      'name': 'HVAC',
      'image': ProfixImages.hvacImage,
      'isSelected': false,
    },
    {
      'id': 6,
      'name': 'Cleaning',
      'image': ProfixImages.cleaningImage,
      'isSelected': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<AppThemeProvider>(context);
    final isDark = themeProvider.isDarkTheme();

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F1729) : const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xFF0F1729) : Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: isDark ? Colors.white : Colors.black,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Service Categories',
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ),
            )
          else
            TextButton(
              onPressed: _saveChanges,
              child: const Text(
                'Save Changes',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select your service categories',
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.8,
                ),
                itemCount: serviceCategories.length,
                itemBuilder: (context, index) {
                  final category = serviceCategories[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        serviceCategories[index]['isSelected'] = !category['isSelected'];
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1A2235) : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: category['isSelected']
                              ? Colors.blue
                              : (isDark ? Colors.white24 : Colors.grey.shade300),
                          width: category['isSelected'] ? 2 : 1,
                        ),
                        boxShadow: [
                          if (!isDark)
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: category['isSelected']
                                  ? Colors.blue.withValues(alpha: 0.1)
                                  : (isDark ? Colors.white12 : Colors.grey.shade100),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              _getCategoryIcon(category['name']),
                              size: 40,
                              color: category['isSelected']
                                  ? Colors.blue
                                  : (isDark ? Colors.white60 : Colors.grey.shade600),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            category['name'],
                            style: TextStyle(
                              color: isDark ? Colors.white : Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          if (category['isSelected'])
                            Container(
                              margin: const EdgeInsets.only(top: 8),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                'Selected',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String categoryName) {
    switch (categoryName) {
      case 'Plumbing':
        return Icons.plumbing;
      case 'Electrical':
        return Icons.electrical_services;
      case 'Carpentry':
        return Icons.carpenter;
      case 'Painting':
        return Icons.format_paint;
      case 'HVAC':
        return Icons.ac_unit;
      case 'Cleaning':
        return Icons.cleaning_services;
      default:
        return Icons.category;
    }
  }

  void _saveChanges() async {
    // Get selected categories
    final List<String> selectedCategories = serviceCategories
        .where((category) => category['isSelected'])
        .map((category) => category['name'] as String)
        .toList();

    if (selectedCategories.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one service category'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final technicianId = userProvider.id;

      if (technicianId != null) {
        // Send selected categories to backend
        await _technicianService.updateServiceCategories(technicianId, selectedCategories);
        
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Service categories updated successfully!'),
            backgroundColor: Colors.green,
          ),
        );

        // Navigate back
        Navigator.pop(context);
      } else {
        throw Exception('User ID not found');
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update service categories: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
