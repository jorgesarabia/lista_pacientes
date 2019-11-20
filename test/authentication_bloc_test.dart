import 'package:flutter_test/flutter_test.dart';
import 'package:lista_pacientes/User/repository/auth_repository.dart';
import 'package:lista_pacientes/common/authentication_bloc/bloc.dart';

void main() {
  AuthenticationBloc authenticationBloc;

  setUp((){
    authenticationBloc = AuthenticationBloc(userRepository: AuthRepository());
  });

  group("AuthenticationBloc", () {
    test("States", () {
      expect(Uninitialized(), isA<AuthenticationState>());
      expect(Unauthenticated(), isA<AuthenticationState>());
      AuthenticationState state = Authenticated("Some name");
      expect(state.props, equals(["Some name"]));
      expect(state.toString(), equals("Authenticated { displayName: Some name }"));
      state = Uninitialized();
      expect(state.props, equals([]));
    });

    test("Events", () {
      AuthenticationEvent event = AppStarted();
      expect(event.props, equals([]));
    });

    test("Bloc",(){
    });




  });
}
