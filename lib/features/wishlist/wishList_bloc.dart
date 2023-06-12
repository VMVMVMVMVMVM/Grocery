import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_grocery_app/data/wishlist_items.dart';
import 'package:flutter_grocery_app/models/home_product.dart';
import 'package:meta/meta.dart';

part 'wishList_event.dart';
part 'wishList_state.dart';

class WishBloc extends Bloc<WishListEvent, WishListState> {
  WishBloc() : super(WishListInitial()) {
   on<WishListInitialEvent>(wishListInitialEvent);
   on<WishListRemoveFromWishListItemEvent>(wishListRemoveFromWishListItem);
  }

  FutureOr<void> wishListInitialEvent(WishListInitialEvent event, Emitter<WishListState> emit) {
    emit(WishListSuccessState(wishListItems: wishListItems));

  }


  FutureOr<void> wishListRemoveFromWishListItem(WishListRemoveFromWishListItemEvent event, Emitter<WishListState> emit) {
    wishListItems.remove(event.productDataModel);
    emit(WishListSuccessState(wishListItems: wishListItems));

  }
}
