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