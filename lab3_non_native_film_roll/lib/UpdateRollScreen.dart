import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Roll.dart';

class UpdateRollScreen extends StatefulWidget {
  const UpdateRollScreen({super.key, required this.roll});

  final Roll roll;

  @override
  State<StatefulWidget> createState() => UpdateRollScreenState();
}

class UpdateRollScreenState extends State<UpdateRollScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<String> statusOptions = [
    "Developed",
    "Scanned",
    "In progress",
    "Awaiting development"
  ];
  late String selectedStatus;
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedStatus = widget.roll.status;
    selectedDate = widget.roll.dateCreated;
  }

  @override
  Widget build(BuildContext context) {
    String name = widget.roll.name;
    String type = widget.roll.type;
    String iso = widget.roll.iso;
    String brand = widget.roll.brand;
    String capacity = widget.roll.capacity;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Roll"),
        backgroundColor: const Color(0xFFAB886D),
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
                  hint: "Enter roll name...",
                  initialValue: name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a roll name.";
                    }
                    return null;
                  },
                  onChanged: (value) => name = value,
                ),
                const SizedBox(height: 16),
                buildFormField(
                  label: "Film Type",
                  hint: "Enter film type...",
                  initialValue: type,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a film type.";
                    }
                    return null;
                  },
                  onChanged: (value) => type = value,
                ),
                const SizedBox(height: 16),
                buildFormField(
                  label: "ISO",
                  hint: "Enter ISO value...",
                  initialValue: iso,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter ISO value.";
                    }
                    return null;
                  },
                  onChanged: (value) => iso = value,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                buildFormField(
                  label: "Brand",
                  hint: "Enter brand...",
                  initialValue: brand,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a brand.";
                    }
                    return null;
                  },
                  onChanged: (value) => brand = value,
                ),
                const SizedBox(height: 16),
                buildFormField(
                  label: "Capacity",
                  hint: "Enter capacity...",
                  initialValue: capacity,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter capacity.";
                    }
                    return null;
                  },
                  onChanged: (value) => capacity = value,
                ),
                const SizedBox(height: 16),
                buildDropdownField(
                  label: "Status",
                  value: selectedStatus,
                  options: statusOptions,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => selectedStatus = value);
                    }
                  },
                ),
                const SizedBox(height: 16),
                buildDateField(
                  label: "Date Created",
                  date: selectedDate,
                  onSelectDate: (pickedDate) {
                    if (pickedDate != null) {
                      setState(() => selectedDate = pickedDate);
                    }
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.pop(
                            context,
                            Roll.fromRoll(
                              widget.roll.id,
                              name,
                              type,
                              iso,
                              brand,
                              capacity,
                              selectedStatus,
                              selectedDate,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                      ),
                      child: const Text("Save Roll", style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF9A7E6F), // New background color
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                      ),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ],
                )
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
    required String initialValue,
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
          initialValue: initialValue,
          decoration: InputDecoration(
            hintText: hint,
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

  Widget buildDropdownField({
    required String label,
    required String value,
    required List<String> options,
    required void Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          items: options
              .map((option) => DropdownMenuItem<String>(
            value: option,
            child: Text(option),
          ))
              .toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildDateField({
    required String label,
    required DateTime date,
    required void Function(DateTime?) onSelectDate,
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
            onSelectDate(pickedDate);
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
