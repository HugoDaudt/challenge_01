import 'package:challenge_01/challenge_01.dart' as challenge_01;

import "dart:io";
import 'dart:convert';
import 'package:uuid/uuid.dart';

void main(List<String> arguments) {
  final dados = <Map<String, dynamic>>[];

  String opcoes = "";
  cls();

  do {
    print(
        'Olá! Por favor selecione uma das opções abaixo para continuarmos:\n');
    print('''
    1) Cadastrar uma nova empresa;
    2) Buscar Empresa cadastrada por CNPJ;
    3) Buscar Empresa por CPF/CNPJ do Sócio;
    4) Listar Empresas cadastradas em ordem alfabética (baseado na Razão Social);
    5) Excluir uma empresa (por ID);
    6) Sair.
  ''');
    opcoes = stdin.readLineSync(encoding: utf8)!;

    switch (opcoes) {
      case '1':
        {
          cls();
          cadastrar(dadosEmpresas: dados);
          break;
        }
      case '2':
        {
          cls();
          buscarCNPJ(dados);
          break;
        }
      case '3':
        {
          cls();
          buscarSocio(dados);
          break;
        }
      case '4':
        {
          cls();
          listar(dados);
          break;
        }
      case '5':
        {
          cls();
          excluir(dados);
          break;
        }
      case '6':
        {
          cls();
          print("Muito Obrigado! Até breve! \n");
          break;
        }
      default:
        {
          cls();
          print(
              "Opção não conhecida, por favor repita o processo novamente! \n");
          break;
        }
    }
  } while (opcoes != "6");
}

void cls() => print("\x1B[2J\x1B[0;0H");

