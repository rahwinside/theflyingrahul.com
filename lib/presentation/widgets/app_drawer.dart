import 'package:aerium/core/layout/adaptive.dart';
import 'package:aerium/presentation/pages/widgets/socials.dart';
import 'package:aerium/presentation/widgets/app_logo.dart';
import 'package:aerium/presentation/widgets/custom_spacer.dart';
import 'package:aerium/presentation/widgets/nav_item.dart';
import 'package:aerium/presentation/widgets/spaces.dart';
import 'package:aerium/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({
    required this.menuList,
    required this.selectedItemRouteName,
    this.color = AppColors.black,
    this.width,
    this.onClose,
  });

  final String selectedItemRouteName;
  final List<NavItemData> menuList;
  final Color color;
  final double? width;
  final GestureTapCallback? onClose;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle? style = textTheme.bodyText1?.copyWith(
      color: AppColors.grey500,
      fontSize: Sizes.TEXT_SIZE_14,
    );
    return Container(
      width: width ?? widthOfScreen(context),
      height: heightOfScreen(context),
      child: Drawer(
        child: Container(
          color: color,
          width: width ?? widthOfScreen(context),
          height: heightOfScreen(context),
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(Sizes.PADDING_24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AppLogo(
                          fontSize: Sizes.TEXT_SIZE_40,
                          titleColor: AppColors.accentColor,
                        ),
                        Spacer(),
                        InkWell(
                          onTap: onClose ??
                              () {
                                Navigator.pop(context);
                              },
                          child: Icon(
                            FeatherIcons.x,
                            size: Sizes.ICON_SIZE_30,
                            color: AppColors.accentColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Spacer(flex: 2),
                        ..._buildMenuList(menuList: menuList, context: context),
                         Spacer(flex: 2),
                      ],
                    ),
                  ),
                  Text(
                    StringConst.COPYRIGHT,
                    style: style,
                  ),
                  SpaceH20(),
                ],
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  margin: EdgeInsets.only(
                      left: Sizes.MARGIN_24,
                      bottom: assignHeight(context, 0.1)),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Socials(
                      socialData: Data.socialData,
                      size: 18,
                      isHorizontal: false,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildMenuList({
    required BuildContext context,
    required List<NavItemData> menuList,
  }) {
    List<Widget> menuItems = [];
    for (var index = 0; index < menuList.length; index++) {
      menuItems.add(
        NavItem(
          onTap: () {
            Navigator.of(context).pushNamed(menuList[index].name);
          },
          index: index + 1,
          route: menuList[index].route,
          title: menuList[index].name,
          isMobile: true,
          isSelected:
              selectedItemRouteName == menuList[index].route ? true : false,
        ),
      );
      // menuItems.add(Spacer());
    }
    return menuItems;
  }
}