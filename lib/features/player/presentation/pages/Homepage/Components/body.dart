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
  Widget build(BuildContext context) {
    return BlocConsumer<SearchBloc, SearchState>(
      builder: (context, state) {
        return SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8).copyWith(top: 24, bottom: 5),
                child: const SearchBar(),
              ),
              const SizedBox(
                height: 15,
              ),
              // ignore: prefer_if_elements_to_conditional_expressions
              (state is SearchInitial)
                  ? Expanded(
                      child: VideoList(
                        info: state.info,
                      ),
                    )
                  : const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
            ],
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
