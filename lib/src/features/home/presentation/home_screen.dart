import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../characters/data/character_repository.dart';
import '../../characters/presentation/characters_listview.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    print('rendereD');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text("homescreen"),
      ),
      body: Center(
        child: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: () async {
            print('refresh here');
            await Future.delayed(const Duration(seconds: 3));

            ref.refresh(charactersProvider);
            ref.read(charactersProvider.future);
          },
          child: CharactersListview(),
        ),
      ),
    );
  }
}
