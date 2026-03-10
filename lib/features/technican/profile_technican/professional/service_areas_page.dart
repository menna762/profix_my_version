import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/providers/theme_provider.dart';
import 'package:app/providers/user_provider.dart';
import 'package:app/core/services/technician_service.dart';
import 'package:app/l10n/app_localizations.dart';

class ServiceAreasPage extends StatefulWidget {
  const ServiceAreasPage({super.key});
  static String routeName = "serviceAreas";

  @override
  State<ServiceAreasPage> createState() => _ServiceAreasPageState();
}

class _ServiceAreasPageState extends State<ServiceAreasPage> {
  final TechnicianService _technicianService = TechnicianService();
  bool _isLoading = false;

  final List<String> _areaKeys = [
    'downtown',
    'midtown',
    'uptown',
    'eastSide',
    'westSide',
    'northDistrict',
    'southDistrict',
    'industrialZone',
    'suburbanArea',
    'businessDistrict',
  ];

  final Set<String> _selectedAreaKeys = {};

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<AppThemeProvider>(context);
    final isDark = themeProvider.isDarkTheme();
    final localizations = AppLocalizations.of(context)!;

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
          localizations.serviceAreas,
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    localizations.selectAreas,
                    style: TextStyle(
                      color: isDark ? Colors.white70 : Colors.grey.shade700,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 24),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 2.5,
                    ),
                    itemCount: _areaKeys.length,
                    itemBuilder: (context, index) {
                      final key = _areaKeys[index];
                      final isSelected = _selectedAreaKeys.contains(key);
                      final areaName = _getAreaName(key, localizations);

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              _selectedAreaKeys.remove(key);
                            } else {
                              _selectedAreaKeys.add(key);
                            }
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0xFF1A2235) : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? Colors.blue
                                  : (isDark ? Colors.white12 : Colors.grey.shade300),
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                color: isSelected ? Colors.blue : (isDark ? Colors.white38 : Colors.grey),
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  areaName,
                                  style: TextStyle(
                                    color: isDark ? Colors.white : Colors.black87,
                                    fontSize: 14,
                                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (isSelected)
                                const Icon(
                                  Icons.check,
                                  color: Colors.blue,
                                  size: 16,
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _saveAreas,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade700,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                        localizations.saveAreas,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getAreaName(String key, AppLocalizations l) {
    switch (key) {
      case 'downtown': return l.downtown;
      case 'midtown': return l.midtown;
      case 'uptown': return l.uptown;
      case 'eastSide': return l.eastSide;
      case 'westSide': return l.westSide;
      case 'northDistrict': return l.northDistrict;
      case 'southDistrict': return l.southDistrict;
      case 'industrialZone': return l.industrialZone;
      case 'suburbanArea': return l.suburbanArea;
      case 'businessDistrict': return l.businessDistrict;
      default: return key;
    }
  }

  void _saveAreas() async {
    final localizations = AppLocalizations.of(context)!;
    
    if (_selectedAreaKeys.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(localizations.pleaseSelectArea),
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
      final technicianId = userProvider.userId;

      if (technicianId != null) {
        final List<Map<String, dynamic>> areasData = _selectedAreaKeys.map((key) => {
          'name': _getAreaName(key, localizations),
          'key': key,
        }).toList();

        await _technicianService.updateServiceAreas(technicianId, areasData);
        
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(localizations.serviceAreasUpdated),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.pop(context);
      } else {
        throw Exception('User ID not found');
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${localizations.failedToUpdateAreas}: ${e.toString()}'),
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
