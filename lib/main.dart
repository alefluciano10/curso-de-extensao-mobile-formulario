import 'package:flutter/material.dart';
import 'package:flutter_masked_text3/flutter_masked_text3.dart';

void main() {
  runApp(const Cadastro());
}

class Cadastro extends StatelessWidget {
  const Cadastro({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulário',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const CadastroPage(title: 'Formulário'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key, required this.title});

  final String title;

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _nomeFantasiaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final MaskedTextController _telefoneController = MaskedTextController(
    mask: '(00) 00000-0000',
  );
  final MaskedTextController _nascimentoController = MaskedTextController(
    mask: '00/00/0000',
  );
  final MaskedTextController _cpfController = MaskedTextController(
    mask: '000.000.000-00',
  );
  final MaskedTextController _cnpjController = MaskedTextController(
    mask: '00.000.000/0000-00',
  );
  final TextEditingController _enderecoController = TextEditingController();

  // Campo de seleção

  bool _tipoPessoa = true;
  bool _aceitoTermo = false;
  String _sexoPessoa = 'Masculino';
  bool _receberNotificacao = false;
  double _rendaMensal = 0.0;

  List<Map<String, dynamic>> dadosCadastrais = [];

  // ===============
  // Verificação PF
  // ===============

  //Verificação do CPF

  bool isValidCPF(String cpf) {
    cpf = cpf.replaceAll(RegExp(r'[^0-9]'), '');

    if (cpf.length != 11 || RegExp(r'^(\d)\1*$').hasMatch(cpf)) return false;

    int soma1 = 0, soma2 = 0;
    for (int i = 0; i < 9; i++) {
      soma1 += int.parse(cpf[i]) * (10 - i);
      soma2 += int.parse(cpf[i]) * (11 - i);
    }

    int digito1 = (soma1 * 10) % 11;
    if (digito1 == 10) digito1 = 0;
    soma2 += digito1 * 2;

    int digito2 = (soma2 * 10) % 11;
    if (digito2 == 10) digito2 = 0;

    return cpf[9] == digito1.toString() && cpf[10] == digito2.toString();
  }

  // Verificação da data de nascimento

  bool isValidDate(String input) {
    final regex = RegExp(r"^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[012])/\d{4}$");
    return regex.hasMatch(input);
  }

  // ===============
  // Verificação PJ
  // ===============

  // Verificação do CNPJ

  bool isValidCNPJ(String cnpj) {
    cnpj = cnpj.replaceAll(RegExp(r'[^0-9]'), '');

    if (cnpj.length != 14 || RegExp(r'^(\d)\1*$').hasMatch(cnpj)) return false;

    List<int> multiplicadores1 = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
    List<int> multiplicadores2 = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];

    int soma1 = 0;
    for (int i = 0; i < 12; i++) {
      soma1 += int.parse(cnpj[i]) * multiplicadores1[i];
    }

    int digito1 = soma1 % 11;
    digito1 = digito1 < 2 ? 0 : 11 - digito1;

    int soma2 = 0;
    for (int i = 0; i < 13; i++) {
      soma2 += int.parse(cnpj[i]) * multiplicadores2[i];
    }

    int digito2 = soma2 % 11;
    digito2 = digito2 < 2 ? 0 : 11 - digito2;

    return cnpj[12] == digito1.toString() && cnpj[13] == digito2.toString();
  }

  // ====================
  // Verificações Comuns
  // ====================

  // Verificação do e-mail

  bool isValidEmail(String email) {
    final regex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    return regex.hasMatch(email);
  }

  // ==========================
  // Validação antes de enviar
  // ==========================

  void _validarFormulario() {
    // Pessoa Física | Pessoa Pessoa Juríca
    if (_nomeController.text.isEmpty) {
      _exibirValidacao(
        _tipoPessoa ? 'Nome é obrigátorio' : 'Razão Social é obrigatória',
      );
      return;
    }

    if (_tipoPessoa) {
      // Validações para Pessoa Física
      if (_nascimentoController.text.isEmpty) {
        _exibirValidacao('Data de nascimento é obrigatória');
        return;
      }

      if (!isValidDate(_nascimentoController.text)) {
        _exibirValidacao('Data de nascimento inválida');
        return;
      }

      if (_cpfController.text.isEmpty || !isValidCPF(_cpfController.text)) {
        _exibirValidacao('CPF inválido ou não preenchido');
        return;
      }
    } else {
      // Validações para Pessoa Jurídica
      if (_nomeFantasiaController.text.isEmpty) {
        _exibirValidacao('Nome Fantasia é obrigatório');
        return;
      }

      if (_cnpjController.text.isEmpty || !isValidCNPJ(_cnpjController.text)) {
        _exibirValidacao('CNPJ inválido ou não preenchido');
        return;
      }
    }

    if (_emailController.text.isEmpty || !isValidEmail(_emailController.text)) {
      _exibirValidacao('E-mail inválido ou não preenchido');
      return;
    }

    if (_telefoneController.text.isEmpty) {
      _exibirValidacao('Telefone é obrigatório');
      return;
    }

    if (_enderecoController.text.isEmpty) {
      _exibirValidacao('Endereço é obrigatório');
      return;
    }

    if (!_aceitoTermo) {
      _exibirValidacao('Você deve aceitar os termos e condições');
      return;
    }
  }

  void _exibirValidacao(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensagem), duration: Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      appBar: AppBar(
        centerTitle: true,

        backgroundColor: Color(0xFF344955),
        title: Text(
          'Formulario',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(12.0),

        child: ListView(
          children: [
            Row(
              children: [
                Radio(
                  value: true,
                  activeColor: Colors.indigoAccent,
                  groupValue: _tipoPessoa,
                  onChanged: (bool? tipo) {
                    setState(() {
                      _tipoPessoa = tipo!;
                    });
                  },
                ),

                const Text(
                  'Pessoa Física',
                  style: TextStyle(color: Colors.black87),
                ),

                Spacer(),

                Radio(
                  value: false,
                  groupValue: _tipoPessoa,
                  activeColor: Colors.indigoAccent,
                  onChanged: (bool? tipo) {
                    setState(() {
                      _tipoPessoa = tipo!;
                    });
                  },
                ),

                const Text(
                  'Pessoa Júridica',
                  style: TextStyle(color: Colors.black87),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Campo Nome Completo / Razão Social
            TextField(
              controller: _nomeController,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelStyle: TextStyle(color: Colors.black87),
                filled: true,
                fillColor: Colors.white,
                hintText: _tipoPessoa ? 'Nome Completo' : 'Razão Social',
                hintStyle: TextStyle(color: Colors.black87, fontSize: 14),
                prefixIcon: Icon(
                  _tipoPessoa ? Icons.person_outline : Icons.business,
                  color: Colors.indigoAccent,
                ),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),

                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFB0BEC5)),
                  borderRadius: BorderRadius.circular(15),
                ),

                contentPadding: EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 12,
                ),

                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.indigoAccent, width: 2),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Identificação da Pessoa
            if (!_tipoPessoa) ...[
              TextField(
                controller: _nomeFantasiaController,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Nome Fantasia',
                  hintStyle: TextStyle(color: Colors.black87, fontSize: 14),
                  prefixIcon: Icon(
                    Icons.storefront_outlined,
                    color: Colors.indigoAccent,
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFB0BEC5)),
                    borderRadius: BorderRadius.circular(15),
                  ),

                  contentPadding: EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 12,
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.indigoAccent,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              TextField(
                controller: _cnpjController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'CNPJ',
                  hintStyle: TextStyle(color: Colors.black87, fontSize: 14),
                  prefixIcon: Icon(
                    Icons.badge_outlined,
                    color: Colors.indigoAccent,
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFB0BEC5)),
                    borderRadius: BorderRadius.circular(15),
                  ),

                  contentPadding: EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 12,
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.indigoAccent,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ] else ...[
              TextField(
                controller: _nascimentoController,
                keyboardType: TextInputType.datetime,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Data de Nascimento',
                  hintStyle: TextStyle(color: Colors.black87, fontSize: 14),
                  prefixIcon: Icon(
                    Icons.calendar_month_outlined,
                    color: Colors.indigoAccent,
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFB0BEC5)),
                    borderRadius: BorderRadius.circular(15),
                  ),

                  contentPadding: EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 12,
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.indigoAccent,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              TextField(
                controller: _cpfController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'CPF',
                  hintStyle: TextStyle(color: Colors.black87, fontSize: 14),
                  prefixIcon: Icon(
                    Icons.badge_outlined,
                    color: Colors.indigoAccent,
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFB0BEC5)),
                    borderRadius: BorderRadius.circular(15),
                  ),

