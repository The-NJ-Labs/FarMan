import 'package:flutter/material.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:FarMan/models/cow_model.dart';
import 'package:FarMan/api/Database_helper.dart';

@NowaGenerated()
class AddCowPage extends StatefulWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const AddCowPage({super.key});

  @override
  _AddCowPageState createState() {
    return _AddCowPageState();
  }
}

@NowaGenerated()
class _AddCowPageState extends State<AddCowPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _cowDoBController = TextEditingController();

  bool _isAlive = true;

  bool _isFemale = true;

  DateTime? _dob;

  TextEditingController cowNameController = TextEditingController();

  TextEditingController cowIdController = TextEditingController();

  TextEditingController breedController = TextEditingController();

  String? _validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName} is required';
    }
    return null;
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        final cow = Cow(
          id: cowIdController.text.trim(),
          isAlive: _isAlive,
          name: cowNameController.text.trim(),
          breed: breedController.text.trim(),
          isFemale: _isFemale,
        );
        final dbHelper = InventoryDatabaseHelper();
        await dbHelper.insertCow(cow);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Cow added successfully! ID: ${cow.id}',
          ),
          backgroundColor: Colors.green,
        ));
        Navigator.pop(context, true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Error adding cow: ${e}',
          ),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: 9999.0,
          child: Text(
            'Add Cow',
            style: TextStyle(
              shadows: [],
              fontFamily: 'AR One Sans',
              fontWeight: FontWeight.w800,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
        titleSpacing: 1.6,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(0.0),
                child: Card(
                  elevation: 2.0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          'Cow Information',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.blue,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Cow Name *',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
                              Icons.pets_rounded,
                            ),
                          ),
                          validator: (value) =>
                              _validateRequired(value, 'Cow Name'),
                          textCapitalization: TextCapitalization.words,
                          controller: cowNameController,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Card(
                          color: Colors.grey[50],
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.date_range_rounded,
                                      color: Colors.orange,
                                    ),
                                    const SizedBox(
                                      width: 8.0,
                                    ),
                                    Text(
                                      _dob == null
                                          ? 'Date of Birth'
                                          : 'DOB: ${_dob!.toIso8601String().split('T')[0]}',
                                      style: const TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                                TextButton(
                                  onPressed: () async {
                                    final pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: _dob ?? DateTime.now(),
                                      firstDate: DateTime(1980),
                                      lastDate: DateTime.now(),
                                    );
                                    if (pickedDate != null) {
                                      setState(() {
                                        _dob = pickedDate;
                                      });
                                    }
                                  },
                                  child: const Text(
                                    'Select',
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Cow ID *',
                            hintText: 'MAF-X-XX-XX-XXX',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
                              Icons.tag,
                            ),
                          ),
                          validator: (value) =>
                              _validateRequired(value, 'Cow ID'),
                          controller: cowIdController,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(0.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Breed *',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                Icons.category,
                              ),
                            ),
                            validator: (value) =>
                                _validateRequired(value, 'Breed'),
                            textCapitalization: TextCapitalization.words,
                            controller: breedController,
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(25.0),
                          child: Card(
                            color: Colors.grey[50],
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.health_and_safety,
                                        color: Colors.green,
                                      ),
                                      const SizedBox(
                                        width: 8.0,
                                      ),
                                      Text(
                                        'Status: ${_isAlive ? 'Alive' : 'Deceased'}',
                                        style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                  Switch(
                                    value: _isAlive,
                                    onChanged: (value) {
                                      setState(() {
                                        _isAlive = value;
                                      });
                                    },
                                    activeThumbColor: Colors.green,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        ClipRRect(
                          clipBehavior: Clip.antiAlias,
                          borderRadius: BorderRadius.circular(25.0),
                          child: Card(
                            color: Colors.grey[50],
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          if (_isFemale)
                                            const Icon(
                                              Icons.female,
                                              color: Color.fromARGB(
                                                255,
                                                187,
                                                102,
                                                215,
                                              ),
                                            )
                                          else
                                            const Icon(
                                              Icons.male,
                                              color: Color.fromARGB(
                                                255,
                                                40,
                                                173,
                                                255,
                                              ),
                                            )
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 8.0,
                                      ),
                                      Text(
                                        'Gender: ${_isFemale ? 'Female' : 'Male'}',
                                        style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                  Switch(
                                    value: _isFemale,
                                    onChanged: (value) {
                                      setState(() {
                                        _isFemale = value;
                                      });
                                    },
                                    activeThumbColor: const Color.fromARGB(
                                      255,
                                      187,
                                      102,
                                      215,
                                    ),
                                    inactiveThumbColor: const Color.fromARGB(
                                      255,
                                      40,
                                      173,
                                      255,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              FlexSizedBox(
                width: 361.0,
                height: 36.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: ElevatedButton.icon(
                    onPressed: _submitForm,
                    icon: Icon(
                      Icons.save,
                    ),
                    label: Text(
                      'Add Cow',
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      animationDuration: const Duration(milliseconds: 200),
                    ),
                    onHover: (value) {},
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    cowNameController.dispose();
    breedController.dispose();
    cowIdController.dispose();
    _cowDoBController.dispose();
    super.dispose();
  }
}