//************************************************FUNÇÃO CADASTRO************************************************ */
void cadastrar({
  required List<Map> dadosEmpresas,
}) {
  var uuid = Uuid();

  String razaoSocial = validarString("razão social", 0);
  String nomeFantasia = validarString("nome fantasia", 0);
  String cnpj = validarString("CNPJ", 14);
  String enderecoLogradouro = validarString("logradouro do endereço", 0);
  String enderecoNumero = validarString("número do endereço", 0);
  String enderecoComplemento = validarString("complemento do endereço", 0);
  String enderecoCidade = validarString("cidade do endereço", 0);
  String enderecoBairro = validarString("bairro do endereço", 0);
  String enderecoEstado = validarString("estado do endereço", 0);
  String enderecoCEP = validarString("CEP do endereço", 8);
  String telefone = validarString("telefone", 11);

  String opcao = "";

  do {
    print('''
    Você deseja associar a esta empresa:
    0) Um sócio PF (pessoa física);
    1) Um sócio PJ (pessoa jurídica).
''');
    opcao = stdin.readLineSync(encoding: utf8)!;

    switch (opcao) {
      case '0':
        {
          cls();
          String nomePF = validarString("nome do sócio", 0);
          String cpfPF = validarString("CPF do sócio", 11);
          String enderecoLogradouroPF =
              validarString("logradouro do endereço do sócio", 0);
          String enderecoNumeroPF =
              validarString("número do endereço do sócio", 0);
          String enderecoComplementoPF =
              validarString("complemento do endereço do sócio", 0);
          String enderecoBairroPF =
              validarString("bairro do endereço do sócio", 0);
          String enderecoCidadePF =
              validarString("cidade do endereço do sócio", 0);
          String enderecoEstadoPF =
              validarString("estado do endereço do sócio", 0);
          String enderecoCEPPF = validarString("CEP do endereço do sócio", 8);

          final map = <String, dynamic>{
            "id": uuid.v4(),
            "CNPJ": corrigeCNPJ(cnpj),
            "dataCadastro": DateTime.now(),
            "razaoSocial": razaoSocial,
            "nomeFantasia": nomeFantasia,
            "telefone": corrigeTelefone(telefone),
            "socioVar": "0",
            "endereco": {
              "enderecoLogradouro": enderecoLogradouro,
              "enderecoNumero": enderecoNumero,
              "enderecoComplemento": enderecoComplemento,
              "enderecoCidade": enderecoCidade,
              "enderecoBairro": enderecoBairro,
              "enderecoEstado": enderecoEstado,
              "enderecoCEP": corrigeCEP(enderecoCEP),
            },
            "socio": {
              "socioPFNome": nomePF,
              "socioPFCPF": corrigeCPF(cpfPF),
              "enderecoSocio": {
                "socioPFEnderecoLogradouro": enderecoLogradouroPF,
                "socioPFEnderecoNumero": enderecoNumeroPF,
                "socioPFEnderecoComplemento": enderecoComplementoPF,
                "socioPFEnderecoBairro": enderecoBairroPF,
                "socioPFEnderecoCidade": enderecoCidadePF,
                "socioPFEnderecoEstado": enderecoEstadoPF,
                "socioPFEenderecoCEP": corrigeCEP(enderecoCEPPF),
              }
            }
          };
          dadosEmpresas.add(map);
          break;
        }
      case '1':
        {
          cls();
          String razaoSocialPJ =
              validarString("razão social da pessoa jurídica", 0);
          String nomeFantasiaPJ =
              validarString("nome fantasia da pessoa jurídica", 0);
          String cnpjPJ = validarString("CNPJ da pessoa jurídica", 14);
          String enderecoLogradouroPJ =
              validarString("logradouro do endereço da pessoa jurídica", 0);
          String enderecoNumeroPJ =
              validarString("número do endereço da pessoa jurídica", 0);
          String enderecoComplementoPJ =
              validarString("complemento do endereço da pessoa jurídica", 0);
          String enderecoBairroPJ =
              validarString("bairro do endereço da pessoa jurídica", 0);
          String enderecoCidadePJ =
              validarString("cidade do endereço da pessoa jurídica", 0);
          String enderecoEstadoPJ =
              validarString("estado do endereço da pessoa jurídica", 0);
          String enderecoCEPPJ =
              validarString("CEP do endereço da pessoa jurídica", 8);

          final map = <String, dynamic>{
            "id": uuid.v4(),
            "CNPJ": corrigeCNPJ(cnpj),
            "dataCadastro": DateTime.now(),
            "razaoSocial": razaoSocial,
            "nomeFantasia": nomeFantasia,
            "telefone": corrigeTelefone(telefone),
            "socioVar": "1",
            "endereco": {
              "enderecoLogradouro": enderecoLogradouro,
              "enderecoNumero": enderecoNumero,
              "enderecoComplemento": enderecoComplemento,
              "enderecoBairro": enderecoBairro,
              "enderecoCidade": enderecoCidade,
              "enderecoEstado": enderecoEstado,
              "enderecoCEP": corrigeCEP(enderecoCEP),
            },
            "socio": {
              "socioPJRazaoSocial": razaoSocialPJ,
              "socioPJNomeFantasia": nomeFantasiaPJ,
              "socioPJCNPJ": corrigeCNPJ(cnpjPJ),
              "enderecoSocio": {
                "socioPJEnderecoLogradouro": enderecoLogradouroPJ,
                "socioPJEnderecoNumero": enderecoNumeroPJ,
                "socioPJEnderecoComplemento": enderecoComplementoPJ,
                "socioPJEnderecoBairro": enderecoBairroPJ,
                "socioPJEnderecoCidade": enderecoCidadePJ,
                "socioPJEnderecoEstado": enderecoEstadoPJ,
                "socioPJEenderecoCEP": corrigeCEP(enderecoCEPPJ),
              }
            }
          };
          dadosEmpresas.add(map);
          break;
        }
      default:
        {
          cls();
          print("Por favor, digite uma opção válida!");
          break;
        }
    }
    cls();
    print(opcao);
  } while ((opcao != "0") && (opcao != "1"));
  print("Dado da empresa: $razaoSocial cadastrado com sucesso!");
  return;
}

//************************************************FUNÇÃO BUSCAR CNPJ************************************************ */

void buscarCNPJ(List<Map<String, dynamic>> listarDados) {
  if (listarDados.isEmpty) {
    print("A lista está vazia!");
    return;
  }
  print("Digite o CNPJ da empresa a ser buscada:");
  String cnpj = corrigeCNPJ(validarString("CNPJ", 14));
  for (int i = 0; i < listarDados.length; i++) {
    if (listarDados[i]["CNPJ"] == cnpj) {
      cls();
      print("Empresa encontrada!");
      print("");
      mostrarDados(listarDados[i]);
      return;
    }
  }
  print("Empresa não cadastrada no sistema!");

  return;
}

