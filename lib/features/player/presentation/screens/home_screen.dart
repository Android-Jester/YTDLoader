import 'package:down_yt/features/player/presentation/bloc/search/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String id = 'Home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<SearchBloc>().add(CallInitialFeed());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: RichText(
            textDirection: TextDirection.ltr,
            text: TextSpan(children: [
              TextSpan(
                text: 'Down',
                style: Theme.of(context).textTheme.headline5?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              TextSpan(
                text: 'YT',
                style: Theme.of(context).textTheme.headline5?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ),
            ]),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          child: BlocConsumer<SearchBloc, SearchState>(
            builder: (ctx, data) {
              if (data is InitialFeedState) {
                return ListView(
                  children: data.info
                      .map<Widget>(
                        (videoData) => Card(
                          shape: const RoundedRectangleBorder(),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    image: DecorationImage(
                                      image: NetworkImage(''),
                                    )),
                                child: Image.network(
                                  (videoData.video?.thumbnailUrl)!,
                                  height: 200,
                                  errorBuilder: (ctx, data, err) {
                                    return const SizedBox(
                                      height: 200,
                                      child: Icon(
                                        Icons.error,
                                        size: 50,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Text(
                                (videoData.video?.title)!,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              Text(
                                (videoData.video?.channelAuthor)!,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                );
              } else if (data is SearchLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return const Text('Failed');
              }
            },
            listener: (ctx, state) {},
          ),
        ));
  }
}
