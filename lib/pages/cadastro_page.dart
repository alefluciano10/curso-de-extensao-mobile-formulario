import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/widgets.dart';
import '../controllers/controllers.dart';

class CadastroPage extends StatelessWidget {
  CadastroPage({super.key});

  final CadastroController controller = Get.put(CadastroController());

  Widget _buildTipoPessoaRadio() {
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ChoiceChip(
            label: const Text('Pessoa Física'),
            selected: controller.isPessoaFisica.value,
            selectedColor: Colors.indigo.shade600,
            backgroundColor: Colors.indigo.shade100,
            labelStyle: TextStyle(
              color:
                  controller.isPessoaFisica.value
                      ? Colors.white
                      : Colors.indigo.shade800,
              fontWeight: FontWeight.w600,
            ),
            onSelected: (selected) {
              if (selected) controller.toggleTipoPessoa(true);
            },
          ),
          const SizedBox(width: 16),
          ChoiceChip(
            label: const Text('Pessoa Jurídica'),
            selected: !controller.isPessoaFisica.value,
            selectedColor: Colors.indigo.shade600,
            backgroundColor: Colors.indigo.shade100,
            labelStyle: TextStyle(
              color:
                  !controller.isPessoaFisica.value
                      ? Colors.white
                      : Colors.indigo.shade800,
              fontWeight: FontWeight.w600,
            ),
            onSelected: (selected) {
              if (selected) controller.toggleTipoPessoa(false);
            },
          ),
        ],
      );
    });
  }

  Widget _buildPessoaFisicaForm() {
    return Form(
      key: controller.formKeyPf,
      child: Column(
        children: [
          CustomTextFormField(
            controller: controller.nome,
            hintText: 'Nome Completo',
            icon: FontAwesomeIcons.user,
            keyboardType: TextInputType.name,
            validator: (_) => controller.validarNome(),
          ),
          const SizedBox(height: 18),

          CustomTextFormField(
            controller: controller.email,
            hintText: 'E-mail',
            icon: FontAwesomeIcons.envelope,
            keyboardType: TextInputType.emailAddress,
            validator: (_) => controller.validarEmail(),
          ),
          const SizedBox(height: 18),

          CustomTextFormField(
            controller: controller.nascimento,
            hintText: 'Data de nascimento',
            icon: FontAwesomeIcons.calendar,
            keyboardType: TextInputType.datetime,
            validator: (_) => controller.validarNascimento(),
          ),
          const SizedBox(height: 18),

          CustomTextFormField(
            controller: controller.cpf,
            hintText: 'CPF',
            icon: FontAwesomeIcons.idCard,
            keyboardType: TextInputType.number,
            validator: (_) => controller.validarCpf(),
          ),
        ],
      ),
    );
  }

  Widget _buildPessoaJuridicaForm() {
    return Form(
      key: controller.formKeyPj,
      child: Column(
        children: [
          CustomTextFormField(
            controller: controller.nome,
            hintText: 'Razão Social',
            icon: FontAwesomeIcons.user,
            keyboardType: TextInputType.name,
            validator: (_) => controller.validarNome(),
          ),
          const SizedBox(height: 18),

          CustomTextFormField(
            controller: controller.nomeFantasia,
            hintText: 'Nome Fantasia',
            icon: FontAwesomeIcons.store,
            keyboardType: TextInputType.name,
            validator: (_) => controller.validarNomeFantasia(),
          ),
          const SizedBox(height: 18),

          CustomTextFormField(
            controller: controller.email,
            hintText: 'E-mail',
            icon: FontAwesomeIcons.envelope,
            keyboardType: TextInputType.emailAddress,
            validator: (_) => controller.validarEmail(),
          ),
          const SizedBox(height: 18),

          CustomTextFormField(
            controller: controller.cnpj,
            hintText: 'CNPJ',
            icon: FontAwesomeIcons.building,
            keyboardType: TextInputType.number,
            validator: (_) => controller.validarCnpj(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
        centerTitle: true,
        elevation: 4,
        backgroundColor: Colors.indigo.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          children: [
            _buildTipoPessoaRadio(),
            const SizedBox(height: 28),
            Obx(
              () =>
                  controller.isPessoaFisica.value
                      ? _buildPessoaFisicaForm()
                      : _buildPessoaJuridicaForm(),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: controller.submitForm,
              icon: const Icon(Icons.send, size: 24, color: Colors.white),
              label: const Text(
                'Enviar',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo.shade700,
                minimumSize: const Size.fromHeight(50),
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
