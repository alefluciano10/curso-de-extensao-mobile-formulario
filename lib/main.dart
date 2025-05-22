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

  // Campo de seleção

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

              const SizedBox(height: 10),

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
                onPressed: () {},
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
