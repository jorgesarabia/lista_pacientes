import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lista_pacientes/Pacientes/find_bloc/bloc.dart';
import 'package:lista_pacientes/Pacientes/model/pacientes_model.dart';
import 'package:lista_pacientes/Pacientes/ui/screens/detail_screen.dart';
import 'package:lista_pacientes/Pacientes/ui/screens/form_screen.dart';
import 'package:lista_pacientes/Pacientes/ui/widgets/paciente_card.dart';
import 'package:lista_pacientes/Pacientes/ui/widgets/search_button.dart';

class PacientesLista extends StatefulWidget {
  @override
  _PacientesListaState createState() => _PacientesListaState();
}

class _PacientesListaState extends State<PacientesLista> {
  List<PacientesModel> listaPacientes = [];
  List<Widget> listaFiltrada = [];
  Widget _searchIcon = Icon(Icons.search);
  final TextEditingController _searchController = TextEditingController();
  FindBloc _findBloc;

  @override
  void initState() {
    super.initState();
    _filtrar();
    _findBloc = BlocProvider.of<FindBloc>(context);
    _searchController.addListener(_filtrar);
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
                builder: (BuildContext context) => FormScreen(null)),
          ).then((_) {
            setState(() {
              _findFromSource();
            });
          });
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

  void _findFromSource() {
    _findBloc.add(QueryChanged());
  }

  void _filtrar() {
    listaFiltrada = [];
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
          GestureDetector(
            child: PacienteCard(pacientesModel: item),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => DetailScreen(
                          pacientesModel: item,
                        )),
              );
            },
          ),
        );
      }
    });
    setState(() {
      if (_searchController.text.length > 0) {
        _searchIcon = GestureDetector(
          child: Icon(Icons.close),
          onTap: () {
            _searchController.text = "";
            _filtrar();
          },
        );
      } else {
        _searchIcon = Icon(Icons.search);
      }
      List<Widget> searchBar = [
        SearchButton(
          searchController: _searchController,
          searchIcon: _searchIcon,
          title: "Buscar ...",
        ),
      ];

      listaFiltrada = List.from(searchBar)..addAll(listaFiltrada);
    });
  }
}