//************************************************FUNÇÃO BUSCAR SÓCIO************************************************ */

void buscarSocio(List<Map<String, dynamic>> listarDados) {
  if (listarDados.isEmpty) {
    print("A lista está vazia!");
    return;
  }
  String opcao = '';
  do {
    print('''
    Digite por meio de qual dado você deseja buscar a empresa:
    1) CPF
    2) CNPJ
''');
    opcao = stdin.readLineSync(encoding: utf8)!;
    if (opcao == '1') {
      print("Digite o CPF do sócio a ser buscado:");
      String cpf = corrigeCPF(validarString("CPF", 11));
      for (int i = 0; i < listarDados.length; i++) {
        if (listarDados[i]["socio"]["socioPFCPF"] == cpf) {
          cls();
          print("Empresa encontrada!");
          print("");
          mostrarDados(listarDados[i]);
          return;
        }
      }
      print("Empresa não cadastrada no sistema!");
      return;
    } else if (opcao == '2') {
      print("Digite o CNPJ da empresa sócia a ser buscada:");
      String cnpj = corrigeCNPJ(validarString("CNPJ", 14));
      for (int i = 0; i < listarDados.length; i++) {
        if (listarDados[i]["socio"]["socioPJCNPJ"] == cnpj) {
          cls();
          print("Empresa encontrada!");
          print("");
          mostrarDados(listarDados[i]);
          return;
        }
      }
      print("Empresa não cadastrada no sistema!");
      return;
    } else {
      cls();
      print("Opcão inválida!");
    }
  } while (opcao != '0' && opcao != '1');
  return;
}

//************************************************FUNÇÃO LISTAR ALFABETICAMENTE************************************************ */

void listar(List<Map<String, dynamic>> listarDados) {
  cls();
  print("Lista em ordem alfabética:");

  listarDados.sort((a, b) =>
      a["razaoSocial"].toUpperCase().compareTo(b['razaoSocial'].toUpperCase()));

  mostrarLista(listarDados);
  return;
}

void excluir(List<Map<String, dynamic>> listarDados) {
  if (listarDados.isEmpty) {
    print("A lista está vazia!");
    return;
  }
  bool exclusaoOk = false;

  mostrarLista(listarDados);
  print("Digite o id da empresa a ser excluída:");
  String id = stdin.readLineSync(encoding: utf8)!;
  do {
    for (int i = 0; i < listarDados.length; i++) {
      if (listarDados[i]["id"] == id) {
        exclusaoOk = true;
        String opcao = "";
        do {
          print('''
            Você realmente deseja excluir a empresa?
            0) Não
            1) Sim
          ''');
          opcao = stdin.readLineSync(encoding: utf8)!;
          if (opcao == "0") {
            print("Empresa não descadastrada!");
            return;
          } else if (opcao == '1') {
            listarDados.removeAt(i);
            print("Empresa descadastrada com sucesso!");
            return;
          }
        } while (opcao != '0' && opcao != '1');
      }
    }
    print("Empresa não encontrada! Por favor digite novamente:");
    id = stdin.readLineSync(encoding: utf8)!;
  } while (exclusaoOk == false);
}

//************************************************FUNÇÕES AUXILIARES************************************************ */
//************************************************FUNÇÃO PARA MOSTRAR DADOS************************************************ */

