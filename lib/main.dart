import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:saloon_assist/constants/colors.dart';
import 'package:saloon_assist/controllers/authenticationControllers.dart';
import 'package:saloon_assist/controllers/bill_controller.dart';
import 'package:saloon_assist/controllers/closeworkController.dart';
import 'package:saloon_assist/controllers/productControllers.dart';
import 'package:saloon_assist/controllers/reportsControllers.dart';
import 'package:saloon_assist/controllers/servicesController.dart';
import 'package:saloon_assist/controllers/shopController.dart';
import 'package:saloon_assist/responsive.dart';
import 'package:saloon_assist/views/splashScreen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // print(Responsive.isDesktop(context));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
      // DeviceOrientation.landscapeLeft,
      // DeviceOrientation.landscapeRight,
    ]);
    bool isMobile = Responsive.isMobile(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenticationProvider>(
          create: (_) => AuthenticationProvider(),
        ),
        ChangeNotifierProvider<ShopController>(
          create: (_) => ShopController(),
        ),
        /*  ChangeNotifierProvider<AddStaffController>(
          create: (_) => AddStaffController(),
        ), */
        ChangeNotifierProvider<CloseWorkController>(
          create: (_) => CloseWorkController(),
        ),
        ChangeNotifierProvider<ReportController>(
          create: (_) => ReportController(),
        ),
        ChangeNotifierProvider<ProductController>(
          create: (_) => ProductController(),
        ),
        ChangeNotifierProvider<ServiceController>(
          create: (_) => ServiceController(),
        ),
        ChangeNotifierProvider<BillController>(
          create: (_) => BillController(),
        ),
        /*    ChangeNotifierProvider<ChairController>(
          create: (_) => ChairController(), 
        ),*/
      ],
      child: MaterialApp(
        title: 'Salon Assist',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          appBarTheme: AppBarTheme(
            scrolledUnderElevation: 0,
            elevation: 0,
            systemOverlayStyle:
                SystemUiOverlayStyle(statusBarColor: primaryColor),
            iconTheme: const IconThemeData(color: Colors.white),
            toolbarHeight: isMobile ? 56 : 100,
            backgroundColor: primaryColor,
            titleSpacing: 0,
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
