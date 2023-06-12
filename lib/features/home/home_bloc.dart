import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_grocery_app/data/cart_items.dart';
import 'package:flutter_grocery_app/data/model_data.dart';
import 'package:flutter_grocery_app/data/wishlist_items.dart';
import 'package:meta/meta.dart';

import '../../models/home_product.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeProductWishlistButtonClickedEvent>(
        homeProductWishlistButtonClickedEvent);
    on<HomeProductCartButtonClickedEvent>(homeProductCartButtonClickedEvent);
    on<HomeWishlistButtonNavigateEvent>(homeWishlistButtonNavigateEvent);
    on<HomeCartButtonNavigateEvent>(homeCartButtonNavigateEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(Duration(seconds:2));
    emit(HomeLoadedSuccessState(
        products: ModelData.modelProducts.map((e) => ProductDataModel(
              id : e['id'],
              name : e['name'],
              description : e['description'],
              price : e['price'],
              imageUrl : e['imageUrl']
            )).toList()));
  }

  FutureOr<void> homeProductWishlistButtonClickedEvent(
      HomeProductWishlistButtonClickedEvent event, Emitter<HomeState> emit) {
    print('wishlist button clicked');
    wishListItems.add(event.clickedProduct);
    emit(HomeWishListedActionState());
  }

  FutureOr<void> homeProductCartButtonClickedEvent(
      HomeProductCartButtonClickedEvent event, Emitter<HomeState> emit) {
    print('cart button clicked');
    cartItems.add(event.clickedProduct);
    emit(HomeCartItemListedActionState());
  }

  FutureOr<void> homeWishlistButtonNavigateEvent(
      HomeWishlistButtonNavigateEvent event, Emitter<HomeState> emit) {
    print('wishlist navigate clicked');
    emit(HomeNavigateToWishListPageActionState());
  }

  FutureOr<void> homeCartButtonNavigateEvent(
      HomeCartButtonNavigateEvent event, Emitter<HomeState> emit) {
    print('cart navigate clicked');
    emit(HomeNavigateToCartPageActionState());
  }
}
