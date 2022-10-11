import 'package:flutter/material.dart';
import 'package:travel_app/screens/activity_sreen.dart';
import 'package:travel_app/screens/hotel_screen.dart';
import 'package:travel_app/widgets/side_bar.dart';

void main() {
  runApp(const TravelApp());
}

class TravelApp extends StatelessWidget {
  const TravelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trave App',
      initialRoute: '/activities',
      routes: {
        ActivityScreen.routeName: (context) => const ActivityScreen(),
        HotelScreen.routeName: (context) => const HotelScreen(),
      },
      builder: (context, child) {
        return _TravelApp(
          navigator: (child!.key as GlobalKey<NavigatorState>),
          child: child,
        );
      },
    );
  }
}

class _TravelApp extends StatefulWidget {
  const _TravelApp({
    required this.navigator,
    required this.child,
  });

  final GlobalKey<NavigatorState> navigator;
  final Widget child;

  @override
  State<_TravelApp> createState() => _TravelAppState();
}

class _TravelAppState extends State<_TravelApp> {
  bool isOnboarding = true;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xfff5eddc),
      body: isOnboarding
          ? _buildOnboarding(context)
          : Row(
              children: [
                SideBar(
                  height: height,
                  width: width,
                  navigator: widget.navigator,
                ),
                Expanded(
                  child: widget.child,
                )
              ],
            ),
    );
  }

  Container _buildOnboarding(context) => Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background-2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.45,
            bottom: MediaQuery.of(context).size.height * 0.1,
            left: 30,
            right: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Hidden Treasures of Italy',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontSize: 65,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
              ),
              const Spacer(),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isOnboarding = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    padding: EdgeInsets.zero,
                    elevation: 0.0,
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.arrow_circle_right_outlined,
                        size: 50,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Explore Now',
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  color: Colors.white,
                                ),
                      )
                    ],
                  ))
            ],
          ),
        ),
      );
}
