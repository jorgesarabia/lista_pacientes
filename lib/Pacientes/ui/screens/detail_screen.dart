import 'package:flutter/material.dart';
import 'package:lista_pacientes/Pacientes/model/pacientes_model.dart';
import 'package:lista_pacientes/Pacientes/ui/widgets/item_detail.dart';
import 'package:lista_pacientes/widgets/colored_button.dart';

class DetailScreen extends StatelessWidget {
  final PacientesModel pacientesModel;

  DetailScreen({
    Key key,
    @required this.pacientesModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${pacientesModel.nombre}")),
      body: detallePaciente(),
    );
  }

  Widget detallePaciente() {
    return Column(
      children: <Widget>[
        SizedBox(height: 25.0),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ItemDetail(
            icon: Icons.person,
            detail: pacientesModel.nombre,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ItemDetail(
            icon: Icons.credit_card,
            detail: pacientesModel.ci,
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: ItemDetail(
              icon: Icons.library_books,
              detail: pacientesModel.nroLibreta,
            )),
        SizedBox(height: 35.0),
        ColoredButton(
          title: "Editar",
          onPressed: _goToEditPage,
          height: 50.0,
          width: 200.0,
        ),
      ],
    );
  }

  void _goToEditPage(){
    print("Editar!");
  }
}
