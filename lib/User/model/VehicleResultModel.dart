

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
    VehicleResultModel(vehicleName: 'MUSTANG SHELBY GT',vehicleLocation: 'Sat raster mor',amount: 3500, minCap: '2' ,maxCap: '3',vehicleImage: 'https://cdn.pixabay.com/photo/2012/04/12/23/48/car-30990__340.png'),
    VehicleResultModel(vehicleName: 'BMW I8',vehicleLocation: 'Shivbari mor',amount: 2900, minCap: '2' ,maxCap: '3',vehicleImage: 'https://cdn.pixabay.com/photo/2012/04/12/23/48/car-30990__340.png'),
    VehicleResultModel(vehicleName: 'JAGUAR SILBER',vehicleLocation: 'Moilapota Mor',amount: 2000, minCap: '2' ,maxCap: '3',vehicleImage: 'https://cdn.pixabay.com/photo/2012/04/12/23/48/car-30990__340.png'),
    VehicleResultModel(vehicleName: 'MASERATI LEVANTE',vehicleLocation: 'Moilapota Mor',amount: 2000, minCap: '2' ,maxCap: '3',vehicleImage: 'https://cdn.pixabay.com/photo/2012/04/12/23/48/car-30990__340.png'),
    VehicleResultModel(vehicleName: 'MERCEDES AMG S',vehicleLocation: 'Moilapota Mor',amount: 2650, minCap: '2' ,maxCap: '3',vehicleImage: 'https://cdn.pixabay.com/photo/2012/04/12/23/48/car-30990__340.png'),
  ];

}
