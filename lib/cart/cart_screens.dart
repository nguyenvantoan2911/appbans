import 'package:app/cart/bloc/cart_cubit.dart';
import 'package:app/cart/state/cart_state.dart';
import 'package:app/provider/dark_theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartCubit = context.watch<CartCubit>();
    final cartItems = cartCubit.state;
    final themeData = Provider.of<DarkThemeProvider>(context);
    final themeStates = themeData.getDarkTheme;
    var use = context.read<CartCubit>();
    if (cartItems.items.isEmpty) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 200,
                width: 200,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/offres/ofres/box.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'The product has not been added \nto the cart',
                style: TextStyle(
                  fontSize: 20,
                  color: themeStates ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          return Material(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Flexible(
                    flex: 5,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const Divider(
                        height: 1.3,
                        color: Colors.grey,
                      ),
                      itemCount: cartItems.items.length,
                      itemBuilder: (context, index) {
                        final product = cartItems.items[index];

                        return Stack(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Container(
                                    width: 20.3,
                                    height: 20.3,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                    ),
                                    child: Checkbox(
                                      activeColor: Colors.white,
                                      checkColor: Colors.black,
                                      value: product.isSelected,
                                      onChanged: (value) {
                                        use.checkBox(product);
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Container(
                                  height: 120,
                                  width: 96,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: AssetImage(product.image),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.name,
                                      style: const TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      'Giá: ${product.gia}đ',
                                      style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 17,
                                    ),
                                    Row(
                                      children: [
                                        _quantity(
                                          color: Colors.cyan,
                                          onTap: () {
                                            context
                                                .read<CartCubit>()
                                                .reduced(product);
                                          },
                                          icon: CupertinoIcons.minus,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Text(
                                            '${product.count}',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ),
                                        _quantity(
                                          color: const Color.fromARGB(
                                              255, 124, 227, 56),
                                          onTap: () {
                                            context
                                                .read<CartCubit>()
                                                .increase(product);
                                          },
                                          icon: CupertinoIcons.plus,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Positioned(
                              right: 15,
                              top: 70,
                              child: Text(
                                'Total amount:\n=> ${product.count * int.parse(product.gia)}đ',
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                            Positioned(
                              top: 10,
                              right: 5,
                              child: InkWell(
                                onTap: () {
                                  cartCubit.clearToCart(product);
                                },
                                child: const Icon(
                                  Icons.close_sharp,
                                  color: Color.fromARGB(255, 173, 113, 208),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Column(
                      children: [
                        const Divider(
                          color: Color.fromARGB(255, 10, 61, 243),
                          thickness: 1,
                          height: 0,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Container(
                                  height: 40,
                                  width: 30,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/landing/voucher-removebg-preview.png'),
                                    ),
                                  ),
                                ),
                              ),
                              const Text(
                                'Shop Voucher',
                                style: TextStyle(
                                    fontSize: 16.7,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              const SizedBox(
                                width: 50,
                              ),
                              const Text(
                                'Select or enter the code',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 15,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          color: Colors.black,
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Container(
                                  width: 20.3,
                                  height: 20.3,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                  ),
                                  child: Checkbox(
                                      activeColor: Colors.white,
                                      checkColor: Colors.black,
                                      value: state.isSelectAll,
                                      onChanged: (value) {
                                        use.checkBoxAll(value!);
                                      }),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                'All products',
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                'Total payment:\n=>${state.totalPayment}đ',
                                style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Container(
                                width: 100,
                                height: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.amber[900]),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Center(
                                    child: Text(
                                      ' Buy\n Now(${state.quantityCheckbox})',
                                      style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  Widget _quantity({
    required Color color,
    required VoidCallback onTap,
    required IconData icon,
  }) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(1.5),
          child: Icon(icon),
        ),
      ),
    );
  }
}
