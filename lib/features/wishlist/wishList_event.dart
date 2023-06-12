part of 'wishList_bloc.dart';

@immutable
abstract class WishListEvent {}

class WishListInitialEvent extends WishListEvent {}


class WishListRemoveFromWishListItemEvent extends WishListEvent {

  final ProductDataModel productDataModel;

  WishListRemoveFromWishListItemEvent({required this.productDataModel});
}