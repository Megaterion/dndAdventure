import 'package:dnd_adventure/domain/providers/nakama_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Providers {
  static final ref = ProviderContainer();

  static final nakamaProvider = ChangeNotifierProvider((_) => NakamaProvider());
}
