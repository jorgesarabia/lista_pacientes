import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lista_pacientes/Pacientes/find_bloc/bloc.dart';
import 'package:lista_pacientes/Pacientes/ui/screens/new_screen.dart';
import 'package:lista_pacientes/Pacientes/ui/widgets/paciente_card.dart';

class PacientesLista extends StatefulWidget {
  @override
  _PacientesListaState createState() => _PacientesListaState();
}

class _PacientesListaState extends State<PacientesLista> {
  List<Widget> listaPacientes = [];
  Icon _searchIcon = new Icon(Icons.search);
  final TextEditingController _searchController = TextEditingController();
  FindBloc _findBloc;

  @override
  void initState() {
    super.initState();
    _findBloc = BlocProvider.of<FindBloc>(context);
    _searchController.addListener(_onQueryChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FindBloc, FindState>(
      condition: (lastStase, state) {
        return lastStase != state;
      },
      listener: (context, state) {
        listaPacientes = state.list;
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
        children: otraLista(),
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

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
      } else {
        this._searchIcon = new Icon(Icons.search);
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onQueryChanged() {
    print("Se llama");
    _findBloc.add(
      QueryChanged(query: _searchController.text),
    );
_searchPressed();
  }

  List<Widget> otraLista() {
    List<Widget> lista = [
      TextField(
        controller: _searchController,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: 'Buscar ...',
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: Colors.blue),
          ),
          filled: true,
          contentPadding:
              EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
        ),
      ),
    ];

    return List.from(lista)..addAll(listaPacientes);
  }
}
