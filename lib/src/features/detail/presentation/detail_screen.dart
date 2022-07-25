import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../characters/data/character_repository.dart';

class DetailScreen extends ConsumerWidget {
  const DetailScreen({Key? key, required this.characterId}) : super(key: key);

  final int characterId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('$characterId');

    final characterDetailRepository =
        ref.watch(charactersDetailProvider(characterId.toString()));

    var marvelResult;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
          appBar: AppBar(actions: [
            IconButton(
                onPressed: (() {
                  context.go('/');
                }),
                icon: const Icon(Icons.arrow_back))
          ], title: const Text("Character Detail Screen")),
          body: characterDetailRepository.when(
              data: (marvelResult) {
                return ListView(
                  children: marvelResult.data!.results!
                      .map((e) => Card(
                            elevation: 8,
                            clipBehavior: Clip.antiAlias,
                            shadowColor: Colors.red,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              side: BorderSide(
                                color: Colors.red,
                                width: 1,
                              ),
                            ),
                            child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 20,
                                ),
                                leading: CachedNetworkImage(
                                    imageUrl:
                                        "${e?.thumbnail?.path}.${e?.thumbnail?.extension}",
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error)),
                                textColor: Color.fromARGB(255, 118, 11, 11),
                                title: Text(e?.description ?? " "),
                                onTap: () {
                                  print(e?.id.toString());
                                }),
                          ))
                      .toList(),
                );
              },
              error: (err, stack) => Text('Error: $err'),
              loading: () => const CircularProgressIndicator())),
    );
  }
}
