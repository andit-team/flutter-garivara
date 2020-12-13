class DemoCarDetails{
  String title;
  String data;
  DemoCarDetails({this.title,this.data});
  static final List<DemoCarDetails> demoCarDetails = [
    DemoCarDetails(title: 'Model',data: 'GT5000'),
    DemoCarDetails(title: 'Capacity',data: '760hp'),
    DemoCarDetails(title: 'Color',data: 'Ash'),
    DemoCarDetails(title: 'Fuel type',data: 'Octane'),
    DemoCarDetails(title: 'Gear type',data: 'Automatic'),
    DemoCarDetails(title: 'Manufacture year',data: '2020'),
    DemoCarDetails(title: 'Vehicle CC',data: '2000'),
    DemoCarDetails(title: 'Mileage',data: '20km'),
    DemoCarDetails(title: 'Tires no',data: '4'),
    DemoCarDetails(title: 'Vehicle length',data: '4,832 mm'),
  ];
}


class DemoNews{
  String image;
  String title;
  int time;
  DemoNews({this.title, this.image, this.time});


  static final List<DemoNews> demoNews = [
    DemoNews(image: 'https://cdn.motor1.com/images/mgl/x49ez/s4/team-oneil.jpg', title: 'Lorem Ipsum news',time: 2),
    DemoNews(image: 'https://media.ed.edmunds-media.com/nissan/armada/2021/fe/2021_nissan_armada_actf34_fe_1204203_300.jpg', title: 'Lorem Ipsum news',time: 4),
    DemoNews(image: 'https://www.carscoops.com/wp-content/uploads/2020/12/lamborghini-huracan-evo-rwd-lady-gaga-0-1024x556.jpg', title: 'Lorem Ipsum news',time: 5),
    DemoNews(image: 'https://cars.usnews.com/pics/size/640x420/static/images/article/202001/128365/1_title_2020_kia_sorento_640x420.jpg', title: 'Lorem Ipsum news',time: 12),
    DemoNews(image: 'https://c.files.bbci.co.uk/11F0/production/_116029540_eo80ncgxiaazjqv.jpg', title: 'Lorem Ipsum news',time: 4),
    DemoNews(image: 'https://img.indianautosblog.com/crop/464x260/2020/12/11/kris-jenner-rolls-royce-ghost-edb1.jpg', title: 'Lorem Ipsum news',time: 22),
    DemoNews(image: 'https://cdn.motor1.com/images/mgl/b3VRk/s4/watch-the-2021-bmw-m5-competition-eat-up-the-autobahn-at-193-mph.jpg', title: 'Lorem Ipsum news',time: 23),
    DemoNews(image: 'https://cdn.motor1.com/images/mgl/RPN33/s4/vw-golf-gti-ford-focus-st-octavia-rs-drag-race.jpg', title: 'Lorem Ipsum news',time: 2),
    DemoNews(image: 'https://imagevars.gulfnews.com/2020/12/08/auto-classic_176425f8d33_large.jpg', title: 'Lorem Ipsum news',time: 12),
    DemoNews(image: 'https://img.etimg.com/thumb/width-1200,height-900,imgsize-185983,resizemode-1,msid-68823937/industry/auto/auto-news/production-curbs-help-auto-firms-reduce-inventory.jpg', title: 'Lorem Ipsum news',time: 6),
  ];

}


class DemoPromotion{
  String image;
  String code;

  DemoPromotion({this.image, this.code});

  static final List<DemoPromotion> demoPromotions = [
    DemoPromotion(image: 'https://i.pinimg.com/736x/5c/67/0c/5c670ccd21222600bd4ccaf9094bd129.jpg', code: '12341'),
    DemoPromotion(image: 'https://img.freepik.com/free-vector/online-store-quarantine-promo-banner-template_1361-2358.jpg?size=626&ext=jpg', code: 'ASD123'),
    DemoPromotion(image: 'https://img.freepik.com/free-vector/promotion-fashion-banner_1188-223.jpg?size=626&ext=jpg', code: 'QWE123'),
    DemoPromotion(image: 'https://img.freepik.com/free-vector/modern-black-friday-super-sale-with-red-splash-banner-design_1361-2784.jpg?size=626&ext=jpg', code: 'QW465E'),
    DemoPromotion(image: 'https://img.freepik.com/free-vector/floral-new-collection-banner-template_1361-1251.jpg?size=626&ext=jpg', code: 'SDG64SD'),
    DemoPromotion(image: 'https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/ea996e45377079.5937175b5b421.jpg', code: 'QEW654R'),
    DemoPromotion(image: 'https://i.pinimg.com/originals/99/18/01/99180113a9b30c6bd1256bbf23363be0.png', code: '49948XC'),
    DemoPromotion(image: 'https://images.yoins.com/html/topic/Yoinsday-May-M/images/banner3.jpg', code: '987UIY'),
    DemoPromotion(image: 'https://img.banggood.com/crm_customers_images/big_banner0-36-0.jpg', code: '3521AQ'),
    DemoPromotion(image: 'https://i.pinimg.com/originals/76/3b/d7/763bd70325329ca7c38a99f661734c7f.jpg', code: 'NG45NG'),
  ];
}