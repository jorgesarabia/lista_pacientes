import 'package:flutter_test/flutter_test.dart';
import 'package:lista_pacientes/User/repository/auth_repository.dart';
import 'package:lista_pacientes/common/authentication_bloc/bloc.dart';
import 'package:mockito/mockito.dart';

class MockUserRepository extends Mock implements AuthRepository {}

void main() {
  AuthenticationBloc authenticationBloc;
  MockUserRepository authRepository;

  setUp(() {
    authenticationBloc = AuthenticationBloc(userRepository: AuthRepository());
    authRepository = MockUserRepository();
  });

  tearDown(() {
    authenticationBloc?.close();
  });

  group("AuthenticationBloc", () {
    test("States", () {
      expect(Uninitialized(), isA<AuthenticationState>());
      expect(Unauthenticated(), isA<AuthenticationState>());
      AuthenticationState state = Authenticated("Some name");
      expect(state.props, equals(["Some name"]));
      expect(
        state.toString(),
        equals("Authenticated { displayName: Some name }"),
      );
      state = Uninitialized();
      expect(state.props, equals([]));
    });

    test("Events", () {
      AuthenticationEvent event = AppStarted();
      expect(event.props, equals([]));
    });

    test("AuthReppository == null", () {
      expect(
        () => AuthenticationBloc(userRepository: null),
        throwsAssertionError,
      );
    });

    test('initial state is correct', () {
      expect(authenticationBloc.initialState, Uninitialized());
    });

    test('close does not emit new states', () {
      expectLater(
        authenticationBloc,
        emitsInOrder([Uninitialized(), emitsDone]),
      );
      authenticationBloc.close();
    });

    test('emits [uninitialized, unauthenticated] for null user', () {
      final expectedResponse = [Uninitialized(), Unauthenticated()];

      when(authRepository.getUser()).thenAnswer((_) => Future.value(null));

      expectLater(
        authenticationBloc,
        emitsInOrder(expectedResponse),
      );

      authenticationBloc.add(AppStarted());
    });

test(
        'emits [uninitialized, loading, authenticated] when token is persisted',
        () {
      final expectedResponse = [
        Uninitialized(),
        Authenticated("email@email.com"),
      ];

      when(authRepository.getUser()).thenAnswer((_) => Future.value(null));

      expectLater(
        authenticationBloc,
        emitsInOrder(expectedResponse),
      );

    });

  });
}
