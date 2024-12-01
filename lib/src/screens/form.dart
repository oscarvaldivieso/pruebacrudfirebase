import 'package:flutter/material.dart';
import 'package:crudfirebaseprueba/src/widgets/multiselect.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CreateVisitorScreen extends StatefulWidget {
  final List<Map<String, dynamic>> transports;
  final List<Map<String, dynamic>> visitors;

  const CreateVisitorScreen({super.key, required this.transports, required this.visitors});

  @override
  _CreateVisitorScreenState createState() => _CreateVisitorScreenState();
}

class _CreateVisitorScreenState extends State<CreateVisitorScreen> {
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _identificacionController = TextEditingController();
  final TextEditingController _motivoController = TextEditingController();
  final TextEditingController _horaEntradaController = TextEditingController();
  final TextEditingController _horaSalidaController = TextEditingController();
  String? _selectedTransporte; // To hold the selected transport
  File? _selectedImage; // To hold the selected image

  Future<void> _selectDateTime(
      BuildContext context, TextEditingController controller, String label) async {
    DateTime currentDate = DateTime.now();

    // Pick date
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      // Pick time
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(currentDate),
      );

      if (pickedTime != null) {
        // Combine Date and Time into a single DateTime
        DateTime finalDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        // Set the value in the controller
        controller.text =
            '${'${finalDateTime.toLocal()}'.split(' ')[0]} ${finalDateTime.hour}:${finalDateTime.minute}';
      }
    }
  }

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Visitante'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un nombre';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _identificacionController,
                decoration: const InputDecoration(labelText: 'Identificación'),
              ),
              TextFormField(
                controller: _motivoController,
                decoration: const InputDecoration(labelText: 'Motivo de la Visita'),
              ),
              GestureDetector(
                onTap: () => _selectDateTime(context, _horaEntradaController, 'Hora de Entrada'),
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _horaEntradaController,
                    decoration: const InputDecoration(labelText: 'Hora de Entrada'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese la hora de entrada';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _selectDateTime(context, _horaSalidaController, 'Hora de Salida'),
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _horaSalidaController,
                    decoration: const InputDecoration(labelText: 'Hora de Salida'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese la hora de salida';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              DropdownButtonFormField<String>(
                value: _selectedTransporte,
                decoration: const InputDecoration(labelText: 'Medio de Transporte'),
                items: widget.transports
                    .map((transport) => DropdownMenuItem<String>(
                          value: transport['descripcion'],
                          child: Text(transport['descripcion'] ?? 'Sin descripción'),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedTransporte = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor seleccione un medio de transporte';
                  }
                  return null;
                },
              ),
              MultiSelectDropdown(visitors: widget.visitors),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Foto/Placa',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 8.0), // Add spacing between the label and the container
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: _selectedImage != null
                          ? Image.file(_selectedImage!, fit: BoxFit.cover)
                          : const Center(
                              child: Text(
                                'Tocar para seleccionar una imagen',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Visitante creado')),
                    );
                  }
                },
                child: const Text('Crear Visitante'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}