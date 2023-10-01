// import 'package:flutter/material.dart';
// import 'package:hero_app/page/hero_page.dart';
// import 'package:hero_app/repositories/characters_repositories.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   void initState() {
//     var charactersRepository = CharactersRepository();
//     charactersRepository.getCharacters();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Padding(
//         padding: const EdgeInsets.only(top: 100, bottom: 50),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Center(
//               child: Image.asset("assets/heroes.png"),
//             ),
//             SizedBox(
//               height: 50,
//             ),
//             ElevatedButton(
//                 onPressed: () async {
//                   var charactersRepository = CharactersRepository();
//                   var hero = await charactersRepository.getCharacters();
//                   print(hero.code);
//                   print(hero);
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const HeroPage()),
//                   );
//                 },
//                 child: Text("Start"))
//           ],
//         ),
//       ),
//     );
//   }
// }