void mostrarDados(Map<String, dynamic> dados) {
  print("ID: ${dados["id"]}");
  print("CNPJ: ${dados["CNPJ"]} Data Cadastro: ${dados["dataCadastro"]}");
  print("Razão Social: ${dados["razaoSocial"]}");
  print("Nome Fantasia: ${dados["nomeFantasia"]}");
  print("Telefone: ${dados["telefone"]}");
  print(
      "Endereço: ${dados["endereco"]["enderecoLogradouro"]}, ${dados["endereco"]["enderecoNumero"]}, ${dados["endereco"]["enderecoBairro"]}, ${dados["endereco"]["enderecoCidade"]}/${dados["endereco"]["enderecoEstado"]}, ${dados["endereco"]["enderecoComplemento"]}, ${dados["endereco"]["enderecoCEP"]}");
  print("Sócio:");

  if (dados["socioVar"] == "0") {
    print("CPF: ${dados["socio"]["socioPFCPF"]}");
    print("Nome Completo: ${dados["socio"]["socioPFNome"]}");
    print(
        "Endereço: ${dados["socio"]["enderecoSocio"]["socioPFEnderecoLogradouro"]}, ${dados["socio"]["enderecoSocio"]["socioPFEnderecoNumero"]}, ${dados["socio"]["enderecoSocio"]["socioPFEnderecoBairro"]}, ${dados["socio"]["enderecoSocio"]["socioPFEnderecoCidade"]}/${dados["socio"]["enderecoSocio"]["socioPFEnderecoEstado"]}, ${dados["socio"]["enderecoSocio"]["socioPFEnderecoComplemento"]}, ${dados["socio"]["enderecoSocio"]["socioPFEenderecoCEP"]}}");
  } else if (dados["socioVar"] == "1") {
    print("CNPJ: ${dados["socio"]["socioPJCNPJ"]}");
    print("Razão Social: ${dados["socio"]["socioPJRazaoSocial"]}");
    print("Nome Fantasia: ${dados["socio"]["socioPJNomeFantasia"]}");
    print(
        "Endereço: ${dados["socio"]["enderecoSocio"]["socioPJEnderecoLogradouro"]}, ${dados["socio"]["enderecoSocio"]["socioPJEnderecoNumero"]}, ${dados["socio"]["enderecoSocio"]["socioPJEnderecoBairro"]}, ${dados["socio"]["enderecoSocio"]["socioPJEnderecoCidade"]}/${dados["socio"]["enderecoSocio"]["socioPJEnderecoEstado"]}, ${dados["socio"]["enderecoSocio"]["socioPJEnderecoComplemento"]}, ${dados["socio"]["enderecoSocio"]["socioPJEenderecoCEP"]}}");
  }
  print("");
  return;
}

//************************************************FUNÇÃO PARA VALIDAR ENTRADA USUÁRIO************************************************ */

String validarString(String dado, int tamanho) {
  String valor = "";

  while (valor.isEmpty) {
    print("Por favor, digite um $dado a ser adicionado válido:");
    valor = stdin.readLineSync(encoding: utf8)!;
    if (tamanho != 0 && valor.length == (tamanho)) {
      cls();
      print("Valor digitado válido!");
    } else if (tamanho == 0) {
      cls();
      print("Valor digitado válido!");
    } else {
      cls();
      print("Valor digitado inválido!");
      valor = "";
    }
  }

  return valor;
}

//************************************************FUNÇÕES PARA FORMATAR DADOS************************************************ */

String corrigeCNPJ(String cnpj) {
  String cnpjCorrigido =
      "${cnpj.substring(0, 2)}.${cnpj.substring(2, 5)}.${cnpj.substring(5, 8)}/${cnpj.substring(8, 12)}-${cnpj.substring(12, 14)}";
  return cnpjCorrigido;
}

String corrigeCPF(String cpf) {
  String cpfCorrigido =
      "${cpf.substring(0, 3)}.${cpf.substring(3, 6)}.${cpf.substring(6, 9)}-${cpf.substring(9, 11)}";
  return cpfCorrigido;
}

String corrigeTelefone(String telefone) {
  String telefoneCorrigido =
      "(${telefone.substring(0, 2)}) ${telefone.substring(2, 3)} ${telefone.substring(3, 7)}-${telefone.substring(7, 11)}";
  return telefoneCorrigido;
}

String corrigeCEP(String cep) {
  String cepCorrigido =
      "${cep.substring(0, 2)}.${cep.substring(2, 5)}-${cep.substring(5, 8)}";
  return cepCorrigido;
}

//************************************************FUNÇÃO PARA ORDENAR A LISTA DE DADOS************************************************ */

void mostrarLista(List<Map<String, dynamic>> listarDados) {
  if (listarDados.isEmpty) {
    print("Sem dados na lista!");
    return;
  } else {
    for (int i = 0; i < listarDados.length; i++) {
      mostrarDados(listarDados[i]);
    }
  }
  return;
}
