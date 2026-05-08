import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'package:motion_tab_bar_v2/motion-tab-controller.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../state/home_providers.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with SingleTickerProviderStateMixin {
  MotionTabBarController? _motionTabBarController;
  late final List<Widget> _iconWidgets;

  @override
  void initState() {
    super.initState();
    _motionTabBarController = MotionTabBarController(
      initialIndex: 0,
      length: 4,
      vsync: this,
    );

    _iconWidgets = const [
      'assets/bottomnav/Group.png', // home
      'assets/bottomnav/user (1).png', // profile
      'assets/bottomnav/Vector.png', // fav
      'assets/bottomnav/Vector (1).png', // cart
    ]
        .asMap()
        .entries
        .map(
          (e) => _NavAssetIcon(
            controller: _motionTabBarController!,
            tabIndex: e.key,
            asset: e.value,
          ),
        )
        .toList(growable: false);
  }

  @override
  void dispose() {
    _motionTabBarController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _motionTabBarController,
        children: const [
          _HomeTabContent(),
          _PlaceholderTab(title: 'Profile'),
          _PlaceholderTab(title: 'Favourites'),
          _PlaceholderTab(title: 'Cart'),
        ],
      ),
      bottomNavigationBar: MotionTabBar(
        controller: _motionTabBarController,
        initialSelectedTab: 'Home',
        labels: const ['Home', 'Profile', 'Fav', 'Cart'],
        iconWidgets: _iconWidgets,
        useSafeArea: true,
        labelAlwaysVisible: true,
        tabBarHeight: 64,
        tabSize: 52,
        tabBarColor: scheme.surface,
        tabSelectedColor: scheme.primary,
        tabIconColor: scheme.onSurfaceVariant,
        tabIconSelectedColor: scheme.onPrimary,
        textStyle:
            AppTextStyles.labelMedium12.copyWith(color: scheme.onSurface),
        onTabItemSelected: (int value) {
          // Keep MotionTabBarController as the single source of truth.
          _motionTabBarController?.index = value;
        },
      ),
    );
  }
}

class _NavAssetIcon extends StatelessWidget {
  const _NavAssetIcon({
    required this.controller,
    required this.tabIndex,
    required this.asset,
  });

  final MotionTabBarController controller;
  final int tabIndex;
  final String asset;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final isSelected = controller.index == tabIndex;
        final color = isSelected ? scheme.onPrimary : scheme.onSurfaceVariant;
        return Image.asset(
          asset,
          width: 26,
          height: 26,
          fit: BoxFit.contain,
          color: color,
          colorBlendMode: BlendMode.srcIn,
        );
      },
    );
  }
}

class _PlaceholderTab extends StatelessWidget {
  const _PlaceholderTab({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SafeArea(
      child: Center(
        child: Text(
          title,
          style:
              AppTextStyles.titleSemiBold20.copyWith(color: scheme.onSurface),
        ),
      ),
    );
  }
}

class _HomeTabContent extends ConsumerWidget {
  const _HomeTabContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final categories = ref.watch(homeCategoriesProvider);
    final products = ref.watch(featuredProductsProvider);

    return SafeArea(
      bottom: false,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 14),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search keywords..',
                        prefixIcon: Icon(
                          Icons.search,
                          color: scheme.onSurfaceVariant,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.tune,
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _BannerCard(
                imageAsset: 'assets/bannerimage.png',
                title: '20% off on your\nfirst purchase',
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 18, 16, 10),
              child: _SectionHeader(
                title: 'Categories',
                onTap: () {},
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 92,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final c = categories[index];
                  return _CategoryItem(
                    label: c.label,
                    iconAsset: c.iconAsset,
                    onTap: () {},
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(width: 18),
                itemCount: categories.length,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 18, 16, 10),
              child: _SectionHeader(
                title: 'Featured products',
                onTap: () {},
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            sliver: SliverGrid.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.78,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final p = products[index];
                return _ProductCard(product: p);
              },
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 90)),
        ],
      ),
    );
  }
}

class _BannerCard extends StatelessWidget {
  const _BannerCard({
    required this.imageAsset,
    required this.title,
  });

