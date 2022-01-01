import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:v_tech/app/data/theme/custom_theme.dart';
import 'package:v_tech/responsive.dart';


class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: (){}
          ),
        if (!Responsive.isMobile(context))
          Text(
            "Dashboard",
            style: Theme.of(context).textTheme.headline6,
          ),
        if (!Responsive.isMobile(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        Expanded(child: SearchField()),
        ProfileCard(userName: '',)
      ],
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String userName;
  const ProfileCard({
    Key? key, required this.userName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: SizeText.defaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: SizeText.defaultPadding,
        vertical: SizeText.defaultPadding / 2,
      ),
      child: Row(
        children: [
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: SizeText.defaultPadding / 2),
            child: Text("${userName}"),
          ),
          IconButton(
              onPressed: (){
                  Get.toNamed('/profile');
              },
              icon: Icon(Icons.person))
        ],
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search",
        fillColor: CustomColor.minHandEndColor,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(SizeText.defaultPadding * 0.75),
            margin: EdgeInsets.symmetric(horizontal: SizeText.defaultPadding / 2),
            decoration: BoxDecoration(
              color: CustomColor.clockBG,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: SvgPicture.asset("assets/icons/Search.svg"),
          ),
        ),
      ),
    );
  }
}
