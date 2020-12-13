import 'package:andgarivara/Utils/controller/SizeConfigController.dart';
import 'package:andgarivara/demo/demoData.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NewsTileWidget extends StatelessWidget {

  final DemoNews news;
  NewsTileWidget({
    @required this.news
});

  final GetSizeConfig sizeConfig = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.dialog(Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(sizeConfig.width * 25)),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AspectRatio(
                    aspectRatio: 16/9,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(sizeConfig.width * 25),
                          topLeft: Radius.circular(sizeConfig.width * 25),
                        ),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            news.image
                          ),
                          fit: BoxFit.cover
                        )
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: sizeConfig.height * 15,),
                        Text(
                          news.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: sizeConfig.getPixels(20)
                          ),
                        ),
                        SizedBox(height: sizeConfig.height * 5,),
                        Text(
                          DateFormat('dd MMM yyyy').format(DateTime.now()),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: sizeConfig.getPixels(14)
                          ),
                        ),
                        SizedBox(height: sizeConfig.height * 10,),
                        Text(
                          '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut id nulla non felis pulvinar fringilla. Ut mauris enim, eleifend sed ultrices eget, lacinia id orci. Duis ex magna, consectetur a pulvinar ut, feugiat eget nulla. Praesent venenatis nulla non augue laoreet condimentum. Vestibulum sed bibendum ligula. Quisque non leo congue erat volutpat cursus. Ut nec sodales erat.

Aenean convallis nisi sit amet aliquam dignissim. Nulla fringilla tortor et egestas facilisis. Fusce id tellus eget dui sollicitudin congue. Aliquam erat volutpat. Curabitur elementum felis quis justo eleifend, a hendrerit metus fringilla. Curabitur pharetra imperdiet nibh, sit amet congue lectus volutpat vel. Fusce in mattis libero. Integer imperdiet at nunc non ullamcorper. Fusce laoreet consequat accumsan. Aliquam erat volutpat.

Vestibulum volutpat, ante a efficitur luctus, purus dolor pharetra lacus, at tristique odio tortor sit amet odio. Duis sollicitudin consectetur eleifend. Ut scelerisque, elit ac gravida faucibus, ligula est auctor nisi, et blandit turpis diam imperdiet enim. Proin mi massa, accumsan in porta nec, mattis at massa. Nunc id nisl a velit rhoncus fermentum. Pellentesque congue quam quam, et porttitor risus iaculis ac. Nullam neque nulla, gravida rhoncus tellus a, pharetra fermentum dui. Donec id tellus odio. In sagittis rutrum urna finibus feugiat.''',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 15,
                          style: TextStyle(
                              fontSize: sizeConfig.getPixels(16)
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          )
        ));
      },
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(sizeConfig.width * 25),
            image: DecorationImage(
              image: CachedNetworkImageProvider(
                news.image
              ),
              fit: BoxFit.cover
            )
          ),
          child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      news.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Roboto-M',
                          fontSize: sizeConfig.getPixels(18)
                      ),
                    ),
                    Text(
                      '${news.time} hours ago',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Roboto-M',
                          fontSize: sizeConfig.getPixels(12)
                      ),
                    ),
                  ],
                ),
              )
          )
      ),
    );
  }
}
