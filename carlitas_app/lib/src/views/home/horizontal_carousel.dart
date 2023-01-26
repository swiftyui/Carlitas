import 'package:carlitas_app/src/models/carousel_item.dart';
import 'package:carlitas_app/src/views/home/home_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:lottie/lottie.dart';

class HorizontalCarousel extends StatefulWidget {
  const HorizontalCarousel({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HorizontalCarouselState createState() => _HorizontalCarouselState();
}

class _HorizontalCarouselState extends State<HorizontalCarousel> {
  // Local variables required for carousel
  final double _anchor = 0.0;
  final bool _center = true;
  final double _velocityFactor = 0.2;
  final double _itemExtent = 200;
  late InfiniteScrollController _controller;

  @override
  initState() {
    super.initState();
    _controller = InfiniteScrollController();
  }

  // // Carousel Items
  List<CarouselItem> items = const [
    CarouselItem(
      animationURL: 'assets/animations/order.json',
      title: 'Order Now',
      page: HomePage(),
    ),
    CarouselItem(
      animationURL: 'assets/animations/table.json',
      title: 'Book a Table',
      page: HomePage(),
    ),
  ];

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: 300,
            child: InfiniteCarousel.builder(
              itemCount: items.length,
              itemExtent: _itemExtent,
              center: _center,
              anchor: _anchor,
              velocityFactor: _velocityFactor,
              scrollBehavior: kIsWeb
                  ? ScrollConfiguration.of(context).copyWith(
                      dragDevices: {
                        // Allows to swipe in web browsers
                        PointerDeviceKind.touch,
                        PointerDeviceKind.mouse
                      },
                    )
                  : null,
              controller: _controller,
              itemBuilder: (context, itemIndex, realIndex) {
                return _buildCarouselCard(context, itemIndex, realIndex);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCarouselCard(
      BuildContext context, int itemIndex, int realIndex) {
    final currentOffset = _itemExtent * realIndex;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final diff = (_controller.offset - currentOffset);
        const maxPadding = 10.0;
        final carouselRatio = _itemExtent / maxPadding;

        return Padding(
          padding: EdgeInsets.only(
            top: (diff / carouselRatio).abs(),
            bottom: (diff / carouselRatio).abs(),
          ),
          child: child,
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: InkWell(
          onTap: () {
            // if ((user?.userData?.workEmailLinked == true &&
            //         user?.userData != null) ||
            //     items[itemIndex].title == 'Welcome') {
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => PageDetails(
            //         page: items[itemIndex].page,
            //         title: items[itemIndex].title,
            //       ),
            //     ),
            //   );
            // }
          },
          child: Container(
            padding: const EdgeInsets.only(top: 16.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.shadow.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: _animationItem(context, itemIndex),
          ),
        ),
      ),
    );
  }

  Widget _animationItem(BuildContext context, int itemIndex) {
    return Column(
      children: [
        Text(items[itemIndex].title, style: GoogleFonts.oswald(fontSize: 20)),
        const Spacer(),
        Lottie.asset(
          items[itemIndex].animationURL,
          height: 170,
        ),
        const Spacer()
      ],
    );
  }
}
