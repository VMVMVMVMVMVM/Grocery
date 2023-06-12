part of 'wishList_bloc.dart';

@immutable
abstract class WishListState {}

abstract class WishListActionState extends WishListState {}

class WishListInitial extends WishListState {}

class WishListSuccessState extends WishListState {

  final List<ProductDataModel> wishListItems;

  WishListSuccessState({required this.wishListItems});
}



