import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdfLib;
import 'package:universal_html/html.dart' as html;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulário Cadastro de Veículo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String modelo = '';
  String marca = '';
  String? anoFabricacao;
  String numeroChassi = '';
  String renavan = '';
  String numeroCrlv = '';
  String placa = '';
  String? uf;
  String qtdPortas = '';
  String numeroAssentos = '';
  String? combustivel;
  String? transmissao;
  String? posicaoMotor;
  String valorVeiculo = '';
  DateTime? dtVencIpva;
  DateTime? dt1Licenciamento;
  String? tpProprietario;
  String? acessibilidade;
  String prefixoVeiculo = '';
  String capTanque = '';
  String pesoBruto = '';
  String? especieVeiculo;
  String corPredominante = '';
  String potencia = '';
  String? isentoIcms;
  String? isentoIpi;
  String capacidade = '';

  List<String> anos = List<String>.generate(50, (i) => (2024 - i).toString());
  List<String> transmissoes = ['Automático', 'Manual'];
  List<String> combustiveis = ['Gasolina', 'Diesel', 'Etanol', 'GNV', 'Elétrico'];
  List<String> posicoesMotor = ['Dianteiro', 'Traseiro', 'Central'];
  List<String> tipoProprietario = ['Pessoa Física (PF)', 'Pessoa Jurídica (PJ)'];
  List<String> acessibilidades = ['Sim', 'Não'];
  List<String> especieVeiculos = ['Automóvel', 'Ônibus'];
  List<String> istIcms = ['Sim', 'Não'];
  List<String> istIpi = ['Sim', 'Não'];
  List<String> ufs = ['AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 'ES', 'GO', 'MA', 'MT', 'MS', 'MG',
    'PA', 'PB', 'PR', 'PE', 'PI', 'RJ', 'RN', 'RS', 'RO', 'RR', 'SC', 'SP', 'SE', 'TO'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário Cadastro de Veículo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionHeader(title: 'Identificação'),
              SizedBox(height: 10),
              Wrap(
                spacing: 20,
                runSpacing: 20,
                children: [
                  buildTextField('Chassi', numeroChassi, (val) => setState(() => numeroChassi = val)),
                  buildDropdown('Ano de Fabricação', anoFabricacao, anos, (val) => setState(() => anoFabricacao = val)),
                  buildTextField('Renavan', renavan, (val) => setState(() => renavan = val)),
                  buildTextField('Prefixo Veículo', prefixoVeiculo, (val) => setState(() => prefixoVeiculo = val)),
                  buildTextField('CRLV', numeroCrlv, (val) => setState(() => numeroCrlv = val)),
                  buildTextFieldWithSymbol('Vl.Veículo IPVA', valorVeiculo, 'R\$', (val) => setState(() => valorVeiculo = val)),
                  buildDateField('Dt. Venc. IPVA', dtVencIpva, (val) => setState(() => dtVencIpva = val)),
                  buildTextField('Placa', placa, (val) => setState(() => placa = val)),
                  buildDropdown('UF', uf, ufs, (val) => setState(() => uf = val)),
                  buildDateField('Dt. 1° Licenciamento', dt1Licenciamento, (val) => setState(() => dt1Licenciamento = val)),
                  buildDropdown('Tipo de Proprietário', tpProprietario, tipoProprietario, (val) => setState(() => tpProprietario = val)),
                  buildTextField('Potencia(N°CV)', potencia, (val) => setState(() => potencia = val)),
                  buildDropdown('Isento ICMS', isentoIcms, istIcms, (val) => setState(() => isentoIcms = val)),
                  buildDropdown('Isento IPI', isentoIpi, istIpi, (val) => setState(() => isentoIpi = val)),
                ],
              ),
              SizedBox(height: 20),
              SectionHeader(title: 'Características'),
              SizedBox(height: 10),
              Wrap(
                spacing: 20,
                runSpacing: 20,
                children: [
                  buildTextField('Marca', marca, (val) => setState(() => marca = val)),
                  buildTextField('Modelo', modelo, (val) => setState(() => modelo = val)),
                  buildTextField('Cor Predominante', corPredominante, (val) => setState(() => corPredominante = val)),
                  buildDropdown('Transmissão', transmissao, transmissoes, (val) => setState(() => transmissao = val)),
                  buildDropdown('Tipo Combustível', combustivel, combustiveis, (val) => setState(() => combustivel = val)),
                  buildTextField('Cap.Tanque', capTanque, (val) => setState(() => capTanque = val)),
                  buildTextField('Peso Bruto', pesoBruto, (val) => setState(() => pesoBruto = val)),
                  buildTextField('Número de Assentos', numeroAssentos, (val) => setState(() => numeroAssentos = val)),
                  buildTextField('Capacidade', capacidade, (val) => setState(() => capacidade = val)),
                  buildTextField('Qnt.Portas', qtdPortas, (val) => setState(() => qtdPortas = val)),
                  buildDropdown('Acessibilidade', acessibilidade, acessibilidades, (val) => setState(() => acessibilidade = val)),
                  buildDropdown('Espécie de Veículo', especieVeiculo, especieVeiculos, (val) => setState(() => especieVeiculo = val)),
                  buildDropdown('Posição do Motor', posicaoMotor, posicoesMotor, (val) => setState(() => posicaoMotor = val)),
                ],
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    _createPdf();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[900], // Cor de fundo azul escuro
                    foregroundColor: Colors.white, // Cor do texto branco
                    minimumSize: Size(150, 50), // Largura e altura do botão
                  ),
                  child: Text('Gerar PDF', style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, String initialValue, Function(String) onChanged) {
    return Container(
      width: 220,
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(), // Adiciona a borda ao redor do campo de texto
        ),
        initialValue: initialValue,
        onChanged: onChanged,
      ),
    );
  }

  Widget buildTextFieldWithSymbol(String label, String initialValue, String symbol, Function(String) onChanged) {
    return Container(
      width: 220,
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          prefixText: symbol,
          border: OutlineInputBorder(), // Adiciona a borda ao redor do campo de texto
        ),
        initialValue: initialValue,
        onChanged: onChanged,
      ),
    );
  }

  Widget buildDropdown(String label, String? value, List<String> items, Function(String?) onChanged) {
    return Container(
      width: 220,
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(), // Adiciona a borda ao redor do campo de dropdown
        ),
        value: value,
        onChanged: onChanged,
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget buildDateField(String label, DateTime? selectedDate, Function(DateTime) onChanged) {
    return Container(
      width: 220,
      child: GestureDetector(
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: selectedDate ?? DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
          );
          if (pickedDate != null && pickedDate != selectedDate) {
            onChanged(pickedDate);
          }
        },
        child: AbsorbPointer(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: label,
              suffixIcon: Icon(Icons.calendar_today),
              border: OutlineInputBorder(), // Adiciona a borda ao redor do campo de data
            ),
            controller: TextEditingController(
              text: selectedDate == null ? '' : "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _createPdf() async {
    final pdfLib.Document pdf = pdfLib.Document();

    pdf.addPage(
      pdfLib.Page(
        build: (pdfLib.Context context) => pdfLib.Padding(
          padding: pdfLib.EdgeInsets.all(20),
          child: pdfLib.Column(
            crossAxisAlignment: pdfLib.CrossAxisAlignment.start,
            children: [
              pdfLib.Text('Formulário Cadastro Veículo', style: pdfLib.TextStyle(fontSize: 22, fontWeight: pdfLib.FontWeight.bold)),
              pdfLib.SizedBox(height: 10),
              pdfLib.Text('Identificação', style: pdfLib.TextStyle(fontSize: 18, fontWeight: pdfLib.FontWeight.bold)),
              pdfLib.Divider(),
              pdfLib.Wrap(
                spacing: 10, // espaço horizontal entre os campos
                runSpacing: 10, // espaço vertical entre as linhas
                children: [
                  buildPdfText('Chassi', numeroChassi),
                  buildPdfText('Ano Fabricação', anoFabricacao ?? ''),
                  buildPdfText('Renavan', renavan),
                  buildPdfText('Prefixo Veículo', prefixoVeiculo),
                  buildPdfText('CRLV', numeroCrlv),
                  buildPdfText('Vl.Veículo IPVA', valorVeiculo),
                  buildPdfText('Dt. Venc. IPVA', dtVencIpva != null ? "${dtVencIpva!.day}/${dtVencIpva!.month}/${dtVencIpva!.year}" : ''),
                  buildPdfText('Placa', placa),
                  buildPdfText('UF', uf ?? ''),
                  buildPdfText('Dt. 1° Licenciamento', dt1Licenciamento != null ? "${dt1Licenciamento!.day}/${dt1Licenciamento!.month}/${dt1Licenciamento!.year}" : ''),
                  buildPdfText('Tipo de Proprietário', tpProprietario ?? ''),
                  buildPdfText('Potencia(N°CV)', potencia),
                  buildPdfText('Isento ICMS', isentoIcms ?? ''),
                  buildPdfText('Isento IPI', isentoIpi ?? ''),
                ],
              ),
              pdfLib.SizedBox(height: 20),
              pdfLib.Text('Características', style: pdfLib.TextStyle(fontSize: 18, fontWeight: pdfLib.FontWeight.bold)),
              pdfLib.Divider(),
              pdfLib.Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  buildPdfText('Marca', marca),
                  buildPdfText('Modelo', modelo),
                  buildPdfText('Cor Predominante', corPredominante),
                  buildPdfText('Transmissão', transmissao ?? ''),
                  buildPdfText('Tipo Combustível', combustivel ?? ''),
                  buildPdfText('Cap.Tanque', capTanque),
                  buildPdfText('Peso Bruto', pesoBruto),
                  buildPdfText('Número de Assentos', numeroAssentos),
                  buildPdfText('Capacidade', capacidade),
                  buildPdfText('Qnt.Portas', qtdPortas),
                  buildPdfText('Acessibilidade', acessibilidade ?? ''),
                  buildPdfText('Espécie Veículo', especieVeiculo ?? ''),
                  buildPdfText('Posição do Motor', posicaoMotor ?? ''),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    final Uint8List bytes = await pdf.save();

    final blob = html.Blob([bytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    html.AnchorElement(href: url)
      ..setAttribute('download', 'Formulario_veiculo.pdf')
      ..click();
    html.Url.revokeObjectUrl(url);
  }

  pdfLib.Widget buildPdfText(String label, String value) {
    return pdfLib.Container(
      width: 200,
      child: pdfLib.RichText(
        text: pdfLib.TextSpan(
          text: '$label: ',
          style: pdfLib.TextStyle(fontSize: 14, fontWeight: pdfLib.FontWeight.bold),
          children: <pdfLib.TextSpan>[
            pdfLib.TextSpan(
              text: value,
              style: pdfLib.TextStyle(fontSize: 14, fontWeight: pdfLib.FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}
