import 'package:flutter/material.dart';
import 'package:flutter_grocery_app/features/UI/wishlist.dart';


import 'package:flutter_grocery_app/widgets/product_tile_widget.dart';

import '../home/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cart.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Cart()));
        } else if (state is HomeNavigateToWishListPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => WishList()));
        }else if (state is HomeWishListedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Wishlist added')));
        }else if (state is HomeCartItemListedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('CartItem added')));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text('Fruityyyyy app'),
                actions: [
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeWishlistButtonNavigateEvent());
                      },
                      icon: Icon(Icons.favorite_rounded)),
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeCartButtonNavigateEvent());
                      },
                      icon: Icon(Icons.shopping_cart)),
                ],
              ),
              body: ListView.builder(
                  itemCount: successState.products.length,
                  itemBuilder: (context, index) {
                    return ProductTileWidget(
                      homeBloc: homeBloc,
                      productDataModel: successState.products[index],
                    );
                  }),
            );
          case HomeErrorState:
            return Scaffold(
              body: Center(
                child: Text('Error Occured'),
              ),
            );
          default:
            return SizedBox();
        }
      },
    );
  }
}
