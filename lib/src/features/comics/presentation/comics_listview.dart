import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:staj_projectt/src/features/comics/data/comic_repository.dart';

class ComicsListview extends ConsumerWidget {
  const ComicsListview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final comicRepository = ref.watch(comicProvider);

    return comicRepository.when(
        data: (marvelResult) {
          return ListView(
            children: marvelResult.data.results
                .map((e) => Card(
                    color: Colors.amber, elevation: 4, child: Text(e.title)))
                .toList(),
          );
        },
        error: (err, stack) => Text('Error: $err'),
        loading: () => const CircularProgressIndicator());
  }
}
