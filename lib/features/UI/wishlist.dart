import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_grocery_app/features/wishlist/wishList_bloc.dart';

import '../../widgets/wishList_tile_widgets.dart';


class WishList extends StatefulWidget {
  const WishList({Key? key}) : super(key: key);

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {

  final WishBloc wishBloc = WishBloc();

  @override
  void initState() {
    wishBloc.add(WishListInitialEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist Items'),
      ),
      body: BlocConsumer<WishBloc, WishListState>(
        bloc: wishBloc,
        listenWhen: (previous, current) => current is WishListActionState,
        buildWhen: (previous, current) => current is !WishListActionState,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case WishListSuccessState:
              final successState = state as WishListSuccessState;
              return ListView.builder(
                  itemCount: successState.wishListItems.length,
                  itemBuilder: (context, index) {
                    return WishListTileWidget(
                      wishBloc:wishBloc,
                      productDataModel: successState.wishListItems[index],
                    );
                  });

          }
          return Container();
        },
      ),
    );
  }
}
