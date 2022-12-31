import 'package:down_yt/app/dependency/injector.dart';
import 'package:down_yt/app/view/routes.dart';
import 'package:down_yt/app/view/themes.dart';
import 'package:down_yt/features/player/presentation/bloc/player/player_bloc.dart';
import 'package:down_yt/features/player/presentation/bloc/search/search_bloc.dart';
import 'package:down_yt/features/player/presentation/screens/home_screen.dart';
import 'package:down_yt/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    // final colorGen = coloring.Hct.fromInt(0xFF2485F4);
    return MultiBlocProvider(
      providers: [
        BlocProvider<PlayerBloc>(
          create: (_) => locator.get<PlayerBloc>(),
        ),
        BlocProvider<SearchBloc>(
          create: (_) => locator.get<SearchBloc>(),
        ),
        // BlocProvider<DownloaderBloc>(
        //   create: (_) => locator.get<DownloaderBloc>(),
        // ),
      ],
      child: MaterialApp(
        theme: Themes.lightTheme(),
        darkTheme: Themes.darkTheme(),
        routes: routes,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const HomeScreen(),
      ),
    );
  }
}
