import 'package:flutter/material.dart';

class SideBar extends StatefulWidget {
  const SideBar({
    super.key,
    required this.height,
    required this.width,
    required this.navigator,
  });

  final double height;
  final double width;
  final GlobalKey<NavigatorState> navigator;

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  List<Map> menu = [
    {'title': 'Activities', 'routeName': '/activities'},
    {'title': 'Hotels', 'routeName': '/hotels'},
    {'title': 'Flights', 'routeName': '/flights'},
    {'title': 'Restaurants', 'routeName': '/restaurants'},
  ];

  int sidebarIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width * 0.25,
      color: const Color.fromARGB(255, 64, 48, 173),
      child: Column(
        children: [
          SizedBox(
            height: widget.height * 0.05,
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: menu.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return TextButton(
                onPressed: () {
                  setState(() {
                    sidebarIndex = index;
                  });

                  widget.navigator.currentState!
                      .pushNamed(menu[index]['routeName']);
                },
                style: TextButton.styleFrom(minimumSize: const Size(150, 150)),
                child: Text(
                  menu[index]['title'],
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: (index == sidebarIndex)
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: (index == sidebarIndex)
                            ? Colors.white
                            : Colors.white.withAlpha(200),
                      ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
