import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lista_pacientes/Pacientes/find_bloc/bloc.dart';
import 'package:lista_pacientes/Pacientes/model/pacientes_model.dart';
import 'package:lista_pacientes/Pacientes/ui/screens/new_screen.dart';
import 'package:lista_pacientes/Pacientes/ui/widgets/paciente_card.dart';

class PacientesLista extends StatefulWidget {
  @override
  _PacientesListaState createState() => _PacientesListaState();
}

class _PacientesListaState extends State<PacientesLista> {
  List<PacientesModel> listaPacientes = [];
  List<Widget> listaFiltrada = [];
  Icon _searchIcon = Icon(Icons.search);
  final TextEditingController _searchController = TextEditingController();
  FindBloc _findBloc;

  @override
  void initState() {
    super.initState();
    _filtrar();
    _findBloc = BlocProvider.of<FindBloc>(context);
    _searchController.addListener(_onQueryChanged);
    _findFromSource();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FindBloc, FindState>(
      condition: (lastStase, state) {
        return lastStase != state;
      },
      listener: (context, state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Error al cargar la lista de pacientes'),
                    Icon(Icons.error)
                  ],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Buscando Pacientes ..."),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        listaPacientes = state.list;
        _filtrar();
      },
      child: BlocBuilder<FindBloc, FindState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(20.0),
            child: listaDePacientes(),
          );
        },
      ),
    );
  }

  Widget listaDePacientes() {
    return Scaffold(
      body: ListView(
        children: listaFiltrada,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Se debe cargar un nuevo Paciente");
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => NewPacienteScreen()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onQueryChanged() {
    _filtrar();
  }

  void _findFromSource() {
    _findBloc.add(QueryChanged());
  }

  void _filtrar() {
    listaFiltrada = [];

    if (_searchController.text.length > 0) {
      String nombre;
      String ci;
      String query = _searchController.text;
      listaPacientes.forEach((PacientesModel item) {
        nombre = item.nombre;
        ci = item.ci;
        bool a = nombre.toLowerCase().contains(query.toLowerCase());
        bool b = ci.toLowerCase().contains(query.toLowerCase());
        if (a || b) {
          listaFiltrada.add(
            PacienteCard(pacientesModel: item),
          );
        }
      });
    } else {
      listaPacientes.forEach((PacientesModel item) {
        listaFiltrada.add(
          PacienteCard(pacientesModel: item),
        );
      });
    }
    setState(() {
      if (_searchController.text.length > 0) {
        _searchIcon = Icon(Icons.close);
      } else {
        _searchIcon = Icon(Icons.search);
      }
      List<Widget> searchBar = [
        TextField(
          controller: _searchController,
          decoration: InputDecoration(
            prefixIcon: _searchIcon,
            hintText: 'Buscar ...',
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(color: Colors.blue),
            ),
            filled: true,
          ),
        ),
      ];

      listaFiltrada = List.from(searchBar)..addAll(listaFiltrada);
    });
  }
}
