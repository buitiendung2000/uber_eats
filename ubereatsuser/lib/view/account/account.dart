import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:ubereatsuser/view/account/giftScreen/giftScreen.dart';
import 'package:ubereatsuser/view/account/promotionScreen/promotionScreen.dart';
import 'package:ubereatsuser/view/account/rewardRestaurantScreen/rewardRestaurants.dart';
import 'package:ubereatsuser/view/chatBot/chatBot.dart';
import 'package:ubereatsuser/view/payCard/payCardView.dart';
import '../../controller/provider/profileProvider/profileProvider.dart';
import '../../controller/services/authServices/mobileAuthServices.dart';
import '../../model/userModel.dart';
import '../../utils/colors.dart';
import '../../utils/textStyles.dart';
import '../../widgets/toastServices.dart';
import '../addressScreen/addressScreen.dart';
import '../orderHistory/orderHistory.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  List account = [
    [FontAwesomeIcons.shop, 'Đơn hàng'],
    [FontAwesomeIcons.locationPin, 'Địa chỉ'],
    [FontAwesomeIcons.heart, 'Yêu thích'],
    [FontAwesomeIcons.star, 'Nhận thưởng'],
    [FontAwesomeIcons.wallet, 'Thanh toán qua thẻ'],
    [FontAwesomeIcons.gift, 'Quà tặng'],
    [FontAwesomeIcons.suitcase, 'Buisness preferences'],
    [FontAwesomeIcons.person, 'Hỗ trợ'],
    [FontAwesomeIcons.tag, 'Khuyến mãi'],
    [FontAwesomeIcons.ticket, 'Uber Pass'],
    [FontAwesomeIcons.suitcase, 'Vận chuyển'],
    [FontAwesomeIcons.gear, 'Cài đặt'],
    [FontAwesomeIcons.powerOff, 'Đăng xuất'],
  ];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileProvider>().fetchUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
        children: [
          SizedBox(
            height: 2.h,
          ),
          Consumer<ProfileProvider>(builder: (context, profileProvider, child) {
            if (profileProvider.userData == null) {
              return Row(
                children: [
                  CircleAvatar(
                    radius: 3.h,
                    backgroundColor: black,
                    child: CircleAvatar(
                      radius: 3.h - 2,
                      backgroundColor: white,
                      child: FaIcon(
                        FontAwesomeIcons.user,
                        size: 3.h,
                        color: grey,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    'Xin chào người dùng',
                    style: AppTextStyles.body16,
                  ),
                ],
              );
            } else {
              UserModel userData = profileProvider.userData!;
              return Row(
                children: [
                  CircleAvatar(
                    radius: 3.h,
                    backgroundColor: black,
                    child: CircleAvatar(
                      radius: 3.h - 2,
                      backgroundColor: white,
                      backgroundImage: NetworkImage(userData.profilePicURL),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    userData.name,
                    style: AppTextStyles.body16,
                  ),
                ],
              );
            }
          }),
          SizedBox(
            height: 4.h,
          ),
          ListView.builder(
              itemCount: account.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    if(index == 0){
                       Navigator.push(
                        context,
                        PageTransition(
                          child: const OrderHistoryScreen(),
                          type: PageTransitionType.rightToLeft,
                        ),
                      );
                    }
                    if (index == 1) {
                      Navigator.push(
                        context,
                        PageTransition(
                          child: const AddressScreen(),
                          type: PageTransitionType.rightToLeft,
                        ),
                      );
                    }
                    if (index == 3) {
                      Navigator.push(
                        context,
                        PageTransition(
                          child: const RewardRestaurantScreen(),
                          type: PageTransitionType.rightToLeft,
                        ),
                      );
                    }
                    if (index == 4) {
                      Navigator.push(
                        context,
                        PageTransition(
                          child: const PayCardView(),
                          type: PageTransitionType.rightToLeft,
                        ),
                      );
                    }
                    if (index == 5) {
                      Navigator.push(
                        context,
                        PageTransition(
                          child: const GiftScreen(),
                          type: PageTransitionType.rightToLeft,
                        ),
                      );
                    }
                     if (index == 7) {
                      Navigator.push(
                        context,
                        PageTransition(
                          child:   ChatBotScreen(),
                          type: PageTransitionType.rightToLeft,
                        ),
                      );
                    }
                     if (index == 8) {
                      Navigator.push(
                        context,
                        PageTransition(
                          child:   PromotionScreen(),
                          type: PageTransitionType.rightToLeft,
                        ),
                      );
                    }
                    if (index == (account.length - 1)) {
                      MobileAuthServices.signOut(context);
                      ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Đăng xuất thành công!'),
    ),
  );
       
         
                    }
                  },
                  leading: FaIcon(
                    account[index][0],
                    size: 2.h,
                    color: black,
                  ),
                  title: Text(
                    account[index][1],
                    style: AppTextStyles.body14,
                  ),
                );
              })
        ],
      )),
    );
  }
}