  final String imageAsset;
  final String title;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: AspectRatio(
        aspectRatio: 16 / 7,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(imageAsset, fit: BoxFit.cover),
            Positioned(
              left: 16,
              top: 18,
              child: Text(
                title,
                style: AppTextStyles.titleSemiBold20.copyWith(
                  color: scheme.onSurface,
                  height: 1.15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.onTap,
  });

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: AppTextStyles.titleSemiBold20.copyWith(
              color: scheme.onSurface,
            ),
          ),
        ),
        IconButton(
          onPressed: onTap,
          icon: const Icon(Icons.chevron_right),
          color: scheme.onSurfaceVariant,
        ),
      ],
    );
  }
}

class _CategoryItem extends StatelessWidget {
  const _CategoryItem({
    required this.label,
    required this.iconAsset,
    required this.onTap,
  });

  final String label;
  final String iconAsset;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final bg = scheme.surfaceContainerLow;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: bg,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Image.asset(
              iconAsset,
              width: 26,
              height: 26,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: AppTextStyles.paragraphMedium12.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductCard extends ConsumerWidget {
  const _ProductCard({required this.product});

  final FeaturedProduct product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final cart = ref.watch(cartProvider);
    final qty = cart[product.id] ?? 0;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: scheme.outlineVariant),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 10,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 18, 10, 6),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Image.asset(product.imageAsset),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    top: 10,
                    child: Icon(
                      Icons.favorite_border,
                      size: 20,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                  if ((product.badge ?? '').isNotEmpty)
                    Positioned(
                      left: 10,
                      top: 10,
                      child: _Badge(text: product.badge!),
                    )
                  else if ((product.discountText ?? '').isNotEmpty)
                    Positioned(
                      left: 10,
                      top: 10,
                      child: _Discount(text: product.discountText!),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 6, 12, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: AppTextStyles.titleSemiBold15.copyWith(
                      color: AppColors.primaryDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.titleSemiBold15.copyWith(
                      color: scheme.onSurface,
                    ),
                  ),
                  Text(
                    product.subtitle,
                    style: AppTextStyles.paragraphMedium12.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (qty <= 0)
                    _AddToCartButton(
                      onTap: () =>
                          ref.read(cartProvider.notifier).add(product.id),
                    )
                  else
                    _QtyStepper(
                      qty: qty,
                      onMinus: () =>
                          ref.read(cartProvider.notifier).decrement(product.id),
                      onPlus: () =>
                          ref.read(cartProvider.notifier).increment(product.id),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF4CC),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: AppTextStyles.paragraphMedium10.copyWith(
          color: const Color(0xFFB58B00),
          height: 1.0,
        ),
      ),
    );
  }
}

class _Discount extends StatelessWidget {
  const _Discount({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFFFE5E5),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: AppTextStyles.paragraphMedium10.copyWith(
          color: const Color(0xFFCC2F2F),
          height: 1.0,
        ),
      ),
    );
  }
}

class _AddToCartButton extends StatelessWidget {
  const _AddToCartButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 38,
        decoration: BoxDecoration(
          color: scheme.surfaceContainer,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: scheme.outlineVariant),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_bag_outlined,
                size: 18, color: AppColors.primaryDark),
            const SizedBox(width: 8),
            Text(
              'Add to cart',
              style: AppTextStyles.labelMedium12.copyWith(
                color: scheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QtyStepper extends StatelessWidget {
  const _QtyStepper({
    required this.qty,
    required this.onMinus,
    required this.onPlus,
  });

  final int qty;
  final VoidCallback onMinus;
  final VoidCallback onPlus;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: 38,
      child: Row(
        children: [
          _StepBtn(icon: Icons.remove, onTap: onMinus),
          Expanded(
            child: Center(
              child: Text(
                '$qty',
                style: AppTextStyles.titleSemiBold15.copyWith(
                  color: scheme.onSurface,
                ),
              ),
            ),
          ),
          _StepBtn(icon: Icons.add, onTap: onPlus),
        ],
      ),
    );
  }
}

class _StepBtn extends StatelessWidget {
  const _StepBtn({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: scheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: scheme.outlineVariant),
        ),
        child: Icon(icon, color: AppColors.primaryDark, size: 18),
      ),
    );
  }
}
