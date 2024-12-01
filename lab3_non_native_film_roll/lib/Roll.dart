import 'package:intl/intl.dart';

class Roll{
  static int currentId = 0;
  late int id;
  String name;
  String type;
  String iso;
  String brand;
  String capacity;
  String status;
  DateTime dateCreated;

  Roll(this.name, this.type, this.iso, this.brand, this.capacity, this.status, this.dateCreated){
    id = currentId++;
  }

  Roll.fromRoll(this.id, this.name, this.type, this.iso, this.brand, this.capacity, this.status, this.dateCreated);

  static List<Roll> init(){
    List<Roll> rolls = [
      Roll("Roll 1", "Color", "200", "Kodak", "36", "Developed", DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(2020, 04, 17)))),
      Roll("Roll 2", "B&W", "400", "Ilford", "72", "Scanned", DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(2022, 08, 27)))),
      Roll("Roll 3", "Color", "100", "Aeroplane", "24", "In progress", DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(2024, 11, 10))))
    ];

    return rolls;
  }


}