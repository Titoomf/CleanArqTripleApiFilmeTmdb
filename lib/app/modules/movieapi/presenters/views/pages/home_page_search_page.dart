import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../domain/entities/results_search_entity.dart';
import '../../../errors/erros.dart';
import '../../triple/state/home_page_state.dart';
import '../../triple/store/home_page_store.dart';
import 'components/custom_app_bar.dart';
import 'components/custom_card.dart';
import 'components/custom_list_categories.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homePageStore = Modular.get<HomePageStore>();

  final TextEditingController _movieTitleTextController =
      TextEditingController();

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(
      () {
        final currentScroll = _scrollController.position.pixels;
        final maxScroll = _scrollController.position.maxScrollExtent;

        if (currentScroll >= maxScroll) {
          homePageStore.getNextPage(_movieTitleTextController.text);
        }
      },
    );
  }

// TODO: dispose do scrollController (listener)
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff171A31),
        appBar: CustomAppBar(
          movieTitleController: _movieTitleTextController,
          onSubmitInput: (movieTitle) {
            homePageStore.getMoviesText(movieTitle);
          },
        ),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: CustomListCategories(),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ScopedBuilder<HomePageStore, SearchMoviesException,
                  HomePageState>(
                store: homePageStore,
                onLoading: (_) =>
                    const Center(child: CircularProgressIndicator()),
                onState: (context, HomePageState state) {
                  late List<ResultSearchEntity> fetchedList;

                  fetchedList = state.resultSearchList;
                  // se a lista de filme filtrados estiver vazia, ultiliza o resultSearch
                  if (state.filteredCategoryResultSearchList.isNotEmpty) {
                    fetchedList = state.filteredCategoryResultSearchList;
                  }
                  if (fetchedList.isEmpty) {
                    return const Center(
                      child: Text(
                        "Ops, nao encontramos nenhum resultado",
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: fetchedList.length,
                    controller: _scrollController,
                    itemBuilder: (context, index) {
                      final item = fetchedList[index];

                      return CustomTitleCards(
                        height: 140,
                        width: 264,
                        image: item.movieImage,
                        title: item.movieTitle,
                        accent: item.movieAccent,
                        rating: item.movieRating,
                      );
                    },
                  );
                },
              ),
            ),
            homePageStore.isLoading
                ? Expanded(
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: Colors.black54,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      ],
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
