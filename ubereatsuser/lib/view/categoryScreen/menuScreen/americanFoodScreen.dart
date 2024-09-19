import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ubereatsuser/utils/colors.dart';
import 'package:ubereatsuser/widgets/toastServices.dart';

class AmericanFoodScreen extends StatelessWidget {
  final List promotionList = [
    'assets/images/categories/american/bn1.jfif',
    'assets/images/categories/american/bn2.jfif',
    'assets/images/categories/american/bn3.jfif',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mục đồ ăn Mỹ'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
              ),
              items: promotionList
                  .map((item) => Center(
                        child:
                            Image.asset(item, fit: BoxFit.cover, width: 1000),
                      ))
                  .toList(),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Danh sách món ăn Mỹ',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  GiftItem(
                    image: 'assets/images/categories/american/ame1.jfif',
                    title: 'Đồ ăn Mỹ 1',
                    description: 'Nhà hàng A',
                    price: '79,000 VND',
                  ),
                  GiftItem(
                    image: 'assets/images/categories/american/ame2.jfif',
                    title: 'Đồ ăn Mỹ 2',
                    description: 'Nhà hàng B',
                    price: '79,000 VND',
                  ),
                  GiftItem(
                    image: 'assets/images/categories/american/ame3.jfif',
                    title: 'Đồ ăn Mỹ 3',
                    description: 'Nhà hàng C',
                    price: '79,000 VND',
                  ),
                  GiftItem(
                    image: 'assets/images/categories/american/ame4.jfif',
                    title: 'Đồ ăn Mỹ 4',
                    description: 'Nhà hàng D',
                    price: '79,000 VND',
                  ),
                  GiftItem(
                    image: 'assets/images/categories/american/ame5.jfif',
                    title: 'Đồ ăn Mỹ 5',
                    description: 'Nhà hàng E',
                    price: '79,000 VND',
                  ),

                  // Thêm các GiftItem khác tương tự
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GiftItem extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String price;

  GiftItem(
      {required this.image,
      required this.title,
      required this.description,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.asset(image, width: 100, height: 100, fit: BoxFit.cover),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                Text(description),
                Text(price,
                    style: const TextStyle(fontSize: 16, color: Colors.red)),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    ToastService.sendScaffoldAlert(
                        msg: 'Bạn đã thêm vào giỏ hàng thành công',
                        toastStatus: 'SUCCESS',
                        context: context);
                  },
                  child: const Text('Thêm vào giỏ hàng'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
