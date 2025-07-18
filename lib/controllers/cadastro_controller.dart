import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_masked_text3/flutter_masked_text3.dart';
import './../utils/utils.dart';

class CadastroController extends GetxController {
  // Campos compartilhados
  final nome = TextEditingController();
  final email = TextEditingController();

  // Pessoa Física — usar MaskedTextController para máscaras
  final nascimento = MaskedTextController(mask: '00/00/0000');
  final cpf = MaskedTextController(mask: '000.000.000-00');

  // Pessoa Jurídica
  final nomeFantasia = TextEditingController();
  final cnpj = MaskedTextController(mask: '00.000.000/0000-00');

  // Tipo de pessoa
  final isPessoaFisica = true.obs;

  // Form keys
  final formKeyPf = GlobalKey<FormState>();
  final formKeyPj = GlobalKey<FormState>();

  void toggleTipoPessoa(bool pf) {
    isPessoaFisica.value = pf;
  }

  void submitForm() {
    final formAtual = isPessoaFisica.value ? formKeyPf : formKeyPj;
    if (formAtual.currentState!.validate()) {
      Get.snackbar(
        'Sucesso',
        'Dados enviados com sucesso',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void limparCampos() {
    nome.clear();
    email.clear();
    nascimento.text = '';
    cpf.text = '';
    nomeFantasia.clear();
    cnpj.text = '';
  }

  void disposeAll() {
    nome.dispose();
    email.dispose();
    nascimento.dispose();
    cpf.dispose();
    nomeFantasia.dispose();
    cnpj.dispose();
  }

  // Validadores
  String? validarNome() {
    if (nome.text.trim().isEmpty) {
      return isPessoaFisica.value
          ? 'Nome obrigatório'
          : 'Razão Social obrigatória';
    }
    return null;
  }

  String? validarEmail() {
    if (email.text.trim().isEmpty) return 'Campo obrigatório';
    if (!Validators.isValidEmail(email.text.trim())) return 'Email inválido';
    return null;
  }

  String? validarNascimento() {
    if (nascimento.text.trim().isEmpty) return 'Campo obrigatório';
    if (!Validators.isValidDate(nascimento.text.trim())) return 'Data inválida';
    return null;
  }

  String? validarCpf() {
    if (cpf.text.trim().isEmpty) return 'Campo obrigatório';
    if (!Validators.isValidCPF(cpf.text.trim())) return 'CPF inválido';
    return null;
  }

  String? validarCnpj() {
    if (cnpj.text.trim().isEmpty) return 'Campo obrigatório';
    if (!Validators.isValidCNPJ(cnpj.text.trim())) return 'CNPJ inválido';
    return null;
  }

  String? validarNomeFantasia() {
    if (nomeFantasia.text.trim().isEmpty) return 'Nome Fantasia obrigatório';
    return null;
  }
}
