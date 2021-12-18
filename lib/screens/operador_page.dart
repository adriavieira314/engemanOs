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

  var cadastroOs = [
    {
      'os': '1234',
      'matricula': '',
      'operador': '',
      'turno': '',
    }
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 1.6;
    final double itemWidth = size.width / 2;
    final double itemHeightPortrait = (size.height - kToolbarHeight - 24) / 3;
    final double itemWidthPortrait = size.width / 2;

    return Scaffold(
      appBar: AppBar(
        title: const Text('ENGEMAN - OS'),
      ),
      body: MediaQuery.of(context).orientation == Orientation.portrait
          ? Column(
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
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            children: [
              customTextField(
                osInput,
                'OS',
              ),
              customTextField(
                matriculaInput,
                'Matrícula',
              ),
            ],
          ),
          SizedBox(
            width: 500,
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
                                  // o botao 'iniciar' some porem a função
                                  // continua funcionando, esse IF previne isso de acontecer
                                  if (!existeIsTrue) {
                                    print('osInput');
                                    if (osInput.text.isNotEmpty &&
                                        matriculaInput.text.isNotEmpty) {
                                      //iterando a array para verificar se existe o valor setado pelo usuario
                                      for (var i = 0;
                                          i < cadastroOs.length;
                                          i++) {
                                        if (cadastroOs[i]['os'] == osString) {
                                          osExiste = true;
                                          print('osExiste');
                                        } else {
                                          print('os nao existe');
                                        }

                                        if ((cadastroOs[i]['matricula'] ==
                                                matriculaString) ==
                                            false) {
                                          matriculaNaoExiste = false;
                                          print('matriculaNaoExiste');
                                        }
                                      }

                                      // novo valor é cadastrado se 'cadastra' for verdadeiro
                                      if (osExiste &&
                                          matriculaNaoExiste == false) {
                                        cadastroOs.add({
                                          'os': '1234',
                                          'matricula': matriculaInput.text,
                                          'operador':
                                              'Teste ${cadastroOs.length + 1}',
                                          'turno': '1',
                                        });
                                        print(cadastroOs);
                                      }
                                    }
                                  }
                                })
                              : osInput.text += teclado[index]
                                  .label; //se for tecla número, concatena
                    } else {
                      index == 9 //se for tecla Limpar
                          ? matriculaInput.text = ''
                          : index == 11 //se for tecla Entrar
                              ? setState(() {
                                  // o botao 'iniciar' some porem a função
                                  // continua funcionando, esse IF previne isso de acontecer
                                  if (!existeIsTrue) {
                                    bool osExiste = false;
                                    bool matriculaNaoExiste = false;
                                    print('matriculaInput');
                                    if (osInput.text.isNotEmpty &&
                                        matriculaInput.text.isNotEmpty) {
                                      //iterando a array para verificar se existe o valor setado pelo usuario
                                      for (var i = 0;
                                          i < cadastroOs.length;
                                          i++) {
                                        if (cadastroOs[i]['os'] == osString) {
                                          osExiste = true;
                                          print('osExiste');
                                        } else {
                                          print('os nao existe');
                                        }

                                        if ((cadastroOs[i]['matricula'] ==
                                                matriculaString) ==
                                            false) {
                                          matriculaNaoExiste = false;
                                          print('matriculaNaoExiste');
                                        }
                                      }

                                      // novo valor é cadastrado se 'cadastra' for verdadeiro
                                      if (osExiste &&
                                          matriculaNaoExiste == false) {
                                        cadastroOs.add({
                                          'os': '1234',
                                          'matricula': matriculaInput.text,
                                          'operador':
                                              'Teste ${cadastroOs.length + 1}',
                                          'turno': '1',
                                        });
                                        print(cadastroOs);
                                      }
                                    }
                                  }
                                })
                              : matriculaInput.text += teclado[index]
                                  .label; //se for tecla número, concatena
                    }

                    // !condiçao para filtrar lista
                    // como nao estou colocando os valores do input pelo teclado
                    // do dispositivo, tive que fazer de outro jeito
                    // eu passo para uma variavel 'os' o valor inserido no
                    // userInput a cada click do teclado customizado
                    // essa variavel 'os' é usada para filtrar a lista de usuarios
                    // la embaixo
                    if (inputType == 1) {
                      if (osInput.text.isNotEmpty) {
                        setState(() {
                          osString = osInput.text;
                        });

                        //condição para sumir o botao de iniciar se ja existir usuario
                        if (matriculaInput.text.isNotEmpty) {
                          for (var i = 0; i < cadastroOs.length; i++) {
                            if (cadastroOs[i]['os'] == osString &&
                                cadastroOs[i]['matricula'] == matriculaString) {
                              setState(() {
                                existeIsTrue = true;
                                print('naoExiste');
                                print(existeIsTrue);
                              });
                            }
                          }
                        }
                      }
                      // condição para limpar a varivel 'os' e limpar a lista
                      if (index == 9) {
                        setState(() {
                          osString = '';
                          existeIsTrue = false;
                        });
                      }
                      //input Type == 2
                    } else {
                      if (matriculaInput.text.isNotEmpty) {
                        setState(() {
                          matriculaString = matriculaInput.text;
                        });

                        //condição para sumir o botao de iniciar se ja existir usuario
                        for (var i = 0; i < cadastroOs.length; i++) {
                          if (cadastroOs[i]['os'] == osString &&
                              cadastroOs[i]['matricula'] == matriculaString) {
                            setState(() {
                              existeIsTrue = true;
                              print('naoExiste');
                              print(existeIsTrue);
                            });
                          }
                        }
                      }
                      // condição para limpar a varivel 'matriculaString' e limpar a lista
                      if (index == 9) {
                        setState(() {
                          matriculaString = '';
                          existeIsTrue = false;
                        });
                      }
                    }
                  },
                  child: (existeIsTrue && index == 11)
                      ? null
                      : Card(
                          color: index == 9 //se for tecla Limpar
                              ? Colors.redAccent
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
                              style: const TextStyle(
                                fontSize: 40.0,
                              ),
                            ),
                          ),
                        ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Padding customTextField(TextEditingController textController, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, left: 0.0, top: 10.0),
      child: SizedBox(
        width: 500,
        child: TextFormField(
          onTap: () {
            setState(() {
              label == 'OS' ? inputType = 1 : inputType = 2;
            });
          },
          autofocus: true,
          readOnly: true,
          controller: textController,
          style: const TextStyle(fontSize: 24.0),
          decoration: InputDecoration(
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
              return 'Campo obrigatório.';
            }
            return null;
          },
        ),
      ),
    );
  }

  Expanded listaUsuario() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
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
      child: SizedBox(
        height: 130.0,
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
                      style: const TextStyle(fontSize: 25.0),
                    ),
                    Text(
                      'Nome: ${cadastroOs[index]['operador']}',
                      style: const TextStyle(fontSize: 25.0),
                    ),
                    Text(
                      'Turno: ${cadastroOs[index]['turno']} Turno',
                      style: const TextStyle(fontSize: 25.0),
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
                          osInput.text = '';
                          matriculaInput.text = '';
                          existeIsTrue = false;
                        });
                      },
                      child: const Text(
                        'Pausar',
                        style: TextStyle(fontSize: 25.0),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.orangeAccent,
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        elevation: 5,
                        minimumSize: const Size(180, 0),
                      ),
                    ),
                    cadastroOs.length == 2
                        ? ElevatedButton(
                            onPressed: () {
                              setState(() {
                                cadastroOs.removeAt(index);
                                osInput.text = '';
                                matriculaInput.text = '';
                                existeIsTrue = false;
                              });
                            },
                            child: const Text(
                              'Finalizar',
                              style: TextStyle(fontSize: 25.0),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.orangeAccent,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              elevation: 5,
                              minimumSize: const Size(180, 0),
                            ),
                          )
                        : const Icon(Icons.add, color: Colors.white),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
