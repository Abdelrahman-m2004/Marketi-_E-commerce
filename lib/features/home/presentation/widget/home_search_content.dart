import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/core/ApiService/api_services.dart';
import 'package:marketi/core/common/widget/custom_appbar.dart';
import 'package:marketi/core/common/widget/custom_circle_avatar.dart';
import 'package:marketi/features/home/data/data_source/product_remote_datesourse.dart';
import 'package:marketi/features/home/data/models/product_model.dart';
import 'package:marketi/features/home/data/repositories/podust_repository_impl.dart';
import 'package:marketi/features/home/domain/usecases/product_usercase.dart';
import 'package:marketi/features/home/presentation/cubit/product_cubit/product_cubit.dart';
import 'package:marketi/features/home/presentation/widget/search_body_content.dart';
import 'package:marketi/features/home/presentation/widget/search_form.dart';

class HomeSearchContent extends StatefulWidget {
  const HomeSearchContent({super.key});

  @override
  State<HomeSearchContent> createState() => _HomeSearchContentState();
}

class _HomeSearchContentState extends State<HomeSearchContent> {
  final TextEditingController searchController = TextEditingController();
  late final ProductCubit _productCubit;

  @override
  void initState() {
    super.initState();
    final api = ApiServices();
    _productCubit = ProductCubit(
      ProductsUseCase(
        ProductRepositoryImpl(
          remoteDatasource: ProductRemoteDatasource(apiServices: api),
        ),
      ),
    )..getProducts();
  }

  @override
  void dispose() {
    searchController.dispose();
    _productCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _productCubit,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 50),
            CustomAppbar(
              icon: Icons.arrow_back_ios_new,
              ontap: () => Navigator.pop(context),
              customCircleAvatar: CustomCircleAvatar(
                imagePath: 'assets/image/avatare.png',
              ),
            ),
            const SizedBox(height: 20),
            SearchForm(
              searchController: searchController,
              onChanged: (value) {
                _productCubit.search(value);
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    tilePadding: EdgeInsets.zero,
                    childrenPadding: EdgeInsets.zero,
                    minTileHeight: 0,
                    initiallyExpanded: true,
                    title: const Text('Popular Products'),
                    children: [
                      SearchBodyContent(searchController: searchController),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

