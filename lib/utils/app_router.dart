import 'package:go_router/go_router.dart';
import '../pages/detail_page.dart';
import '../pages/home_page.dart';
import '../pages/on_boarding_page.dart';
import '../pages/order_page.dart';
import 'route_constants.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        name: RouteConstants.kRouteOnBoarding,
        path: '/',
        builder: (context, state) => const OnBoardingPage(),
      ),
      GoRoute(
        name: RouteConstants.kRouteHome,
        path: '/home',
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
            name: RouteConstants.kRouteDetails,
            path: 'detail',
            builder: (context, state) => const DetailPage(),
          ),
          GoRoute(
            name: RouteConstants.kRouteOrder,
            path: 'order',
            builder: (context, state) => const OrderPage(),
          ),
        ],
      ),
    ],
  );
}
