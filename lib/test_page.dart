import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          // Set primary color
          backgroundColor: Color(0xff007aff),
          items: [
            // Set tab icons
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person),
              label: 'Profile',
            ),
          ],
        ),
        tabBuilder: (context, index) {
          return CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              // Set title text style
              middle: Text(
                index == 0 ? 'Home' : 'Profile',
                style: CupertinoTextThemeData().navTitleTextStyle.copyWith(
                      // Set title font size
                      fontSize: 20,
                      // Set title color based on index
                      color: index == 0
                          ? Colors.white
                          : CupertinoColors.systemGrey,
                    ),
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  // Add search bar with border radius
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: CupertinoColors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: CupertinoTextField(
                      // Set search bar text style
                      style: CupertinoTextThemeData().textStyle.copyWith(
                            fontSize: 16,
                            color: CupertinoColors.systemGrey,
                          ),
                      placeholder: 'Search',
                      prefix: Icon(CupertinoIcons.search),
                    ),
                  ),
                  // Add segment control
                  CupertinoSlidingSegmentedControl(
                    // Set segment control text style
                    groupValue: index == 0 ? 'tab1' : 'tab2',
                    children: {
                      'tab1': Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Tab 1',
                          style: CupertinoTextThemeData()
                              .navActionTextStyle
                              .copyWith(
                                fontSize: 16,
                              ),
                        ),
                      ),
                      'tab2': Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Tab 2',
                          style: CupertinoTextThemeData()
                              .navActionTextStyle
                              .copyWith(
                                fontSize: 16,
                              ),
                        ),
                      ),
                    },
                    onValueChanged: (value) {},
                  ),
                  // Add list view
                  Expanded(
                    child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: CupertinoColors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: CupertinoListTile(
                            leading: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.blueGrey,
                                image: DecorationImage(
                                  image: NetworkImage(
                                    'https://picsum.photos/200',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            title: Text(
                              'List item title',
                              style: CupertinoTextThemeData()
                                  .navActionTextStyle
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            subtitle: Text(
                              'List item subtitle',
                              style:
                                  CupertinoTextThemeData().textStyle.copyWith(
                                        fontSize: 16,
                                        color: CupertinoColors.systemGrey,
                                      ),
                            ),
                            onTap: () {},
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
