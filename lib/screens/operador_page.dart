import 'package:engemanos/models/teclado.dart';
import 'package:flutter/material.dart';

class PaginaPrincipalPage extends StatefulWidget {
  const PaginaPrincipalPage({Key? key}) : super(key: key);

  @override
  State<PaginaPrincipalPage> createState() => _PaginaPrincipalPageState();
}

class _PaginaPrincipalPageState extends State<PaginaPrincipalPage> {
  final TextEditingController userInput = TextEditingController();
  final TextEditingController senhaInput = TextEditingController();

  late int inputType = 1;

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
                const ListaUsuario(),
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
                const ListaUsuario(),
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
                userInput,
                'OS',
              ),
              customTextField(
                senhaInput,
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
                          ? userInput.text = ''
                          : index == 11 //se for tecla Entrar
                              ? setState(() {
                                  print('object');
                                })
                              : userInput.text += teclado[index].label;
                    } else {
                      index == 9 //se for tecla Limpar
                          ? senhaInput.text = ''
                          : index == 11 //se for tecla Entrar
                              ? setState(() {
                                  print('objectsdadasda');
                                })
                              : senhaInput.text += teclado[index].label;
                    }
                  },
                  child: Card(
                    color: index == 9 //se for tecla Limpar
                        ? Colors.redAccent
                        : index == 11 //se for tecla Entrar
                            ? Colors.greenAccent
                            : Colors.white,
                    shape: RoundedRectangleBorder(
                      side:
                          const BorderSide(color: Colors.blueGrey, width: 2.0),
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
          // showCursor: true,
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
}

class ListaUsuario extends StatelessWidget {
  const ListaUsuario({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: SizedBox(
                  height: 130.0,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side:
                          const BorderSide(color: Colors.blueGrey, width: 1.0),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Nome: Roberto',
                                style: TextStyle(fontSize: 25.0),
                              ),
                              Text(
                                'Turno: ${index + 1} Turno',
                                style: const TextStyle(fontSize: 25.0),
                              ),
                            ],
                          ),
                          trailing: ElevatedButton(
                            onPressed: () {},
                            child: const Text(
                              'Pausar',
                              style: TextStyle(fontSize: 25.0),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.orangeAccent,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              elevation: 5,
                              minimumSize: const Size(180, 0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
