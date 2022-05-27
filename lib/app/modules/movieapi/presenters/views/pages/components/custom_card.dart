import 'package:flutter/material.dart';

class CustomTitleCards extends StatefulWidget {
  final String title;
  final String accent;
  final String image;
  final double rating;
  final double width;
  final double height;
  final void Function()? onTap;
  final void Function()? favoriteButton;
  final IconData? favoriteIcon;

  const CustomTitleCards({
    Key? key,
    required this.width,
    required this.height,
    this.onTap,
    this.favoriteButton,
    this.favoriteIcon,
    required this.accent,
    required this.image,
    required this.rating,
    required this.title,
  }) : super(key: key);

  @override
  State<CustomTitleCards> createState() => _CustomTitleCardsState();
}

class _CustomTitleCardsState extends State<CustomTitleCards> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: widget.width,
        height: widget.height,
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          color: Color(0xff0F1122),
        ),
        child: LayoutBuilder(builder: (context, constraints) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: constraints.maxWidth * 0.26,
                height: constraints.minHeight,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16)),
                  image: DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: NetworkImage(
                        "https://image.tmdb.org/t/p/original/${widget.image}"),
                  ),
                ),
              ),
              Container(
                width: constraints.maxWidth * 0.50,
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Accent: ${widget.accent}",
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isFavorite = !_isFavorite;
                        });
                      },
                      child: Icon(
                        _isFavorite == false
                            ? Icons.favorite_border_outlined
                            : Icons.favorite,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: constraints.maxWidth * 0.15,
                      height: constraints.maxHeight * 0.23,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                        color: Colors.amber,
                      ),
                      child: Text("${widget.rating}"),
                    )
                  ],
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
