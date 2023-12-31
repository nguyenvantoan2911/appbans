import 'package:app/cart/bloc/cart_cubit.dart';
import 'package:app/cart/state/products_state.dart';
import 'package:app/provider/dark_theme_provider.dart';
import 'package:app/services/utils.dart';
import 'package:app/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

class NewProduct extends StatefulWidget {
  const NewProduct(
      {super.key,
      required this.images,
      required this.names,
      required this.gia,
      required this.giasoc});
  final String images, names, gia, giasoc;
  @override
  State<NewProduct> createState() => _NewProductState();
}

class _NewProductState extends State<NewProduct> {
  late bool isLiked = false;
  bool isAddedToCart = false;
  void checkIfAddedToCart() {
    final cartCubit = context.read<CartCubit>();
    for (var item in cartCubit.state.items) {
      if (item.name == widget.names) {
        setState(() {
          isAddedToCart = true;
        });
        return;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    checkIfAddedToCart();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Provider.of<DarkThemeProvider>(context);
    final themeStates = themeData.getDarkTheme;
    Utils utils = Utils(context);
    double screenWith = MediaQuery.of(context).size.width;
    Color color = utils.color;
    final themeState = Provider.of<DarkThemeProvider>(context);
    bool isdark = themeState.getDarkTheme;
    final cartCubit = context.watch<CartCubit>();
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              color: Color.fromARGB(255, 244, 224, 164)),
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(12),
            child: Column(
              children: [
                Container(
                  height: screenWith * 0.27,
                  width: screenWith * 0.35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(image: AssetImage(widget.images))),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextWidget(
                        text: widget.names,
                        color: Colors.black,
                        texSize: FontStyle.italic),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (!isAddedToCart) {
                              var productToAdd = ProductsState(
                                image: widget.images,
                                name: widget.names,
                                gia: widget.gia,
                              );
                              cartCubit.addToCart(productToAdd);
                              setState(() {
                                isAddedToCart = true;
                              });
                            }
                          },
                          child: Icon(
                            IconlyLight.bag2,
                            size: 22,
                            color: isAddedToCart ? Colors.red : Colors.black,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isLiked = !isLiked;
                            });
                          },
                          child: Icon(
                            IconlyLight.heart,
                            size: 22,
                            color: isLiked ? Colors.red : Colors.black,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 15),
                  child: Row(
                    children: [
                      TextWidget(
                          text: 'Giá:',
                          color: Colors.black,
                          texSize: FontStyle.normal),
                      const SizedBox(
                        width: 5,
                      ),
                      TextWidget(
                          text: '${widget.giasoc}đ',
                          color: Colors.red,
                          texSize: FontStyle.normal),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        '${widget.gia}đ',
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            decoration: TextDecoration.lineThrough),
                      ),
                    ],
                  ),
                ),
                TextButton(
                    onPressed: () {},
                    child: TextWidget(
                        text: 'Add to card',
                        color: Colors.black,
                        texSize: FontStyle.italic))
              ],
            ),
          ),
        ),
        Positioned(
            top: -10,
            right: -17,
            child: SizedBox(
              height: 80,
              width: 100,
              child: Image.asset(
                  'assets/offres/ofres/tải_xuống-removebg-preview.png'),
            )),
      ],
    );
  }
}
