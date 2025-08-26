import 'package:currency_rate_calculator/bloc/convert_bloc/convert_bloc.dart';
import 'package:currency_rate_calculator/firebase_options.dart';
import 'package:currency_rate_calculator/bloc/json_parsing/parsing_cubit.dart';
import 'package:currency_rate_calculator/data/models/currency_model.dart';
import 'package:currency_rate_calculator/data/models/currency_pair_model.dart';
import 'package:currency_rate_calculator/data/models/responce_model.dart';
import 'package:currency_rate_calculator/domain/repository/currency_repo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

import 'presentation/screens/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    await Hive.initFlutter();

if (!Hive.isAdapterRegistered(0)) {
  Hive.registerAdapter(CurrencyPairAdapter());
}
if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(CurrencyAdapter());
  }
  if (!Hive.isAdapterRegistered(2)) {
    Hive.registerAdapter(ResponseModelAdapter());
  }

  await Hive.openBox<CurrencyPair>('recent_pairs');
  runApp(const CurrencyApp());
}

class CurrencyApp extends StatelessWidget {
  const CurrencyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ConvertBloc(CurrencyRepository())),
        BlocProvider(create: (_) => ParsingCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Currency Rate Calculator',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.light,
        home: SplashScreen(),
      ),
    );
  }
}
