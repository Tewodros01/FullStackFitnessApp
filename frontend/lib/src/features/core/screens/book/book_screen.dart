import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/src/common_widgets/app_bar/app_bar.dart';
import 'package:frontend/src/features/core/models/book_model.dart';
import 'package:frontend/src/features/core/screens/book/widgets/custom_serach_bar.dart';
import 'package:frontend/src/features/core/screens/book/widgets/recent_book_card_widgets.dart';
import 'package:frontend/src/features/core/screens/book/widgets/book_categoriy_list.dart';
import 'package:frontend/src/features/core/screens/book/widgets/book_category.dart';
import 'package:frontend/src/features/core/states/book_state.dart';
import 'package:frontend/src/providers/providers.dart';

class BookScreen extends ConsumerWidget {
  const BookScreen({super.key});
  refresh() {}
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booksState = ref.watch(booksProvider);
    if (booksState.books.isEmpty) {
      ref.watch(booksProvider.notifier).getBookss();
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      appBar: appBar("Books", context),
      body: _buildBodyList(booksState),
    );
  }

  Widget _buildBodyList(BooksState booksState) {
    return RefreshIndicator(
      onRefresh: () {
        return refresh();
      },
      child: SingleChildScrollView(
          child: Column(
        children: [
          const CustomeSearchBar(),
          BookCategories(bookCategories: booksState.books),
          const SizedBox(height: 20.0),
          _buildSectionTitle('Categories'),
          const SizedBox(height: 10.0),
          const BookCategoryList(),
          const SizedBox(height: 20.0),
          _buildSectionTitle('Recently Added'),
          const SizedBox(height: 20.0),
          _buildNewSection(booksState.books),
        ],
      )),
    );
  }

  _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  _buildNewSection(List<Book> books) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ListView.builder(
        primary: false,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: books.length,
        itemBuilder: (BuildContext context, int index) {
          return RecentBookCardWidget(book: books[index]);
        },
      ),
    );
  }
}
