import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class OrdersListScreen extends StatelessWidget {
  final String filterType;

  const OrdersListScreen({super.key, required this.filterType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                Text(
                  '$filterType Orders',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // Orders List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: 10,
              itemBuilder: (context, index) {
                // Dummy data
                final Map<String, dynamic> order = _getDummyOrder(index, filterType);

                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.only(bottom: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/order-detail',
                        arguments: order,
                      );
                    },
                    borderRadius: BorderRadius.circular(15),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: [
                          // Order Icon
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: _getStatusColor(order['status']).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              _getStatusIcon(order['status']),
                              color: _getStatusColor(order['status']),
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 15),

                          // Order Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Order #${order['id']}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  order['date'],
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Status Badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor(order['status']).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              order['status'],
                              style: TextStyle(
                                color: _getStatusColor(order['status']),
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> _getDummyOrder(int index, String filterType) {
    final List<String> statuses = [
      if (filterType == 'All' || filterType == 'Pending') 'Pending',
      if (filterType == 'All' || filterType == 'Delivered') 'Delivered',
      if (filterType == 'All' || filterType == 'Out for Delivery') 'Out for Delivery',
    ];

    final status = filterType == 'All'
        ? statuses[index % statuses.length]
        : filterType;

    return {
      'id': 'ORD${10000 + index}',
      'date': '${DateTime.now().subtract(Duration(days: index)).day}/11/2023',
      'status': status,
      'fromName': 'John Doe',
      'fromAddress': '123 Business Street, NY 10001',
      'fromPhone': '+1 (555) 123-4567',
      'fromEmail': 'john.doe@email.com',
      'toName': 'Sarah Johnson',
      'toAddress': '456 Park Avenue, NY 11201',
      'toPhone': '+1 (555) 987-6543',
      'toEmail': 'sarah.j@email.com',
      'orderDetails': {
        'type': 'Box',
        'dimensions': '30x20x15 cm',
        'weight': '2.5 kg',
        'value': '\$150',
      },
    };
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return const Color(0xFFF59E0B);
      case 'Delivered':
        return const Color(0xFF10B981);
      case 'Out for Delivery':
        return const Color(0xFF6366F1);
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'Pending':
        return Icons.pending_actions_outlined;
      case 'Delivered':
        return Icons.check_circle_outline;
      case 'Out for Delivery':
        return Icons.local_shipping_outlined;
      default:
        return Icons.inventory_2_outlined;
    }
  }
}