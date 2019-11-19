import 'package:flutter_test/flutter_test.dart';
import 'package:lista_pacientes/common/validators.dart';

void main() {

  group("Email validator", () {
    
    test("email should be valid", () {
      expect(Validators.isValidEmail("algo@algo.com"), equals(true));
      expect(Validators.isValidEmail("algo@algo.com.ar"), equals(true));
      expect(Validators.isValidEmail("algo.mas@algo.com.ar"), equals(true));
      expect(Validators.isValidEmail("algo.mas@algo.xyz"), equals(true));
      expect(Validators.isValidEmail("algo.mas@algo.xyz.algo.org.us"), equals(true));
      expect(Validators.isValidEmail("algo.mo+as@algo.xyz.algo.org.us"), equals(true));
    });

    test("email should be invalid", () {
      expect(Validators.isValidEmail("algo@algo"), equals(false));
      expect(Validators.isValidEmail("algoalgo.com"), equals(false));
      expect(Validators.isValidEmail("algo@algo.c"), equals(false));
      expect(Validators.isValidEmail("algo@algo.com.c"), equals(false));
    });

  });

  group("Password validator", () {
    
    test("password should be valid", () {
      expect(Validators.isValidPassword("un_Pasww@mcas%3"), equals(true));
    });

    test("password should be invalid", () {
      expect(Validators.isValidPassword("un"), equals(false));
      expect(Validators.isValidPassword("un_"), equals(false));
      expect(Validators.isValidPassword("u@#dD"), equals(false));
      expect(Validators.isValidPassword("uncasc"), equals(false));
    });

  });
}
