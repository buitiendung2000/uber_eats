import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ubereatsuser/utils/colors.dart';
import 'package:ubereatsuser/widgets/toastServices.dart';

class IceCreamScreen extends StatelessWidget {
  final List promotionList = [
    'assets/images/categories/icecream/bn1.jfif',
    'assets/images/categories/icecream/bn2.jfif',
    'assets/images/categories/icecream/bn3.jfif',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mục Món Kem'),
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
                    'Danh sách món Kem',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  GiftItem(
                    image: 'assets/images/categories/icecream/ic1.jfif',
                    title: 'Kem 1',
                    description: 'Cửa hàng A',
                    price: '79,000 VND',
                  ),
                  GiftItem(
                    image: 'assets/images/categories/icecream/ic2.jfif',
                    title: 'Kem 2',
                    description: 'Cửa hàng B',
                    price: '79,000 VND',
                  ),
                 GiftItem(
                    image: 'assets/images/categories/icecream/ic3.jfif',
                    title: 'Kem 3',
                    description: 'Cửa hàng C',
                    price: '79,000 VND',
                  ),
                  GiftItem(
                    image: 'assets/images/categories/icecream/ic4.jfif',
                    title: 'Kem 4',
                    description: 'Cửa hàng D',
                    price: '79,000 VND',
                  ),
                  GiftItem(
                    image: 'assets/images/categories/icecream/ic5.jfif',
                    title: 'Kem 5',
                    description: 'Cửa hàng E',
                    price: '79,000 VND',
                  ),
                  GiftItem(
                    image: 'assets/images/categories/icecream/ic6.jfif',
                    title: 'Kem 6',
                    description: 'Cửa hàng F',
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
