import 'package:carlitas_app/src/views/home/horizontal_carousel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("Restaurant's Home"),
        actions: [
          IconButton(
              onPressed: () {
                _scaffoldKey.currentState?.openEndDrawer();
              },
              icon: Icon(Icons.account_circle_outlined,
                  color: Theme.of(context).appBarTheme.foregroundColor))
        ],
      ),
      body: _build(context),
      // endDrawer: const HomeDrawer(),
    );
  }

  Widget _build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          HorizontalCarousel(),
          Divider(thickness: 1),
        ],
      ),
    );
  }

  Widget _welcomeStack(BuildContext context) {
    return Container(
      height: 200,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Lottie.asset(
              'assets/animations/food.json',
              height: 350,
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: RotationTransition(
              turns: const AlwaysStoppedAnimation(-14 / 360),
              child: Text(
                'Welcome',
                style: GoogleFonts.getFont(
                  'Dancing Script',
                  fontSize: 60,
                  backgroundColor: Colors.white12,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
