import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:staj_projectt/src/features/characters/data/character_repository.dart';

import '../../../routing/app_router.dart';

class DetailScreen extends ConsumerWidget {
  const DetailScreen({Key? key, required this.characterId}) : super(key: key);

  final int characterId;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final characterDetailRepository =
        ref.watch(charactersDetailProvider(characterId.toString()));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 198, 149, 145),
        title: Text(
          " Character Detail Screen",
          style: GoogleFonts.marvel(fontWeight: FontWeight.w900, fontSize: 25),
        ),
      ),
      body: characterDetailRepository.when(
        data: (marvelResult) {
          return ListView(
            children: marvelResult.data!.results!
                .map(
                  (e) => Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        decoration: BoxDecoration(),
                        margin: EdgeInsets.all(20),
                        child: Image.network(
                            "${e?.thumbnail?.path}.${e?.thumbnail?.extension}"),
                      ),
                      Card(
                        elevation: 8,
                        clipBehavior: Clip.antiAlias,
                        shadowColor: Colors.red.shade900,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          side: BorderSide(
                            color: Colors.red.shade900,
                            width: 1,
                          ),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20,
                          ),
                          textColor: Color.fromARGB(255, 118, 11, 11),
                          title: Text(e?.description ?? "  ",
                              style: GoogleFonts.marvel(
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.left),
                          onTap: () {
                            print(e?.id.toString());
                          },
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          );
        },
        error: (err, stack) => Text('Error: $err'),
        loading: () => const CircularProgressIndicator(),
      ),
    );
  }
}
