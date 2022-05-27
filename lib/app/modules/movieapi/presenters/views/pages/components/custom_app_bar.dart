import 'package:flutter/material.dart';

class CustomAppBar extends PreferredSize {
  final Function(String) onSubmitInput;
  final TextEditingController movieTitleController;

  CustomAppBar({
    Key? key,
    required this.onSubmitInput,
    required this.movieTitleController,
  }) : super(
          key: key,
          preferredSize: const Size.fromHeight(180),
          child: Container(
            padding: const EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Align(
                      child: Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          controller: movieTitleController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Search...',
                            hintStyle: const TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onSubmitted: onSubmitInput,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        onSubmitInput(
                          movieTitleController.text,
                        );
                      },
                      icon: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                    const Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Categories',
                    style: TextStyle(color: Colors.white, fontSize: 31),
                  ),
                ),
                const SizedBox(height: 22),
              ],
            ),
          ),
        );
}
