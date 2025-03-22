import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_pilot/i18n/strings.g.dart';

final translationsPod = StateProvider<Translations>(
  (ref) => throw UnimplementedError(
    "translations not overriden yet",
  ),
  name: 'translationsProvider',
);
