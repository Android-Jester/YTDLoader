import 'package:down_yt/features/player/presentation/bloc/search/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> with SingleTickerProviderStateMixin {
  final TextEditingController searchController = TextEditingController();
  bool clicked = false;
  late FocusNode node;

  @override
  void initState() {
    node = FocusNode();
    clicked = false;
    super.initState();
  }

  void onSubmit(String query) {
    context.read<SearchBloc>().add(SearchingVideos(query));
    node.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchBloc, SearchState>(
        child: Container(
          height: 50,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            border: Border.all(
              width: 1.5,
              color: Colors.blue,
            ),
          ),
          child: TextField(
            focusNode: node,
            // onChanged: onSubmit,
            onEditingComplete: () => onSubmit(searchController.text),
            controller: searchController,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              alignLabelWithHint: true,
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              suffix: IconButton(
                onPressed: () => onSubmit(searchController.text),
                icon: const Icon(Icons.search),
              ),
            ),
          ),
        ),
        listener: (ctx, state) {
          if (state is SearchInitial) {
            searchController.clear();
          }
        });
  }
}
