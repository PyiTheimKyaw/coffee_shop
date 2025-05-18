import 'package:coffee_shop/data/vos/coffee_vo.dart';
import 'package:coffee_shop/pages/index_page.dart';
import 'package:coffee_shop/pages/order_tracking_page.dart';
import 'package:go_router/go_router.dart';
import '../pages/detail_page.dart';
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
        name: RouteConstants.kRouteIndex,
        path: '/index',
        builder: (context, state) => const IndexPage(),
        routes: [
          GoRoute(
            name: RouteConstants.kRouteDetails,
            path: 'detail',
            builder: (context, state) {
              final coffee = state.extra! as CoffeeVO?;
              return DetailPage(coffee: coffee);
            },
          ),
          GoRoute(
            name: RouteConstants.kRouteOrder,
            path: 'order',
            builder: (context, state) {
              final coffee = state.extra! as CoffeeVO?;
              final price = state.uri.queryParameters['price'] ?? "0";
              return OrderPage(coffee: coffee,price:double.tryParse(price));
            },
          ),
          GoRoute(
            name: RouteConstants.kRouteOrderTrackPage,
            path: 'orderTrackPage',
            builder: (context, state) {
              return OrderTrackingPage();
            },
          ),
        ],
      ),
    ],
  );
}
