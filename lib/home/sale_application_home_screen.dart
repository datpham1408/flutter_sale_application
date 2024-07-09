import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sale_application/entity/market_food_entity.dart';
import 'package:flutter_sale_application/entity/user_entity.dart';
import 'package:flutter_sale_application/home/sale_application_cubit.dart';
import 'package:flutter_sale_application/home/sale_application_state.dart';
import 'package:flutter_sale_application/main.dart';
import 'package:flutter_sale_application/resources/images.dart';
import 'package:flutter_sale_application/resources/string.dart';
import 'package:flutter_sale_application/resources/utils.dart';
import 'package:flutter_sale_application/router/route_constant.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../entity/food_entity.dart';

class SaleApplicationHomeScreen extends StatefulWidget {
  final UserEntity? userEntity;

  const SaleApplicationHomeScreen({super.key,  this.userEntity});

  @override
  State<SaleApplicationHomeScreen> createState() =>
      _SaleApplicationHomeScreenState();
}

class _SaleApplicationHomeScreenState extends State<SaleApplicationHomeScreen> {
  final SaleApplicationCubit _saleApplicationCubit =
      getIt.get<SaleApplicationCubit>();
  late List<FoodEntity> listEntity;
  List<MarketFoodEntity>? listMarketEntity;
  String? title;
  UserEntity userEntity = UserEntity();
  String? loai;
  GoogleMapController? _mapController;
  LatLng initialCameraPosition = LatLng(0, 0);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _saleApplicationCubit.getMarketFood();
      _saleApplicationCubit.getDataUser(widget.userEntity?.email);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: BlocProvider<SaleApplicationCubit>(
        create: (_) => _saleApplicationCubit,
        child: BlocConsumer<SaleApplicationCubit, SaleApplicationState>(
          listener: (_, SaleApplicationState state) {
            _handleListener(state);
          },
          builder: (_, SaleApplicationState state) {
            return SingleChildScrollView(child: itemBody());
          },
        ),
      ),
    ));
  }

  // void onMapCreated(GoogleMapController controller) {
  //   _mapController = controller;
  // }
  //
  // void showCurrentLocationOnMap(LatLng currentLocation) {
  //   _mapController?.animateCamera(CameraUpdate.newLatLng(currentLocation));
  // }

  Widget addItem() {
    return title == store
        ? GestureDetector(
            onTap: () {
              handleItemClickAddItem();
            },
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                  margin: const EdgeInsets.all(16),
                  height: 40,
                  width: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.orangeAccent),
                  child: Container(
                      margin: const EdgeInsets.only(left: 8),
                      child: const Center(child: Text(addItems)))),
            ),
          )
        : Container();
  }

  Widget itemBody() {
    return Column(
      children: [
        addItem(),
        itemGoods(),
        // BlocBuilder<SaleApplicationCubit, SaleApplicationState>(
        //   builder: (_, SaleApplicationState state) {
        //     return GoogleMap(
        //       onMapCreated: onMapCreated,
        //       initialCameraPosition: CameraPosition(
        //         target: initialCameraPosition,
        //         zoom: 14.0,
        //       ),
        //     );
        //   },
        // ),
      ],
    );
  }

  Widget itemGoods() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        itemDetailGoods(
            title: meat,
            image: imageMeat,
            onTap: () {
              _saleApplicationCubit.getDataFood(meat);
            }),
        itemDetailGoods(
            title: fish,
            image: imageFish,
            onTap: () {
              _saleApplicationCubit.getDataFood(fish);
            }),
        itemDetailGoods(
            title: fruit,
            image: imageFruit,
            onTap: () {
              _saleApplicationCubit.getDataFood(fruit);
            }),
        itemDetailGoods(
            title: vegetable,
            image: imageVegetable,
            onTap: () {
              _saleApplicationCubit.getDataFood(vegetable);
            }),
        itemDetailGoods(
            title: egg,
            image: imageEgg,
            onTap: () {
              _saleApplicationCubit.getDataFood(egg);
            }),
        itemDetailGoods(
            title: spices,
            image: imageSpices,
            onTap: () {
              _saleApplicationCubit.getDataFood(spices);
            }),
        Utils.instance.sizeBoxHeight(50),
        itemMarket(),
        // BlocBuilder<SaleApplicationCubit, SaleApplicationState>(
        //     builder: (_, SaleApplicationState state) {
        //   return ElevatedButton(
        //     onPressed: () {
        //       _saleApplicationCubit.getCurrentLocation();
        //       _saleApplicationCubit.openGoogleMaps();
        //     },
        //     child: Text('Google Map'),
        //   );
        // }),
        ElevatedButton(
          onPressed: () {
            handleClickGoogleMap();
          },
          child: Text('Google Map'),
        )
      ],
    );
  }

  Widget itemMarket() {
    if (title == user) {
      return listMarketEntity?.isNotEmpty == true
          ? GestureDetector(
              onTap: () {
                handleClickBuyFood();
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                margin: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(36),
                    color: Colors.orange),
                child: Row(
                  children: [
                    const Icon(Icons.shopping_cart),
                    Utils.instance.sizeBoxWidth(8),
                    const Text(gioHang),
                    Utils.instance.sizeBoxWidth(16),
                    Text('${listMarketEntity?.length}'),
                  ],
                ),
              ),
            )
          : Container();
    }
    return Container();
  }

  void handleClickBuyFood() {
    GoRouter.of(context).pushNamed(routerNameBuyFood);
  }

  void handleClickGoogleMap() {
    GoRouter.of(context).pushNamed(routerNameGoogleMap);
  }

  void handleItemClickAddItem() {
    GoRouter.of(context).pushNamed(
      routerNameAddItem,
    );
  }

  Future<void> handleClickDetailFood(
      List<FoodEntity> entity, String title, UserEntity userEntity) async {
    await GoRouter.of(context).pushNamed(
      routerNameFoodDetail,
      extra: {'entity': entity, 'title': title, 'user': userEntity},
    );
  }

  Widget itemDetailGoods({String? title, String? image, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: Colors.grey),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(image ?? ''),
            Utils.instance.sizeBoxWidth(16),
            Text(
              title ?? '',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  void _handleListener(SaleApplicationState state) {
    if (state is FoodLoadedState) {
      listEntity = state.entity;
      loai = state.loai;

      handleClickDetailFood(listEntity, loai ?? '', userEntity);
    }
    if (state is MarketFoodState) {
      listMarketEntity = state.entity;
    }
    if (state is GetUser) {
      userEntity = state.entity;
      title = state.entity.selected;
    }
    // if (state is GoogleMapsState) {
    //   final currentLocation = state.currentLocation;
    //   if (currentLocation != null) {
    //     showCurrentLocationOnMap(currentLocation);
    //   } else {
    //     print('Không thể lấy vị trí hiện tại');
    //   }
    // }
  }
}

///Loai mat hang
/// Hai san
/// Rau cu
/// Thuc uong
/// Thuc an nhanh
/// trai cay
/// ...
