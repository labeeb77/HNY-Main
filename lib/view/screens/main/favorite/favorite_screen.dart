import 'package:flutter/material.dart';
import 'package:hny_main/view/screens/main/home/widgets_elements.dart';
import 'package:hny_main/view/widgets/back_button.dart';
import 'package:hny_main/view/widgets/common_app_bar.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const CommonAppBar(
        title: "My Favorites",
        showBorder: true,
        showLeading: false,
      ),
      body: OrientationBuilder(
        builder: (context, orientation) => ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
            child: buildCarCard(
                'Toyota Corolla',
                4.8,
                'Sedans',
                'Manual',
                'Petrol',
                '5 Seats',
                '7,000',
                'https://s3-alpha-sig.figma.com/img/ae74/a9e7/f68182d3f5fd6e910be717cb9f8591cb?Expires=1737936000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=alQGZUI7It7rs8a1I-5cxC~1mRbH6BWzXVfNnxJLLBO7vZ~eN6s-PkRTAwZByNo-p4PD1Y~X1R6iZall1SLd1lRepV9dcgtTJGRrizjrql8vS7-tDOuwcCirAlKtvUA-hhuDoavRc5UObrdvq3P0VNobd5Rx-XO23HogafOW-9~dMl6oyabdMQQpoZ7usDMxZgmta-KiE1ZzSWOv4UbYSpo-DKMtCGo5N70XLJz2FTJH9JEkH6ewsxGLCH5J5LDxhDIQj6qBNSQnothqq~78zzSwLUGMFn-aWntR3tuiXOvWOCZDnBtFjALoiBC-Jimnor0-0YfgQxn92BjVonKBxw__',
                true,
                context,
                orientation,
                mediaQuery),
          ),
        ),
      ),
    );
  }
}
