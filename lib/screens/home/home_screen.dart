import 'package:flutter/material.dart';
import 'package:home_sweet/constants/colors.dart';
import 'package:home_sweet/my_custom_icon_icons.dart';

import '../../widgets/navbar.dart';
import 'widgets/management_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 32, bottom: 64),
                child: Row(
                  children: [
                    IconButton(
                      iconSize: 42,
                      icon: const Icon(MyCustomIcon.menu,
                          color: AppColors.primaryColor),
                      splashColor: AppColors.primaryColor.withOpacity(0.1),
                      highlightColor: AppColors.primaryColor.withOpacity(0.1),
                      padding: const EdgeInsets.all(0),
                      onPressed: () {},
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Column(
                        children: [
                          Text(
                            'کیان صداقتی',
                            style: textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'مدیر ساختمان',
                            style: textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 80,
                      height: 80,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        // color: Colors.grey,
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                          image: AssetImage('assets/images/manager.png'),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade400,
                            offset: const Offset(0, 3),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                // color: Colors.amber,
                height: 400,
                child: GridView.builder(
                  itemCount: 4,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 180,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemBuilder: (context, index) {
                    return ManagementItem(index: index);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
