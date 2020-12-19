class IntroModel{
  String image;
  String title;
  String text1;
  String text2;
  IntroModel({this.image,this.title,this.text1,this.text2});
}

final List<IntroModel> introItems = [
  IntroModel(
      image: 'assets/images/intro/driver_captain_job.png',
      title: 'Get Job Offers',
      text1: 'Captain Job to the rescue!',
      text2: 'Sed ut perspiciatis unde omnis istpoe natus error sit voluptatem accusantium doloremque eopsloi laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et.'
  ),
  IntroModel(
      image: 'assets/images/intro/driver_live_tracking.png',
      title: 'Realtime Tracking',
      text1: 'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit laborum.',
      text2: 'Sed ut perspiciatis unde omnis istpoe natus error sit voluptatem accusantium doloremque eopsloi laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et.'
  ),
  IntroModel(
      image: 'assets/images/intro/driver_earn_money.png',
      title: 'Complete Job & Earn',
      text1: 'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit laborum.',
      text2: 'Sed ut perspiciatis unde omnis istpoe natus error sit voluptatem accusantium doloremque eopsloi laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et.'
  ),
];