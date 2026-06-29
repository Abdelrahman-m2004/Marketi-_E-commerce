import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/core/common/widget/custom_appbar.dart';
import 'package:marketi/core/common/widget/custom_circle_avatar.dart';
import 'package:marketi/core/common/widget/custom_search_text.dart';
import 'package:marketi/core/fonts/AppFonts.dart';
import 'package:marketi/core/service/service_locator.dart';
import 'package:marketi/features/brands/domain/entities/brand_entity.dart';
import 'package:marketi/features/brands/presentation/cubit/brands_cubit.dart';
import 'package:marketi/features/brands/presentation/cubit/brands_state.dart';

class BrandsScreen extends StatelessWidget {
  const BrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<BrandsCubit>(),
      child: const BrandsView(),
    );
  }
}

class BrandsView extends StatefulWidget {
  const BrandsView({super.key});

  @override
  State<BrandsView> createState() => _BrandsViewState();
}

class _BrandsViewState extends State<BrandsView> {
  @override
  void initState() {
    super.initState();
    context.read<BrandsCubit>().fetchBrands();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const CustomAppbar(
                icon: Icons.arrow_back_ios_new,
                text: 'Brands',
                customCircleAvatar: CustomCircleAvatar(
                  imagePath: 'assets/image/image.png',
                ),
              ),
              const SizedBox(height: 20),

              CustomSearchText(text: 'What are you looking for ?'),
              const SizedBox(height: 24),
              Text(
                'All Brands',
                style: AppFonts.headingLarge.copyWith(
                  color: const Color(0xFF001640),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<BrandsCubit, BrandsState>(
                  builder: (context, state) {
                    if (state is BrandsLoading) {
                      return _buildLoadingWidget();
                    } else if (state is BrandsSuccess) {
                      return _buildSuccessWidget(state.brands);
                    } else if (state is BrandsEmpty) {
                      return _buildEmptyWidget();
                    } else if (state is BrandsError) {
                      print("ERROR!! ${state.message}");
                      return _buildErrorWidget(state.message);
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return GridView.builder(
      itemCount: 8,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.2,
      ),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget _buildSuccessWidget(List<BrandEntity> brands) {
    return GridView.builder(
      itemCount: brands.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.1,
      ),
      itemBuilder: (context, index) {
        final brand = brands[index];
        return Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                height: 96,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xffB2CCFF)),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF3F80FF).withValues(alpha: 0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    'https://marketi.newcinderella.online/storage/${brand.image}',
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.broken_image_outlined,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              brand.name,
              style: AppFonts.titleMedium.copyWith(
                color: const Color(0xFF001640),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        );
      },
    );
  }

  Widget _buildEmptyWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inventory_2_outlined,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'No Brands Available',
            style: AppFonts.titleMedium.copyWith(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: Colors.red.shade400),
          const SizedBox(height: 16),
          Text(
            'Failed to load brands',
            style: AppFonts.titleMedium.copyWith(color: Colors.red.shade700),
          ),
        ],
      ),
    );
  }
}
