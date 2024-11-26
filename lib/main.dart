import 'package:delivery_app/screens/deliver_order_screen.dart';
import 'package:delivery_app/screens/delivery_agent_dashboard.dart';
import 'package:delivery_app/screens/delivery_profile_screen.dart';
import 'package:delivery_app/screens/order_detail_screen.dart';
import 'package:delivery_app/screens/select_shipping_address_screen.dart';
import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/home_page.dart';
import 'screens/create_order_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delivery Tracker',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/create-order': (context) => const CreateOrderScreen(),
        '/select-shipping-address': (context) => const SelectShippingAddressScreen(),
        '/order-detail': (context) => const OrderDetailScreen(),
        '/deliver-agent-dashboard': (context) => const DeliveryAgentDashboard(),
        '/delivery-profile': (context) => const DeliveryProfileScreen(),
        '/deliver-order': (context) {
          final orderId = ModalRoute.of(context)!.settings.arguments as String;
          return DeliverOrderScreen(orderId: orderId);
        },
      },
    );
  }
}