import 'package:flutter/material.dart';
import 'package:omgnp/Patti/NewPatti.dart';
import 'package:omgnp/Widgets/Picker/DatePicker.dart';

class NewPattiForm extends StatefulWidget {
  const NewPattiForm({super.key});

  static const pageRoute = '/new-patti';
  @override
  State<NewPattiForm> createState() => _NewPattiFormState();
}

class _NewPattiFormState extends State<NewPattiForm> {
  final formKey = GlobalKey<FormState>();
  List<num> rst = [];
  String vehiclePlateNumber = "";
  String customer = "";
  final material = "Raw Cotton (Kapas)";
  String address = "";
  List<Map<String, dynamic>> particulars = [];
  int kata = 50;
  DateTime date = DateTime.now();
  String broker = "";
  int brokerage = 0;

  void setDateTime(DateTime dateTime) {
    date = dateTime;
  }

  void saveForm() {
    if (formKey.currentState!.validate()) {
      particulars.clear();
      formKey.currentState!.save();
      final newPatti = {
        "rst": rst,
        "vehicle": vehiclePlateNumber,
        "customer": customer,
        "broker": broker,
        "brokerage": brokerage,
        "material": material,
        "address": address,
        "particulars": particulars,
        "kata": kata,
        "date": date
      };

      Navigator.of(context).pushNamed(NewPatti.pageRoute, arguments: newPatti);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.blue,
            )),
        backgroundColor: Colors.white,
        title: const Text("New record"),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "RST Number",
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Please enter RST No.";
                    }
                    final tempValue = value.split(',');
                    if (int.tryParse(tempValue.first) == null) {
                      return "Invalid RST No.";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      final tempValue = value.split(',');
                      tempValue.remove('');
                      setState(() {
                        rst =
                            tempValue.map((v) => int.parse(v.trim())).toList();
                      });
                    }
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Vehicle Number",
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Please enter vehicle no.";
                    }
                    return null;
                  },
                  onSaved: (newValue) => vehiclePlateNumber = newValue!.trim(),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Customer",
                  ),
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Please enter customer name";
                    }
                    return null;
                  },
                  onSaved: (newValue) => customer = newValue!,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Broker",
                  ),
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  onChanged: (value) => broker = value.trim(),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Brokerage",
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (broker.isNotEmpty) {
                      if (value!.trim().isEmpty) {
                        return "Please enter rate";
                      }
                      if (int.tryParse(value.trim()) == null ||
                          int.parse(value) <= 0) {
                        return "Invalid rate";
                      }
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    if(broker.isNotEmpty) {
                    brokerage = int.parse(newValue!.trim());
                    }
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Address",
                  ),
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  onSaved: (newValue) =>
                      newValue!.isEmpty ? address = "" : address = newValue.trim(),
                ),
                TextFormField(
                    enabled: false, initialValue: "Material : $material"),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Kata",
                  ),
                  initialValue: "50",
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter Kata rate";
                    }
                    if (int.tryParse(value) == null) {
                      return "Please a valid amount";
                    }
                    if (int.parse(value) < 0) {
                      return "Kata rate cannot be negative";
                    }

                    return null;
                  },
                  onSaved: (newValue) => newValue!.isEmpty
                      ? ""
                      : kata = int.parse(newValue.trim()),
                ),
                ...rst
                    .map((selectedRst) => Column(
                          children: [
                            TextFormField(
                                decoration: InputDecoration(
                                  labelText: "RST #$selectedRst Weight",
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value!.trim().isEmpty) {
                                    return "Please enter weight";
                                  }
                                  if (double.tryParse(value) == null) {
                                    return "Invalid weight";
                                  }
                                  if (double.tryParse(value) != null &&
                                      double.parse(value) < 0) {
                                    return "Invalid weight";
                                  }
                                  return null;
                                },
                                onSaved: (newValue) => particulars.add({
                                      "rst": selectedRst,
                                      "weight": double.parse(newValue!),
                                    })),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: "RST #$selectedRst Rate",
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return "Please enter rate";
                                }
                                if (double.parse(value) <= 0) {
                                  return "Invalid rate";
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                particulars
                                    .firstWhere((particular) =>
                                        particular['rst'] == selectedRst)
                                    .putIfAbsent(
                                        "rate", () => double.parse(newValue!));
                              },
                            ),
                          ],
                        ))
                    .toList(),
                const SizedBox(
                  height: 15,
                ),
                DatePicker(size, setDateTime),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: const Text("Cancel"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: saveForm,
                      child: const Text("Generate"),
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
}
