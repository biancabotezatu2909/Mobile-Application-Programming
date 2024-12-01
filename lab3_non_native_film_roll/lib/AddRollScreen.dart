import 'package:flutter/material.dart';
import 'Roll.dart'; // Assume this is your custom Roll class.
import 'package:intl/intl.dart';

class AddRollScreen extends StatefulWidget {
  AddRollScreen({super.key});

  @override
  State<StatefulWidget> createState() => AddRollScreenState();
}

class AddRollScreenState extends State<AddRollScreen> {
  final _formKey = GlobalKey<FormState>();

  String rollName = "";
  String rollType = "";
  String rollBrand = "";
  String rollCapacity = "";
  String rollIso = "";
  String rollStatus = "Developed";
  DateTime rollDate = DateTime.now();

  final List<String> statusOptions = [
    "Developed",
    "Scanned",
    "In progress",
    "Awaiting development"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFAB886D),
        title: const Text("Add Roll"),
      ),
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildFormField(
                  label: "Roll Name",
                  hint: "Enter roll name",
                  validator: (value) =>
                  value == null || value.isEmpty ? "Enter roll name" : null,
                  onChanged: (value) => rollName = value,
                ),
                const SizedBox(height: 16),
                buildFormField(
                  label: "Roll Type",
                  hint: "Enter roll type (e.g.: color, B&W)",
                  validator: (value) =>
                  value == null || value.isEmpty ? "Enter roll type" : null,
                  onChanged: (value) => rollType = value,
                ),
                const SizedBox(height: 16),
                buildFormField(
                  label: "Brand",
                  hint: "Enter brand",
                  validator: (value) =>
                  value == null || value.isEmpty ? "Enter brand" : null,
                  onChanged: (value) => rollBrand = value,
                ),
                const SizedBox(height: 16),
                buildFormField(
                  label: "ISO",
                  hint: "Enter ISO value ",
                  validator: (value) => value == null || value.isEmpty
                      ? "Enter ISO value"
                      : null,
                  onChanged: (value) => rollIso = value,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                buildFormField(
                  label: "Capacity",
                  hint: "Enter roll capacity",
                  validator: (value) => value == null || value.isEmpty
                      ? "Enter roll capacity"
                      : null,
                  onChanged: (value) => rollCapacity = value,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: rollStatus,
                  decoration: InputDecoration(
                    labelText: "Status",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  items: statusOptions
                      .map((status) => DropdownMenuItem(
                    value: status,
                    child: Text(status),
                  ))
                      .toList(),
                  onChanged: (value) => setState(() {
                    rollStatus = value!;
                  }),
                ),
                const SizedBox(height: 16),
                buildDateField(
                  label: "Date Created",
                  date: rollDate,
                  onSelectDate: (pickedDate) {
                    if (pickedDate != null) {
                      setState(() => rollDate = pickedDate);
                    }
                  },
                ),
                const SizedBox(height: 32),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pop(
                          context,
                          Roll(
                            rollName,
                            rollType,
                            rollBrand,
                            rollCapacity,
                            rollIso,
                            rollStatus,
                            rollDate,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 32),
                    ),
                    child: const Text(
                      "Save Roll",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFormField({
    required String label,
    required String hint,
    required String? Function(String?) validator,
    required Function(String) onChanged,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            labelText: hint,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          validator: validator,
          onChanged: onChanged,
          keyboardType: keyboardType,
        ),
      ],
    );
  }

  Widget buildDateField({
    required String label,
    required DateTime date,
    required void Function(DateTime) onSelectDate,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            final DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: date,
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            );
            if (pickedDate != null) {
              onSelectDate(pickedDate);
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat("yyyy-MM-dd").format(date),
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
                const Icon(Icons.calendar_today, color: Colors.grey),
              ],
            ),
          ),
        ),
      ],
    );
  }

}
