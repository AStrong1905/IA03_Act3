import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Adrian Sanchez: Form C',

      home: MyCustomForm(),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final title = 'Salesians Sarrià 25/26';
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), backgroundColor: Colors.blueAccent),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: <Widget>[
            FormBuilder(
              // Unión entre controles y variable
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //-------------------SECCIÓN 1-------------------
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: FormBuilderChoiceChips(
                        // Nombre interno
                        name: 'choiceChips',
                        decoration: const InputDecoration(
                          // Título
                          labelText: 'Choice Chips',
                          border: OutlineInputBorder(
                            // Redondea las esquinas
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                        // Se distribuyen a lo largo de la fila
                        alignment: WrapAlignment.spaceEvenly,

                        // Color del chip seleccionado
                        selectedColor: Colors.grey,
                        // Color de fondo de cada chip
                        backgroundColor: Colors.blue,
                        // Color de la letra
                        labelStyle: const TextStyle(color: Colors.white),
                        // Mostrar el check en el chip seleccionado
                        showCheckmark: true,
                        options: const [
                          FormBuilderChipOption(
                            value: 'Flutter',
                            avatar: FlutterLogo(size: 20),
                          ),
                          FormBuilderChipOption(value: 'Android'),
                          FormBuilderChipOption(value: 'Chrome OS'),
                        ],
                      ),
                    ),
                    //-------------------SECCIÓN 2-------------------
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: FormBuilderSwitch(
                        // Nombre interno
                        name: 'Switch',
                        title: const Text('This is a switch'),
                        initialValue: false,
                        // Color de activación del switch
                        activeColor: Colors.blueAccent,
                        decoration: const InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: 'Switch',
                          border: OutlineInputBorder(
                            // Redondea las esquinas
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            // Color del borde
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    //-------------------SECCIÓN 3-------------------
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FormBuilderTextField(
                            // Nombre interno
                            name: 'textField',
                            // Longitud máxima
                            maxLength: 15,
                            // Permite escribir más de 15 caracteres
                            maxLengthEnforcement: MaxLengthEnforcement.none,
                            decoration: const InputDecoration(
                              // Título del grupo
                              labelText: 'Text Field',
                              prefixIcon: Icon(Icons.text_fields),
                              border: OutlineInputBorder(),
                            ),
                            // Valida siempre, también cuando está vacío
                            autovalidateMode: AutovalidateMode.always,
                            // Requisito de la validación
                            validator: (value) {
                              if ((value == null || value.isEmpty) || value.length > 15) {
                                return 'Value must have a length less than 15 or more than 1.';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    //-------------------SECCIÓN 4-------------------
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: FormBuilderDropdown(
                        // Nombre interno
                        name: 'DropMenu',
                        decoration: InputDecoration(
                          // Texto de ayuda al usuario
                          hintText: 'Dropdown Fields',
                          border: OutlineInputBorder(
                            // Redondea las esquinas
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        items: const [
                          DropdownMenuItem(value: 'F', child: Text('Finland')),
                          DropdownMenuItem(value: 'S', child: Text('Spain')),
                          DropdownMenuItem(
                            value: 'UK',
                            child: Text('United Kingdom'),
                          ),
                        ],
                      ),
                    ),
                    //-------------------SECCIÓN 5-------------------
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: // Conjunto de botones de opción
                      FormBuilderRadioGroup(
                        name: 'RadioGroup',
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: 'Radio Group Model',
                          border: OutlineInputBorder(
                            // Redondea las esquinas
                            borderRadius: BorderRadius.circular(10.0),
                            // Color del borde
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                        ),
                        // Orientación vertical (cada opción se ordena en una columna)
                        orientation: OptionsOrientation.vertical,
                        options: const [
                          // Las distintas opciones que ofrece el grupo de botones de opción
                          FormBuilderFieldOption(value: 'Option 1'),
                          FormBuilderFieldOption(value: 'Option 2'),
                          FormBuilderFieldOption(value: 'Option 3'),
                          FormBuilderFieldOption(value: 'Option 4'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.upload),
        onPressed: () {
          _formKey.currentState?.save();
          String? formStringValue = _formKey.currentState!.value
              .toString(); // Guarda los valores de todos los campos
          alertDialog(context, formStringValue);
        },
      ),
    );
  }

  void alertDialog(BuildContext context, String formStringValue) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Submission Completed"),
        icon: const Icon(Icons.check_circle),
        content: Text(formStringValue),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Tancar'),
            child: const Text('Tancar'),
          ),
        ],
      ),
    );
  }
}

//Clases y metodos
// ignore: must_be_immutable
class FormLabelGroup extends StatelessWidget {
  FormLabelGroup({super.key, required this.title, this.subtitle});

  String title;
  String? subtitle;

  Widget conditionalSubtitle(BuildContext context) {
    if (subtitle != null) {
      return Text(
        subtitle!,
        style: Theme.of(context).textTheme.labelLarge?.apply(
          fontSizeFactor: 1.25,
          // ignore: deprecated_member_use
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20.0, 0, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.labelLarge?.apply(fontSizeFactor: 1.25),
          ),
          conditionalSubtitle(context),
        ],
      ),
    );
  }
}
