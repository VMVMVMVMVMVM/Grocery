import 'package:flutter/material.dart';
import 'package:flutter_grocery_app/features/home/home_bloc.dart';
import 'package:flutter_grocery_app/features/wishlist/wishList_bloc.dart';
import 'package:flutter_grocery_app/models/home_product.dart';

class WishListTileWidget extends StatelessWidget {
  final ProductDataModel productDataModel;
  final WishBloc wishBloc;

  WishListTileWidget({
    Key? key,
    required this.productDataModel,
    required this.wishBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.maxFinite,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: NetworkImage(productDataModel.imageUrl),
            )),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            productDataModel.name,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(productDataModel.description),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$' + productDataModel.price.toString(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  // IconButton(
                  //     onPressed: () {
                  //       homeBloc.add(HomeProductWishlistButtonClickedEvent(
                  //           clickedProduct: productDataModel));
                  //     },
                  //     icon: Icon(
                  //       Icons.favorite_border,
                  //     )),
                  IconButton(
                      onPressed: () {
                        wishBloc.add(WishListRemoveFromWishListItemEvent(
                            productDataModel: productDataModel));
                      },
                      icon: Icon(
                        Icons.delete,
                      )),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
