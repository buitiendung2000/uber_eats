// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:reward_popup/reward_popup.dart';



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quà tặng',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      
    );
  }
}

class GiftScreen extends StatefulWidget {
  const GiftScreen({super.key});

  @override
  State<GiftScreen> createState() => _GiftScreenState();
}

class _GiftScreenState extends State<GiftScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Quà tặng ưu đãi từ Nhà hàng'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Chúc mừng bạn đã nhận được quà tặng từ Nhà hàng. Bấm để nhận ngay',
              style: TextStyle(color: Colors.white),
            ),
           
            ElevatedButton(
              onPressed: () => showRewardPopup(
                context,
                enableDismissByTappingOutside: true,
                child: const Positioned.fill(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Free ship'),
                       
                      Text('Freeship cho đơn hàng trên 30k'),
                    ],
                  ),
                ),
              ),
              child: const Text('Quà tặng thứ nhất'),
            ),
            ElevatedButton(
              onPressed: () => showRewardPopup(
                context,
                enableDismissByTappingOutside: true,
                dismissButton: TextButton(
                  child: const Text("Đóng"),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                child: const Positioned.fill(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Free ship'),
                       
                      Text('Freeship cho đơn hàng trên 50k'),
                    ],
                  ),
                ),
              ),
              child: const Text('Quà tặng thứ hai'),
            ),
            ElevatedButton(
              onPressed: () async {
                await showRewardPopup(
                  context,
                  enableDismissByTappingOutside: true,
                  child: const Positioned.fill(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Free ship'),
                       
                      Text('Freeship cho đơn hàng trên 70k'),
                      ],
                    ),
                  ),
                );
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Bỏ qua"),
                    ),
                  );
                }
              },
              child: const Text('Quà tặng thứ ba'),
            ),
            
          ],
        ),
      ),
    );
  }
}