import 'package:flutter/material.dart';
import 'package:hero_app/model/characters_model.dart';
import 'package:hero_app/repositories/characters_repositories.dart';

class HeroPage extends StatefulWidget {
  const HeroPage({super.key});

  @override
  State<HeroPage> createState() => _HeroPageState();
}

class _HeroPageState extends State<HeroPage> {
  ScrollController _scrollController = ScrollController();
  late CharactersRepository charactersRepository;
  CharactersModel charactersModel = CharactersModel();
  var offset = 0;
  var load = false;

  void initState() {
    _scrollController.addListener(() {
      var positionPagination = _scrollController.position.maxScrollExtent * 0.7;
      if (_scrollController.position.pixels > positionPagination) {
        loadData();
      }
    });
    charactersRepository = CharactersRepository();
    loadData();
    super.initState();
  }

  loadData() async {
    if (load) return;
    if (charactersModel.data == null || charactersModel.data!.results == null) {
      charactersModel = await charactersRepository.getCharacters(offset);
    } else {
      setState(() {
        load = true;
      });
      offset = offset + charactersModel.data!.count!;

      var tempList = await charactersRepository.getCharacters(offset);
      charactersModel.data!.results!.addAll(tempList.data!.results!);
      load = false;
    }
    setState(() {});
  }

  int totalCountReturn() {
    try {
      return charactersModel.data!.total!;
    } catch (e) {
      return 0;
    }
  }

  int atualCountReturn() {
    try {
      return offset + charactersModel.data!.count!;
    } catch (e) {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Heros: ${atualCountReturn()}/ ${totalCountReturn()}"),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                controller: _scrollController,
                itemCount: (charactersModel.data == null ||
                        charactersModel.data!.results == null)
                    ? 0
                    : charactersModel.data!.results!.length,
                itemBuilder: (_, int index) {
                  var characters = charactersModel.data!.results![index];
                  var image = characters.thumbnail!.path! +
                      "." +
                      characters.thumbnail!.extension!;
                  print(characters.name);
                  return SingleChildScrollView(
                    child: Card(
                      elevation: 5,
                      color: Colors.blueGrey.shade600,
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                ),
                                child: Text(
                                  "${characters.name!}\n",
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Image.network(
                                      image,
                                      width: 150,
                                      height: 120,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 60, right: 20),
                                      child: Container(
                                        width: 180,
                                        height: 150,
                                        child: SingleChildScrollView(
                                          child: Text(
                                            "${characters.description!}\n",
                                            style: const TextStyle(
                                                fontSize: 10,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
          !load
              ? ElevatedButton(
                  onPressed: () {
                    loadData();
                  },
                  child: Text("Proxima Pagina"),
                )
              : CircularProgressIndicator()
        ],
      ),
    );
  }
}
