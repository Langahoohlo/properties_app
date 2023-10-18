import 'package:flutter/material.dart';

class SearchInput extends StatefulWidget {
  final isShowPosts;
  const SearchInput({Key? key, required this.isShowPosts}) : super(key: key);
  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    bool isShowPosts = false;

    @override
    void dispose() {
      super.dispose();
      searchController.dispose();
    }

    return Container(
        padding: const EdgeInsets.all(15),
        child: TextFormField(
            onFieldSubmitted: (String _) {
              setState(() {
                isShowPosts = true;
              });
            },
            controller: searchController,
            decoration: InputDecoration(
              fillColor: const Color.fromARGB(255, 211, 220, 228),
              filled: true,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(8),
              ),
              hintText: 'Search here...',
              prefixIcon: Container(
                padding: const EdgeInsets.all(15),
                child: const Icon(Icons.search),
              ),
              contentPadding: const EdgeInsets.all(2),
            )));
  }
}
