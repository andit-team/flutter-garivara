

 class VehicleResultModel{
  String vehicleName;
  String vehicleLocation;
  double amount;
  String minCap;
  String maxCap;
  String vehicleImage;
  VehicleResultModel({this.vehicleName,this.vehicleImage,this.vehicleLocation,this.amount,this.minCap,this.maxCap});


  static List<VehicleResultModel> vehicleResultModelData = [
    VehicleResultModel(vehicleName: 'BMW CABRIO',vehicleLocation: 'Moilapota Mor',amount: 2000, minCap: '1' ,maxCap: '2',vehicleImage: 'https://cdn.pixabay.com/photo/2012/04/12/23/48/car-30990__340.png'),
    VehicleResultModel(vehicleName: 'MUSTANG SHELBY GT',vehicleLocation: 'Sat raster mor',amount: 3500, minCap: '2' ,maxCap: '3',vehicleImage: 'https://www.carscoops.com/wp-content/uploads/2019/09/a699be05-ford-mustang-shelby-gt500-2.png'),
    VehicleResultModel(vehicleName: 'BMW I8',vehicleLocation: 'Shivbari mor',amount: 2900, minCap: '2' ,maxCap: '3',vehicleImage: 'https://www.bmwusa.com/content/dam/bmwusa/BMWi/i8/2020/BMW-MY20-i8-Experience-i8-AllBreakpoints.png.bmwimg.small.png'),
    VehicleResultModel(vehicleName: 'JAGUAR SILVER',vehicleLocation: 'Moilapota Mor',amount: 2000, minCap: '2' ,maxCap: '3',vehicleImage: 'https://www.pngpix.com/wp-content/uploads/2016/06/PNGPIX-COM-Jaguar-XKR-Silver-Car-PNG-Image.png'),
    VehicleResultModel(vehicleName: 'MASERATI LEVANTE',vehicleLocation: 'Moilapota Mor',amount: 2000, minCap: '2' ,maxCap: '3',vehicleImage: 'https://images.carandbike.com/car-images/colors/maserati/levante/maserati-levante-rosso-rbino.png?v='),
    VehicleResultModel(vehicleName: 'MERCEDES AMG S',vehicleLocation: 'Moilapota Mor',amount: 2650, minCap: '2' ,maxCap: '3',vehicleImage: 'https://c4d709dd302a2586107d-f8305d22c3db1fdd6f8607b49e47a10c.ssl.cf1.rackcdn.com/thumbnails/stock-images/9fa7f5b82bf36b9e556b25233cdc323c.png'),
  ];

}
