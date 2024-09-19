import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../utils/colors.dart';
import '../../utils/textStyles.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List categories = [
    ['assets/images/categories/alcohol.png', 'Rượu'],
    ['assets/images/categories/american.png', 'Đồ ăn Mỹ'],
    ['assets/images/categories/asian.png', 'Đồ ăn Á'],
    ['assets/images/categories/burger.png', 'Burger'],
    ['assets/images/categories/carrebian.png', 'Ca-ri-bê'],
    ['assets/images/categories/chinese.png', 'Đồ ăn Trung'],
    ['assets/images/categories/convenience.png', 'Tiện ích'],
    ['assets/images/categories/dessert.png', 'Tráng miệng'],
    ['assets/images/categories/fastFood.png', 'Đồ ăn nhanh'],
    ['assets/images/categories/flower.png', 'Hoa'],
    ['assets/images/categories/french.png', 'Đồ ăn Pháp'],
    ['assets/images/categories/grocery.png', 'Tạp hóa'],
    ['assets/images/categories/halal.png', 'Đồ ăn Halan'],
    ['assets/images/categories/icecream.png', 'Kem'],
    ['assets/images/categories/indian.png', 'Đồ ăn Ấn'],
    ['assets/images/categories/petSupplies.png', 'Đồ ăn Thú cưng'],
    ['assets/images/categories/retails.png', 'Bán lẻ'],
    ['assets/images/categories/ride.png', 'Xe cộ'],
    ['assets/images/categories/takeout.png', 'Đồ ăn mang đi'],
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
        children: [
          SizedBox(
            height: 2.h,
          ),
          Text(
            'Tất cả các danh mục',
            style: AppTextStyles.body16,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 3.h,
          ),
          GridView.builder(
              itemCount: categories.length,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 0.8,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            5.sp,
                          ),
                          color: greyShade3,
                        ),
                        child: Image(
                          image: AssetImage(
                            categories[index][0],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      categories[index][1],
                      style: AppTextStyles.small10Bold,
                    )
                  ],
                );
              })
        ],
      )),
    );
  }
}