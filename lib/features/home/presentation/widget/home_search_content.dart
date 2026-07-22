import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/core/ApiService/api_services.dart';
import 'package:marketi/core/common/widget/custom_appbar.dart';
import 'package:marketi/core/common/widget/custom_circle_avatar.dart';
import 'package:marketi/core/constants/search_type_enum.dart';
import 'package:marketi/features/home/data/data_source/product_remote_datesourse.dart';
import 'package:marketi/features/home/data/repositories/podust_repository_impl.dart';
import 'package:marketi/features/home/domain/usecases/product_usercase.dart';
import 'package:marketi/features/home/presentation/cubit/product_cubit/product_cubit.dart';
import 'package:marketi/features/home/presentation/widget/search_body_content.dart';
import 'package:marketi/features/home/presentation/widget/search_form.dart';

class HomeSearchContent extends StatefulWidget {
  final SearchType searchType;

  const HomeSearchContent({
    super.key,
    this.searchType = SearchType.general, // القيمة الافتراضية بحث عام
  });

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
    )..getProducts(searchType: widget.searchType); // تمرير نوع البحث للكيوبيت
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
            const SizedBox(height: 10),
            CustomAppbar(
              icon: Icons.arrow_back_ios_new,
              text:  _getTitle( widget.searchType),
              ontap: () => Navigator.pop(context),
              customCircleAvatar: const CustomCircleAvatar(
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
                  data: Theme.of(
                    context,
                  ).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    tilePadding: EdgeInsets.zero,
                    childrenPadding: EdgeInsets.zero,
                    minTileHeight: 0,
                    initiallyExpanded: true,
                    // تغيير العنوان ديناميكياً حسب نوع البحث
                    title: Text(_getTitle(widget.searchType)),
                    children: [
                      SearchBodyContent(
                        searchController: searchController,
                        searchType:
                            widget.searchType, // تمرير نوع البحث الذي استقبلناه
                      ),
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

  /// دالة بسيطة لتحديد عنوان القسم
  String _getTitle(SearchType type) {
    switch (type) {
      case SearchType.popular:
        return 'Popular Products';
      case SearchType.best:
        return 'Best for you';
      case SearchType.buyAgain:
        return 'Buy Again';
      case SearchType.general:
      default:
        return 'Search Products';
    }
  }
}
