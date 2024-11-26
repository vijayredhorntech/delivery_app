import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SelectShippingAddressScreen extends StatefulWidget {
  const SelectShippingAddressScreen({super.key});

  @override
  State<SelectShippingAddressScreen> createState() => _SelectShippingAddressScreenState();
}

class _SelectShippingAddressScreenState extends State<SelectShippingAddressScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool isNewAddress = false;
  Map<String, String>? selectedAddress;

  // Dummy addresses for demonstration
  final List<Map<String, String>> savedAddresses = [
    {
      'name': 'John Smith',
      'address': '456 Park Avenue\nBrooklyn, NY 11201',
      'phone': '+1 (555) 987-6543',
      'email': 'john.smith@email.com',
    },
    {
      'name': 'Sarah Johnson',
      'address': '789 Main Street\nQueens, NY 11102',
      'phone': '+1 (555) 456-7890',
      'email': 'sarah.j@email.com',
    },
  ];

  // Controllers for new address
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Custom AppBar
            Container(
              padding: const EdgeInsets.only(top: 50, left: 10, right: 20, bottom: 20),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Select Shipping Address',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            // Shipping From Card
            Padding(
              padding: const EdgeInsets.all(20),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.location_on, color: AppColors.primary),
                          SizedBox(width: 10),
                          Text(
                            'Shipping From',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      _buildDetailRow(Icons.person, 'John Doe'),
                      _buildDetailRow(Icons.home, '123 Business Street\nNew York, NY 10001'),
                      _buildDetailRow(Icons.phone, '+1 (555) 123-4567'),
                      _buildDetailRow(Icons.email, 'john.doe@email.com'),
                    ],
                  ),
                ),
              ),
            ),

            // Shipping To Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Shipping To',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Address Options
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.search),
                          label: const Text('Search Address'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: !isNewAddress ? AppColors.primary : Colors.grey.shade200,
                            foregroundColor: !isNewAddress ? Colors.white : AppColors.textSecondary,
                          ),
                          onPressed: () {
                            setState(() {
                              isNewAddress = false;
                              _showSearchDialog();
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.add),
                          label: const Text('New Address'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isNewAddress ? AppColors.primary : Colors.grey.shade200,
                            foregroundColor: isNewAddress ? Colors.white : AppColors.textSecondary,
                          ),
                          onPressed: () {
                            setState(() {
                              isNewAddress = true;
                              selectedAddress = null;
                              _clearControllers();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Shipping To Card
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.location_on, color: AppColors.primary),
                              SizedBox(width: 10),
                              Text(
                                'Recipient Details',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          _buildInputField('Name', nameController, enabled: isNewAddress),
                          const SizedBox(height: 15),
                          _buildInputField('Address', addressController, enabled: isNewAddress, maxLines: 3),
                          const SizedBox(height: 15),
                          _buildInputField('Phone', phoneController, enabled: isNewAddress),
                          const SizedBox(height: 15),
                          _buildInputField('Email', emailController, enabled: isNewAddress),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Create Order Request Button
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                  elevation: 3,
                ),
                onPressed: () {
                  _showOrderCreatedDialog();
                },
                child: const Text(
                  'Create Order Request',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: AppColors.textSecondary),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller, {bool enabled = true, int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: enabled ? AppColors.textSecondary : Colors.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      ),
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search Saved Addresses'),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Search by name or address...',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
              const SizedBox(height: 20),
              ...savedAddresses.map((address) => ListTile(
                leading: const Icon(Icons.location_on),
                title: Text(address['name']!),
                subtitle: Text(address['address']!),
                onTap: () {
                  setState(() {
                    selectedAddress = address;
                    nameController.text = address['name']!;
                    addressController.text = address['address']!;
                    phoneController.text = address['phone']!;
                    emailController.text = address['email']!;
                  });
                  Navigator.pop(context);
                },
              )).toList(),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showOrderCreatedDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Success Icon
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 60,
              ),
            ),
            const SizedBox(height: 20),

            // Success Title
            const Text(
              'Order Request Created!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 15),

            // Order ID
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.receipt_long,
                    size: 20,
                    color: AppColors.primary,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Order ID: #LKJSLD45131',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            // Information Text
            Text(
              'Your Order Request has been created. Please wait for an agent to accept your request.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                height: 1.5,
              ),
            ),
          ],
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                    child: const Text(
                      'Done',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _clearControllers() {
    nameController.clear();
    addressController.clear();
    phoneController.clear();
    emailController.clear();
  }


}
