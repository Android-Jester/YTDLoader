part of '../homepage.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late FocusNode node;
  @override
  void initState() {
    node = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is StateStarted) {
            return const StartSearching();
          } else if (state is SearchInitial) {
            return SearchResults(
              info: state.info,
            );
          } else if (state is SearchLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Container();
          }
        },
        listener: (ctx, state) {
          if (state is SearchFailed) {
            showDialog<Dialog>(
                context: ctx,
                builder: (_) {
                  return Dialog();
                });
          }
        },
      ),
    );
  }
}
