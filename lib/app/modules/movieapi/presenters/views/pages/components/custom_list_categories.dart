import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../../errors/erros.dart';
import '../../../triple/state/home_page_state.dart';
import '../../../triple/store/home_page_store.dart';

class CustomListCategories extends StatefulWidget {
  const CustomListCategories({Key? key}) : super(key: key);

  @override
  State<CustomListCategories> createState() => _CustomListCategoriesState();
}

class _CustomListCategoriesState extends State<CustomListCategories> {
  final movieCategoriesStore = Modular.get<HomePageStore>();
  final movieCategoriesList = Modular.get<HomePageStore>();

  int currentCategoryIndex = 0;
  @override
  void initState() {
    super.initState();

    movieCategoriesList.getMoviesText('The Batman');
    movieCategoriesStore.getMovieCategories();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: ScopedBuilder<HomePageStore, SearchMoviesException, HomePageState>(
        store: movieCategoriesStore,
        onState: (context, state) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: state.movieCategories.length,
            itemBuilder: (context, index) {
              final result = state.movieCategories[index];

              return GestureDetector(
                onTap: () {
                  setState(() {
                    currentCategoryIndex = index;
                  });

                  movieCategoriesStore.filterMoviesCategory(result.id);
                },
                child: Container(
                  width: 100,
                  height: 31,
                  alignment: Alignment.center,
                  child: Text(
                    result.category,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    color: currentCategoryIndex == index
                        ? const Color(0xff3D57BC)
                        : const Color(0xff12162D),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