                  contentPadding: EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 12,
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.indigoAccent,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ],

            const SizedBox(height: 12),

            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'E-mail',
                hintStyle: TextStyle(color: Colors.black87, fontSize: 14),
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: Colors.indigoAccent,
                ),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),

                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFB0BEC5)),
                  borderRadius: BorderRadius.circular(15),
                ),

                contentPadding: EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 12,
                ),

                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.indigoAccent, width: 2),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: _telefoneController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Telefone',
                hintStyle: TextStyle(color: Colors.black87, fontSize: 14),
                prefixIcon: Icon(Icons.phone, color: Colors.indigoAccent),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),

                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFB0BEC5)),
                  borderRadius: BorderRadius.circular(15),
                ),

                contentPadding: EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 12,
                ),

                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.indigoAccent, width: 2),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: _enderecoController,
              keyboardType: TextInputType.streetAddress,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Endereço',
                hintStyle: TextStyle(color: Colors.black87, fontSize: 14),
                prefixIcon: Icon(
                  Icons.location_on_outlined,
                  color: Colors.indigoAccent,
                ),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),

                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFB0BEC5)),
                  borderRadius: BorderRadius.circular(15),
                ),

                contentPadding: EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 12,
                ),

                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.indigoAccent, width: 2),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 13),

            if (_tipoPessoa) ...[
              Text('Sexo', style: TextStyle(color: Colors.black87)),

              Column(
                children: [
                  RadioListTile<String>(
                    title: const Text(
                      'Masculino',
                      style: TextStyle(color: Colors.black87),
                    ),
                    value: 'Masculino',
                    activeColor: Colors.indigoAccent,
                    groupValue: _sexoPessoa,
                    onChanged: (String? value) {
                      setState(() {
                        _sexoPessoa = value!;
                      });
                    },
                  ),

                  RadioListTile<String>(
                    title: Text(
                      'Feminino',
                      style: TextStyle(color: Colors.black87),
                    ),
                    value: 'Feminino',
                    activeColor: Colors.indigoAccent,
                    groupValue: _sexoPessoa,
                    onChanged: (String? value) {
                      setState(() {
                        _sexoPessoa = value!;
                      });
                    },
                  ),
                ],
              ),
            ],

            Text(
              'Renda Mensal: $_rendaMensal',
              style: TextStyle(color: Colors.black87),
            ),

            Slider(
              value: _rendaMensal,
              min: 0,
              max: 10000,
              divisions: 100,
              activeColor: Colors.indigoAccent,
              label: _rendaMensal.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _rendaMensal = value;
                });
              },
            ),

            CheckboxListTile(
              title: const Text(
                'Aceito os termos e condições',
                style: TextStyle(color: Colors.black87),
              ),
              value: _aceitoTermo,
              activeColor:
                  _aceitoTermo
                      ? Colors.blue
                      : Theme.of(context).colorScheme.primary,
              onChanged: (aceito) {
                setState(() {
                  _aceitoTermo = aceito!;
                });
              },
            ),

            const SizedBox(height: 15),

            SwitchListTile(
              title: const Text(
                'Receber Notificações',
                style: TextStyle(color: Colors.black87),
              ),
              activeColor: Colors.indigoAccent,
              value: _receberNotificacao,
              onChanged: (bool? receber) {
                setState(() {
                  _receberNotificacao = receber!;
                });
              },
            ),

            const SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF344955),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: _validarFormulario,
                label: Text(
                  'Enviar Formulário',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                icon: Icon(Icons.send_outlined, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
