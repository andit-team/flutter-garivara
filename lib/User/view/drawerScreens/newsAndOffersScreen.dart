import 'package:andgarivara/User/view/drawerScreens/widgets/newsAndOffersWidgets/newsTile.dart';
import 'package:andgarivara/Utils/appConst.dart';
import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:andgarivara/Utils/widgets/drawerlessAPpBar.dart';
import 'package:andgarivara/demo/demoData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'widgets/newsAndOffersWidgets/offerCardWidget.dart';
import 'widgets/newsAndOffersWidgets/promoTileWidget.dart';

class NewsAndOffersScreen extends StatelessWidget {
  final GetSizeConfig sizeConfig = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DrawerLessAppBar(),
      body: DefaultTabController(
        initialIndex: 1,
        length: 3,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: sizeConfig.getPixels(20)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey
                    )
                  )
                ),
                child: TabBar(
                  indicatorColor: AppConst.textBlue,
                  labelColor: AppConst.textBlue,
                  unselectedLabelColor: AppConst.textLight,
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                  unselectedLabelStyle: TextStyle(
                      fontWeight: FontWeight.normal
                  ),
                  tabs: [
                    Tab(child: Text('News'),),
                    Tab(child: Text('Offer'),),
                    Tab(child: Text('Promotion'),),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    StaggeredGridView.countBuilder(
                      crossAxisCount: 2,
                      padding: EdgeInsets.only(top: sizeConfig.height * 15),
                      crossAxisSpacing: sizeConfig.width * 15,
                      mainAxisSpacing: sizeConfig.height * 10,
                      itemCount: DemoNews.demoNews.length > 10 ? 10 : DemoNews.demoNews.length,
                      staggeredTileBuilder: (index){
                        return AppConst.stagListTile[index];
                      },
                      itemBuilder: (_,index){
                        DemoNews news = DemoNews.demoNews[index];
                        return NewsTileWidget(news: news);
                      },
                    ),
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: 10,
                      itemBuilder: (_,index){
                        return OfferCardWidget();
                      },
                    ),
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: DemoPromotion.demoPromotions.length,
                      itemBuilder: (_,index){
                        DemoPromotion promo = DemoPromotion.demoPromotions[index];
                        return PromoTileWidget(promo: promo);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}