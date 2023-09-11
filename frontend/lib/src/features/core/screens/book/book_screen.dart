import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/src/common_widgets/app_bar/app_bar.dart';
import 'package:frontend/src/constants/text_strings.dart';
import 'package:frontend/src/features/core/models/book_category_model.dart';
import 'package:frontend/src/features/core/models/book_model.dart';
import 'package:frontend/src/features/core/screens/book/widgets/book_categoriy_list.dart';
import 'package:frontend/src/features/core/screens/book/widgets/book_category.dart';
import 'package:frontend/src/features/core/screens/book/widgets/custom_serach_bar.dart';
import 'package:frontend/src/features/core/screens/book/widgets/recent_book_card_widgets.dart';
import 'package:frontend/src/providers/providers.dart';

class BookScreen extends ConsumerWidget {
  const BookScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booksState = ref.watch(booksProvider);
    final categoryState = ref.watch(bookCategoryProvider);

    // if (categoryState.categories.isEmpty || booksState.books.isEmpty) {
    //   print("The categories or books are empty");
    // }
    if (categoryState.categories.isEmpty) {
      // Fetch categoriess if they are empty
      ref.watch(bookCategoryProvider.notifier).fetchCategories();
      return _buildLoadingIndicator();
    }
    if (booksState.books.isEmpty) {
      // Fetch  books if they are empty
      ref.watch(booksProvider.notifier).getBookss();
      return _buildLoadingIndicator();
    }

    return Scaffold(
      appBar: appBar(cBook, context),
      body: _buildBody(booksState.books, categoryState.categories),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildBody(List<Book> books, List<CategoryModel> categories) {
    return RefreshIndicator(
      onRefresh: () => _refresh(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const CustomeSearchBar(),
            BookCategories(bookCategories: books),
            const SizedBox(height: 20.0),
            _buildSectionTitle(cCategories),
            const SizedBox(height: 10.0),
            _buildBookCategories(categories),
            const SizedBox(height: 20.0),
            _buildSectionTitle(cRecentlyAdded),
            const SizedBox(height: 20.0),
            _buildRecentBooks(books),
          ],
        ),
      ),
    );
  }

  Future<void> _refresh() async {
    // Implement your refresh logic here
  }

  Widget _buildBookCategories(List<CategoryModel> categories) {
    // Implement how you want to display the book categories here
    // Example: return a ListView of category chips or a horizontal scrollable list
    return BookCategoryList(categories: categories);
  }

  Widget _buildSectionTitle(String title) {
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

  Widget _buildRecentBooks(List<Book> books) {
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
