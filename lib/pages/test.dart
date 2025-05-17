import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: DeliveryToggle(),
        ),
      ),
    );
  }
}

class DeliveryToggle extends StatefulWidget {
  @override
  _DeliveryToggleState createState() => _DeliveryToggleState();
}

class _DeliveryToggleState extends State<DeliveryToggle> {
  bool isDeliverySelected = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTab("Deliver", isDeliverySelected, () {
            setState(() {
              isDeliverySelected = true;
            });
          }),
          _buildTab("Pick Up", !isDeliverySelected, () {
            setState(() {
              isDeliverySelected = false;
            });
          }),
        ],
      ),
    );
  }

  Widget _buildTab(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFFCC7A4C) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
