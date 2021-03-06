import 'dart:ui';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:engemanos/models/teclado.dart';
import 'package:flutter/material.dart';

class PaginaPrincipalPage extends StatefulWidget {
  const PaginaPrincipalPage({Key? key}) : super(key: key);

  @override
  State<PaginaPrincipalPage> createState() => _PaginaPrincipalPageState();
}

class _PaginaPrincipalPageState extends State<PaginaPrincipalPage> {
  final TextEditingController osInput = TextEditingController();
  final TextEditingController matriculaInput = TextEditingController();
  String osString = '';
  String matriculaString = '';
  late int inputType = 1;
  bool existeIsTrue = false;
  bool osExisteIsTrue = true;
  bool campoIsVazio = false;

  var cadastroOs = [
    {
      'os': '1234',
      'matricula': '',
      'operador': '',
      'turno': '',
    }
  ];

  void limpaCampos() {
    osInput.text = '';
    matriculaInput.text = '';
  }

  void resetaValores() {
    osExisteIsTrue = true;
    campoIsVazio = false;
  }

  void apagaDepoisDe10Segundos() {
    EasyDebounce.debounce('debounceApaga', const Duration(milliseconds: 5000),
        () {
      print('Executing debounceApaga!');
      setState(() {
        osString = '';
        matriculaString = '';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 1.6;
    final double itemWidth = size.width / 2;
    final double itemHeightPortrait = (size.height - kToolbarHeight - 24) / 4.5;
    final double itemWidthPortrait = size.width / 2;

    return Scaffold(
      appBar: AppBar(
        title: const Text('ENGEMAN - OS', style: TextStyle(fontSize: 30.0)),
        toolbarHeight: 70,
      ),
      body: MediaQuery.of(context).orientation == Orientation.portrait
          ? SingleChildScrollView(
              child: Column(
                children: [
                  listaUsuario(),
                  loginUsuario(
                    context,
                    itemWidthPortrait,
                    itemHeightPortrait,
                    itemWidth,
                    itemHeight,
                  ),
                ],
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                listaUsuario(),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0, top: 0.0),
                  child: loginUsuario(
                    context,
                    itemWidthPortrait,
                    itemHeightPortrait,
                    itemWidth,
                    itemHeight,
                  ),
                ),
              ],
            ),
    );
  }

  SingleChildScrollView loginUsuario(
    BuildContext context,
    double itemWidthPortrait,
    double itemHeightPortrait,
    double itemWidth,
    double itemHeight,
  ) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customTextField(
                osInput,
                'OS',
              ),
              osExisteIsTrue == false
                  ? const Padding(
                      padding: EdgeInsets.only(left: 15.0, bottom: 8.0),
                      child: Text(
                        'C??digo da OS incorreto.',
                        style: TextStyle(color: Colors.red, fontSize: 20.0),
                      ),
                    )
                  : const Text(''),
              customTextField(
                matriculaInput,
                'Matr??cula',
              ),
              campoIsVazio
                  ? const Padding(
                      padding: EdgeInsets.only(left: 15.0, bottom: 5.0),
                      child: Text(
                        'C??digo da matr??cula e da OS devem estar preenchidos.',
                        style: TextStyle(color: Colors.red, fontSize: 20.0),
                      ),
                    )
                  : const Text(''),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SizedBox(
              width: MediaQuery.of(context).orientation == Orientation.portrait
                  ? MediaQuery.of(context).size.width
                  : 500,
              height: MediaQuery.of(context).orientation == Orientation.portrait
                  ? 700
                  : 450,
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? (itemWidthPortrait / itemHeightPortrait)
                          : (itemWidth / itemHeight),
                ),
                itemCount: teclado.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      if (inputType == 1) {
                        index == 9 //se for tecla Limpar
                            ? osInput.text = ''
                            : index == 11 //se for tecla Entrar
                                ? setState(() {
                                    bool osExiste = false;
                                    bool matriculaNaoExiste = false;
                                    // o botao 'iniciar' some porem a fun????o
                                    // continua funcionando, esse IF previne isso de acontecer
                                    if (!existeIsTrue) {
                                      if (osInput.text.isNotEmpty &&
                                          matriculaInput.text.isNotEmpty) {
                                        campoIsVazio = false;
                                        //iterando a array para verificar se existe o valor setado pelo usuario
                                        for (var i = 0;
                                            i < cadastroOs.length;
                                            i++) {
                                          if (cadastroOs[i]['os'] == osString) {
                                            osExiste = true;
                                            print('osExiste');
                                            osExisteIsTrue = true;
                                          } else {
                                            print('os nao existe');
                                            osExisteIsTrue = false;
                                          }

                                          if ((cadastroOs[i]['matricula'] ==
                                                  matriculaString) ==
                                              false) {
                                            matriculaNaoExiste = false;
                                          }
                                        }

                                        // novo valor ?? cadastrado se 'cadastra' for verdadeiro
                                        if (osExiste &&
                                            matriculaNaoExiste == false) {
                                          cadastroOs.add({
                                            'os': '1234',
                                            'matricula': matriculaInput.text,
                                            'operador':
                                                'Teste ${cadastroOs.length + 1}',
                                            'turno': '1',
                                          });
                                          limpaCampos();
                                          apagaDepoisDe10Segundos();
                                        }
                                      } else {
                                        campoIsVazio = true;
                                      }
                                    }
                                  })
                                : osInput.text += teclado[index]
                                    .label; //se for tecla n??mero, concatena
                      } else {
                        index == 9 //se for tecla Limpar
                            ? matriculaInput.text = ''
                            : index == 11 //se for tecla Entrar
                                ? setState(() {
                                    // o botao 'iniciar' some porem a fun????o
                                    // continua funcionando, esse IF previne isso de acontecer
                                    if (!existeIsTrue) {
                                      bool osExiste = false;
                                      bool matriculaNaoExiste = false;
                                      if (osInput.text.isNotEmpty &&
                                          matriculaInput.text.isNotEmpty) {
                                        campoIsVazio = false;
                                        //iterando a array para verificar se existe o valor setado pelo usuario
                                        for (var i = 0;
                                            i < cadastroOs.length;
                                            i++) {
                                          if (cadastroOs[i]['os'] == osString) {
                                            osExiste = true;
                                            osExisteIsTrue = true;
                                          } else {
                                            print('os nao existe');
                                            osExisteIsTrue = false;
                                          }

                                          if ((cadastroOs[i]['matricula'] ==
                                                  matriculaString) ==
                                              false) {
                                            matriculaNaoExiste = false;
                                            print('matriculaNaoExiste');
                                          }
                                        }

                                        // novo valor ?? cadastrado se 'cadastra' for verdadeiro
                                        if (osExiste &&
                                            matriculaNaoExiste == false) {
                                          cadastroOs.add({
                                            'os': '1234',
                                            'matricula': matriculaInput.text,
                                            'operador':
                                                'Teste ${cadastroOs.length + 1}',
                                            'turno': '1',
                                          });
                                          limpaCampos();
                                          apagaDepoisDe10Segundos();
                                        }
                                      } else {
                                        campoIsVazio = true;
                                      }
                                    }
                                  })
                                : matriculaInput.text += teclado[index]
                                    .label; //se for tecla n??mero, concatena
                      }

                      // !condi??ao para filtrar lista
                      // como nao estou colocando os valores do input pelo teclado
                      // do dispositivo, tive que fazer de outro jeito
                      // eu passo para uma variavel 'os' o valor inserido no
                      // userInput a cada click do teclado customizado
                      // essa variavel 'os' ?? usada para filtrar a lista de usuarios
                      // la embaixo
                      if (inputType == 1) {
                        if (osInput.text.isNotEmpty) {
                          setState(() {
                            osString = osInput.text;
                          });

                          //condi????o para sumir o botao de iniciar se ja existir usuario
                          if (matriculaInput.text.isNotEmpty) {
                            for (var i = 0; i < cadastroOs.length; i++) {
                              if (cadastroOs[i]['os'] == osString &&
                                  cadastroOs[i]['matricula'] ==
                                      matriculaString) {
                                setState(() {
                                  existeIsTrue = true;
                                  resetaValores();
                                  limpaCampos();
                                  print(existeIsTrue);
                                });
                              }
                            }
                          }
                        }
                        // condi????o para limpar a varivel 'os' e limpar a lista
                        if (index == 9) {
                          setState(() {
                            osString = '';
                            osInput.text = '';
                            existeIsTrue = false;
                          });
                        }
                        //input Type == 2
                      } else {
                        if (matriculaInput.text.isNotEmpty) {
                          setState(() {
                            matriculaString = matriculaInput.text;
                          });

                          //condi????o para sumir o botao de iniciar se ja existir usuario
                          for (var i = 0; i < cadastroOs.length; i++) {
                            if (cadastroOs[i]['os'] == osString &&
                                cadastroOs[i]['matricula'] == matriculaString) {
                              setState(() {
                                existeIsTrue = true;
                                resetaValores();
                                limpaCampos();
                                print(existeIsTrue);
                              });
                            }
                          }
                        }
                        // condi????o para limpar a varivel 'matriculaString' e limpar a lista
                        if (index == 9) {
                          setState(() {
                            matriculaString = '';
                            matriculaInput.text = '';
                            existeIsTrue = false;
                          });
                        }
                      }

                      //apagando os valores em geral
                      if (index == 9) {
                        matriculaString = '';
                        matriculaInput.text = '';
                        osString = '';
                        osInput.text = '';
                      }
                    },
                    child: (existeIsTrue && index == 11)
                        ? null
                        : Card(
                            color: index == 9 //se for tecla Limpar
                                ? const Color(0xFFcfe2ff)
                                : index == 11 //se for tecla Entrar
                                    ? Colors.greenAccent
                                    : Colors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Colors.blueGrey, width: 2.0),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Center(
                              child: Text(
                                teclado[index].label,
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).orientation ==
                                              Orientation.portrait
                                          ? 70.0
                                          : 40.0,
                                ),
                              ),
                            ),
                          ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Padding customTextField(TextEditingController textController, String label) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 5.0),
      child: SizedBox(
        width: MediaQuery.of(context).orientation == Orientation.portrait
            ? MediaQuery.of(context).size.width
            : 500,
        child: TextFormField(
          onTap: () {
            setState(() {
              label == 'OS' ? inputType = 1 : inputType = 2;
            });
          },
          autofocus: true,
          readOnly: true,
          controller: textController,
          style: MediaQuery.of(context).orientation == Orientation.portrait
              ? const TextStyle(fontSize: 40.0)
              : const TextStyle(fontSize: 28.0),
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
            // cor da borda
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            // border radius
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            labelText: label,
            hintText: label == 'OS' ? 'Iniciar ou Consultar OS' : null,
            fillColor: Colors.white,
            filled: true,
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Campo obrigat??rio.';
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget listaUsuario() {
    return MediaQuery.of(context).orientation == Orientation.portrait
        ? Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: 150.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(color: Colors.grey, spreadRadius: 1),
                ],
              ),
              child: ListView.builder(
                itemCount: cadastroOs.length,
                itemBuilder: (BuildContext context, int index) {
                  if (osString.isEmpty || matriculaString.isEmpty) {
                    return Container();
                    // verifico se no array cadastroOs possui o valor passado para
                    // a variavel 'os'
                  } else if (cadastroOs[index]['os'] == osString &&
                      cadastroOs[index]['matricula'] == matriculaString) {
                    return usuarioCard(index);
                  }
                  return Container();
                },
              ),
            ),
          )
        : Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: 130.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(color: Colors.grey, spreadRadius: 1),
                  ],
                ),
                child: ListView.builder(
                  itemCount: cadastroOs.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (osString.isEmpty || matriculaString.isEmpty) {
                      return Container();
                      // verifico se no array cadastroOs possui o valor passado para
                      // a variavel 'os'
                    } else if (cadastroOs[index]['os'] == osString &&
                        cadastroOs[index]['matricula'] == matriculaString) {
                      return usuarioCard(index);
                    }
                    return Container();
                  },
                ),
              ),
            ),
          );
  }

  Padding usuarioCard(int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: MediaQuery.of(context).orientation == Orientation.portrait
          ? itemUsuario(index, 150.0, 35.0, 25.0, 210.0)
          : itemUsuario(index, 130.0, 25.0, 15.0, 180.0),
    );
  }

  SizedBox itemUsuario(
    int index,
    double height,
    double fontSize,
    double vertical,
    double size,
  ) {
    return SizedBox(
      height: height,
      child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.blueGrey, width: 1.0),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'OS: ${cadastroOs[index]['os']}',
                    style: TextStyle(fontSize: fontSize),
                  ),
                  Text(
                    'Nome: ${cadastroOs[index]['operador']}',
                    style: TextStyle(fontSize: fontSize),
                  ),
                  Text(
                    'Turno: ${cadastroOs[index]['turno']} Turno',
                    style: TextStyle(fontSize: fontSize),
                  ),
                ],
              ),
              trailing: Wrap(
                spacing: 30,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        cadastroOs.removeAt(index);
                        limpaCampos();
                        matriculaString = '';
                        osString = '';
                        existeIsTrue = false;
                      });
                    },
                    child: const Text(
                      'Pausar',
                      style: TextStyle(fontSize: 35.0),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFFFFA54F),
                      padding: EdgeInsets.symmetric(vertical: vertical),
                      elevation: 5,
                      minimumSize: Size(size, 0),
                    ),
                  ),
                  cadastroOs.length == 2
                      ? ElevatedButton(
                          onPressed: () {
                            setState(() {
                              cadastroOs.removeAt(index);
                              limpaCampos();
                              matriculaString = '';
                              osString = '';
                              existeIsTrue = false;
                            });
                          },
                          child: const Text(
                            'Finalizar',
                            style: TextStyle(fontSize: 35.0),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.redAccent,
                            padding: EdgeInsets.symmetric(vertical: vertical),
                            elevation: 5,
                            minimumSize: Size(size, 0),
                          ),
                        )
                      : const Icon(Icons.add, color: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
