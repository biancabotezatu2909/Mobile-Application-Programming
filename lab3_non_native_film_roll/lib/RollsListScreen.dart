
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lab3_non_native_film_roll/UpdateRollScreen.dart';
import 'AddRollScreen.dart';
import 'Roll.dart';

class ListScreen extends StatefulWidget{
  const ListScreen({super.key});

  @override
  State<StatefulWidget> createState() => ListScreenState();
}

class ListScreenState extends State<ListScreen>{
  final List<Roll> rolls = Roll.init();

  void updateRoll(Roll newRoll){
    for (int i = 0; i < rolls.length; i++){
      if(rolls[i].id == newRoll.id){
        rolls[i] = newRoll;
        break;
      }
    }
  }
  void removeRollFromList(int id) {
    setState(() {
      rolls.removeWhere((element) => element.id == id);
    });
  }


  _showDialog(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: Colors.white,
        title: const Center(
          child: Text(
            "Delete Item",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Are you sure you want to delete this item?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          OutlinedButton(
            onPressed: () {
              removeRollFromList(id);
              Navigator.of(context).pop();
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.black, width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text(
              "Delete",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white30,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFAB886D),
        centerTitle: true,
        title: const Text(
          "Film Rolls",
          style: TextStyle(
            color: Colors.black,
          ),

        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 80.0), // Adds space for the FAB
        child: ListView.builder(
          itemCount: rolls.length,
          itemBuilder: (context, index) {
            return templateRoll(rolls[index]);
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Roll roll = await Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddRollScreen()));
            setState(() {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Added!"),
              ));
              rolls.add(roll);
            });

          },
          backgroundColor: Color(0xFFB4B4B8),
          child: Icon(Icons.add),
      foregroundColor: Colors.black),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );
  }

  Widget templateRoll(Roll roll) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children:[
            Container(
              width: 80,
              height:80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: const DecorationImage(
                    image: AssetImage("assets/film_roll.png"),
                    fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width:16),

          //Text
          Expanded(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              // Roll Name
            Text(
              roll.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // Roll Type and ISO
            Text(
              "Type: ${roll.type} | ISO: ${roll.iso}",
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 4),

            // Roll Brand
            Text(
              "Brand: ${roll.brand}",
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),

            // Roll Capacity and Status
            Text(
              "Capacity: ${roll.capacity} | Status: ${roll.status}",
              style: const TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 8),

            // Date Created
            Text(
              "Date Created: ${DateFormat('yyyy-MM-dd').format(roll.dateCreated)}",
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
            Column(
              children:<Widget>[
                IconButton(
                  icon: const Icon(Icons.edit_sharp),
                  onPressed: () async {
                    Roll updatedRoll = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateRollScreen(roll: roll),
                      ),
                    );
                    setState(() {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Updated!'),
                      ));
                      updateRoll(updatedRoll);
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete_rounded),
                  color: Color(0xFF582233),
                  onPressed: () => {_showDialog(context, roll.id)},
                )
              ]
            )

          ],

    ),

      ),
    );
  }


}