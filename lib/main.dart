import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pagination/blox/posts_bloc.dart';
import 'package:flutter_pagination/repository/place_holder_repository.dart';
import 'package:flutter_pagination/screens/home_screen.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider(
          create: (context) => PlaceHolderRepository(client: http.Client()),
        ),
        BlocProvider<PostsBloc>(
          create: (context) => PostsBloc(
              placeHolderRepository: context.read<PlaceHolderRepository>())
            ..add(FirstLoadEvent()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
