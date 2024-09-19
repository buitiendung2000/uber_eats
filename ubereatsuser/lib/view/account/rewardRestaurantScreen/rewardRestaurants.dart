// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:reward_popup/reward_popup.dart';



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reward Restaurant',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
       
    );
  }
}

class RewardRestaurantScreen extends StatefulWidget {
  const RewardRestaurantScreen({super.key});

  @override
  State<RewardRestaurantScreen> createState() => _RewardRestaurantScreenState();
}

class _RewardRestaurantScreenState extends State<RewardRestaurantScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Ưu đãi của bạn'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Đạt đủ điểm nhận ngay 2 voucher hấp dẫn',
              style: TextStyle(color: Colors.white),
            ),
            ElevatedButton(
              onPressed: () async {
                final answer = await showRewardPopup<String>(
                  context,
                  backgroundColor: Colors.black,
                  child: Positioned.fill(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop(true);
                      },
                      child: Image.asset(
                        'assets/images/rewardRestaurant/vch.jfif',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
                //Use answer
              },
              child: const Text('Voucher đặc biệt thứ nhất'),
            ),
        
            ElevatedButton(
              onPressed: () async {
                final answer = await showRewardPopup<String>(
                  context,
                  backgroundColor: Colors.teal,
                  child: Positioned.fill(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop(true);
                      },
                      child: Image.asset(
                        'assets/images/rewardRestaurant/vch2.jfif',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                );
                //Use answer
              },
              child: const Text('Voucher đặc biệt thứ hai'),
            ),
          ],
        ),
      ),
    );
  }
}