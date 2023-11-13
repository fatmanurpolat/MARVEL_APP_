import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:staj_projectt/src/routing/app_router.dart';

import '../data/character_repository.dart';

class CharactersListview extends ConsumerWidget {
  // ignore: non_constant_identifier_names

  CharactersListview({Key? key}) : super(key: key);

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final characterRepository = ref.watch(charactersProvider);

    return characterRepository.when(
        data: (marvelResult) {
          return ListView(
            children: marvelResult.data!.results!
                .map(
                  (e) => Card(
                    elevation: 8,
                    clipBehavior: Clip.antiAlias,
                    shadowColor: Colors.red.shade900,
                    shape:  RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(200),
                      ),
                      side: BorderSide(
                        color: Colors.red.shade900,
                        width: 1,
                      ),
                    ),
                    child: ListTile(
                      leading: CachedNetworkImage(
                          imageUrl:
                              "${e?.thumbnail?.path}.${e?.thumbnail?.extension}",
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error)),
                      textColor: const Color.fromARGB(255, 118, 11, 11),
                      title: Text(
                        e?.name ?? "",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.marvel(
                            fontWeight: FontWeight.w900, fontSize: 20),
                      ),
                      onTap: () {
                        Get.toNamed('/detail?id=${e?.id}');
                        // GoRouter.of(context).go('/detail?id=${e?.id}');
                      },
                    ),
                  ),
                )
                .toList(),
          );
        },
        error: (err, stack) => Text('Error: $err'),
        loading: () => const CircularProgressIndicator());
  }
}
