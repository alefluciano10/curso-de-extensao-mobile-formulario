import 'package:flutter/material.dart';

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
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _nascimentoController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _cnpjController = TextEditingController();
  final TextEditingController _enderecoController = TextEditingController();

  // Campo de selecçao

  bool _tipoPessoa = true;
  bool _aceitoTermo = false;
  String _sexoPessoa = 'Masculino';
  bool _receberNotificacao = false;
  double _rendaMensal = 0.0;

  List<Map<String, dynamic>> dadosCadastrais = [];

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

            // Campo Nome Completo
            TextField(
              controller: _nomeController,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelStyle: TextStyle(color: Colors.black87),
                filled: true,
                fillColor: Colors.white,
                hintText: 'Nome Completo',
                hintStyle: TextStyle(color: Colors.black87, fontSize: 14),

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

            // Campo E-mail
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'E-mail',
                hintStyle: TextStyle(color: Colors.black87, fontSize: 14),

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

            // Campo Telefone
            TextField(
              controller: _telefoneController,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Telefone',
                hintStyle: TextStyle(color: Colors.black87, fontSize: 14),

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

            // Campo Endereço
            TextField(
              controller: _enderecoController,
              keyboardType: TextInputType.streetAddress,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Enereço',
                hintStyle: TextStyle(color: Colors.black87, fontSize: 14),

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
            if (_tipoPessoa) ...[
              TextField(
                controller: _nascimentoController,
                keyboardType: TextInputType.datetime,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Data de Nascimento',
                  hintStyle: TextStyle(color: Colors.black87, fontSize: 14),

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

              const SizedBox(height: 15),

              Text('Sexo', style: TextStyle(color: Colors.black87)),

              Column(
                children: [
                  RadioListTile<bool>(
                    title: const Text(
                      'Masculino',
                      style: TextStyle(color: Colors.black87),
                    ),
                    value: true,
                    activeColor: Colors.indigoAccent,
                    groupValue: _tipoPessoa,
                    onChanged: (bool? tipo) {
                      setState(() {
                        _tipoPessoa = tipo!;
                      });
                    },
                  ),

                  RadioListTile<bool>(
                    title: Text(
                      'Feminino',
                      style: TextStyle(color: Colors.black87),
                    ),
                    value: false,
                    activeColor: Colors.indigoAccent,
                    groupValue: _tipoPessoa,
                    onChanged: (bool? tipo) {
                      setState(() {
                        _tipoPessoa = tipo!;
                      });
                    },
                  ),
                ],
              ),
            ] else ...[
              TextField(
                controller: _nomeFantasiaController,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Nome Fantasia',
                  hintStyle: TextStyle(color: Colors.black87, fontSize: 14),

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

              const SizedBox(height: 10),

              TextField(
                controller: _cnpjController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'CNPJ',
                  hintStyle: TextStyle(color: Colors.black87, fontSize: 14),

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
          ],
        ),
      ),
    );
  }
}
