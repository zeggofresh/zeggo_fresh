import 'dart:async';
import 'package:flutter/material.dart';
import 'package:zeggo_fresh/core/theme/app_theme.dart';

class OrderTrackingScreen extends StatefulWidget {
  final List<Map<String, dynamic>> orderItems;
  final double totalAmount;

  const OrderTrackingScreen({
    super.key,
    required this.orderItems,
    required this.totalAmount,
  });

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> with TickerProviderStateMixin {
  int _remainingSeconds = 7 * 60; // 7 minutes in seconds
  late Timer _timer;
  String _deliveryStatus = "Order Confirmed";
  int _statusStep = 1;
  late AnimationController _bikeController;
  late Animation<Offset> _bikeAnimation;

  @override
  void initState() {
    super.initState();
    _startTimer();
    _updateStatus();
    _initBikeAnimation();
  }

  void _initBikeAnimation() {
    _bikeController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    
    _bikeAnimation = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: const Offset(1, 0),
    ).animate(CurvedAnimation(
      parent: _bikeController,
      curve: Curves.easeInOut,
    ));
    
    // Repeat the animation
    _bikeController.repeat(reverse: true);
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  void _updateStatus() {
    // Update status based on remaining time
    Timer.periodic(const Duration(seconds: 30), (timer) {
      if (_remainingSeconds <= 0) {
        timer.cancel();
        return;
      }

      setState(() {
        if (_remainingSeconds > 240) {
          // > 4 minutes
          _deliveryStatus = "Order Confirmed";
          _statusStep = 1;
        } else if (_remainingSeconds > 180) {
          // 3-4 minutes
          _deliveryStatus = "Preparing Your Order";
          _statusStep = 2;
        } else if (_remainingSeconds > 120) {
          // 2-3 minutes
          _deliveryStatus = "Out for Delivery";
          _statusStep = 3;
        } else if (_remainingSeconds > 60) {
          // 1-2 minutes
          _deliveryStatus = "Almost There";
          _statusStep = 4;
        } else {
          // < 1 minute
          _deliveryStatus = "Arriving Now";
          _statusStep = 5;
        }
      });
    });
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer.cancel();
    _bikeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Order Tracking",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Order status header with modern design
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Estimated Delivery",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppTheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _deliveryStatus,
                        style: TextStyle(
                          color: AppTheme.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Text(
                  _formatTime(_remainingSeconds),
                  style: const TextStyle(
                    color: AppTheme.primary,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  "minutes",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Progress indicator - Zepto style
          Container(
            height: 120,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Stack(
              children: [
                // Connecting lines
                Positioned(
                  top: 20,
                  left: 40,
                  right: 40,
                  child: Container(
                    height: 3,
                    color: Colors.grey[300],
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 40,
                  right: 40,
                  child: Container(
                    height: 3,
                    width: _statusStep >= 2 ? (MediaQuery.of(context).size.width - 80) * (_statusStep - 1) / 4 : 0,
                    color: AppTheme.primary,
                  ),
                ),
                
                // Status indicators
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildZeptoStatusIndicator(1, "Confirmed", _statusStep >= 1),
                    _buildZeptoStatusIndicator(2, "Prepared", _statusStep >= 2),
                    _buildZeptoStatusIndicator(3, "On the way", _statusStep >= 3),
                    _buildZeptoStatusIndicator(4, "Near you", _statusStep >= 4),
                    _buildZeptoStatusIndicator(5, "Delivered", _statusStep >= 5),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Map section with animated bike
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Map header
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                      color: AppTheme.primary,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on, color: Colors.white),
                        SizedBox(width: 10),
                        Text(
                          "Live Tracking",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Map content with animated elements
                  Expanded(
                    child: Stack(
                      children: [
                        // Map background with gradient
                        Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFFE8F5E9),
                                Color(0xFFC8E6C9),
                              ],
                            ),
                          ),
                          child: CustomPaint(
                            painter: MapPainter(),
                            child: Container(),
                          ),
                        ),
                        
                        // Animated delivery bike
                        Positioned(
                          bottom: 100,
                          left: 0,
                          right: 0,
                          child: SlideTransition(
                            position: _bikeAnimation,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.motorcycle,
                                  size: 40,
                                  color: AppTheme.primary,
                                ),
                              ],
                            ),
                          ),
                        ),
                        
                        // Destination marker
                        const Positioned(
                          top: 80,
                          right: 60,
                          child: Icon(
                            Icons.location_pin,
                            size: 40,
                            color: Colors.red,
                          ),
                        ),
                        
                        // User location marker
                        const Positioned(
                          bottom: 60,
                          left: 60,
                          child: Icon(
                            Icons.home,
                            size: 30,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Order summary
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Order Summary",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                ...widget.orderItems.map((item) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: AssetImage(item['image']),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            item['name'],
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Text(
                          "₹${item['price']}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                const Divider(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "₹${widget.totalAmount.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildZeptoStatusIndicator(int step, String label, bool isActive) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isActive ? AppTheme.primary : Colors.white,
            shape: BoxShape.circle,
            border: Border.all(
              color: isActive ? AppTheme.primary : Colors.grey[300]!,
              width: 2,
            ),
          ),
          child: Center(
            child: isActive
                ? Icon(
                    step == 1
                        ? Icons.check_circle
                        : step == 5
                            ? Icons.check
                            : Icons.check_circle_outline,
                    color: Colors.white,
                    size: 20,
                  )
                : Text(
                    step.toString(),
                    style: TextStyle(
                      color: isActive ? Colors.white : Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isActive ? AppTheme.primary : Colors.grey,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

// Custom painter for map-like appearance
class MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height * 0.7);
    path.lineTo(size.width * 0.2, size.height * 0.6);
    path.lineTo(size.width * 0.4, size.height * 0.65);
    path.lineTo(size.width * 0.6, size.height * 0.5);
    path.lineTo(size.width * 0.8, size.height * 0.55);
    path.lineTo(size.width, size.height * 0.4);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}