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
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          // border: Border.all(
          //   width: 1.5,
          //   color: Colors.blue,
          // ),
        ),
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 50,
                child: TextField(
                  focusNode: node,
                  // onChanged: onSubmit,
                  onEditingComplete: () => onSubmit(searchController.text),
                  controller: searchController,
                  style: Theme.of(context).textTheme.bodyMedium,
                  // textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            DecoratedBox(
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondaryContainer, borderRadius: BorderRadius.circular(15)),
              child: IconButton(
                onPressed: () => onSubmit(searchController.text),
                icon: Icon(
                  Icons.search,
                  textDirection: TextDirection.ltr,
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
              ),
            ),
          ],
        ),
      ),
      listener: (ctx, state) {},
    );
  }
}
