import 'dart:core';

// This file contains utility validators for various formats such as email, date, CPF, and CNPJ.

class Validators {
  static bool isValidEmail(String email) {
    final regex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    return regex.hasMatch(email);
  }

  static bool isValidDate(String input) {
    final regex = RegExp(r"^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[012])/\d{4}$");
    return regex.hasMatch(input);
  }

  static bool isValidCPF(String cpf) {
    cpf = cpf.replaceAll(RegExp(r'[^0-9]'), '');
    if (cpf.length != 11 || RegExp(r'^(\d)\1*$').hasMatch(cpf)) return false;
    int soma1 = 0, soma2 = 0;
    for (int i = 0; i < 9; i++) {
      soma1 += int.parse(cpf[i]) * (10 - i);
      soma2 += int.parse(cpf[i]) * (11 - i);
    }
    int dig1 = (soma1 * 10) % 11;
    if (dig1 == 10) dig1 = 0;
    soma2 += dig1 * 2;
    int dig2 = (soma2 * 10) % 11;
    if (dig2 == 10) dig2 = 0;
    return cpf[9] == dig1.toString() && cpf[10] == dig2.toString();
  }

  static bool isValidCNPJ(String cnpj) {
    cnpj = cnpj.replaceAll(RegExp(r'[^0-9]'), '');
    if (cnpj.length != 14 || RegExp(r'^(\d)\1*$').hasMatch(cnpj)) return false;
    List<int> mult1 = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
    List<int> mult2 = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
    int sum1 = 0;
    for (int i = 0; i < 12; i++) {
      sum1 += int.parse(cnpj[i]) * mult1[i];
    }
    int dig1 = sum1 % 11;
    dig1 = dig1 < 2 ? 0 : 11 - dig1;
    int sum2 = 0;
    for (int i = 0; i < 13; i++) {
      sum2 += int.parse(cnpj[i]) * mult2[i];
    }
    int dig2 = sum2 % 11;
    dig2 = dig2 < 2 ? 0 : 11 - dig2;
    return cnpj[12] == dig1.toString() && cnpj[13] == dig2.toString();
  }
}
