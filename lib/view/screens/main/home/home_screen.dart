import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/view/screens/main/home/filter_bottomsheet.dart';
import 'package:hny_main/view/screens/main/home/widgets_elements.dart';
import 'package:hny_main/view/widgets/app_text_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemStatusBarContrastEnforced: false,
        statusBarColor: AppColors.primary, // Match your app bar color
        statusBarIconBrightness:
            Brightness.light, // Adjust icons for visibility
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        actions: [
          CircledIcon(
            circleColor: AppColors.circleAvatarBackground,
            iconColor: AppColors.white,
            badgeValue: "2",
            icon: Icons.notifications_outlined,
          ),
          const Gap(
            12,
          ),
          CircledIcon(
            circleColor: AppColors.circleAvatarBackground,
            iconColor: AppColors.white,
            badgeValue: "2",
            icon: Icons.shopping_cart_outlined,
          ),
          const Gap(
            24,
          ),
        ],
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              "LOCATION",
              fontSize: 12,
              color: AppColors.white,
            ),
            Gap(4),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(0.0),
                  child: Icon(
                    Icons.place,
                    size: 18,
                    color: AppColors.white,
                  ),
                ),
                AppText(
                  "New York, USA",
                  fontSize: 16,
                  color: AppColors.textwhiteSecondary,
                  fontWeight: FontWeight.w500,
                )
              ],
            )
          ],
        ),
        bottom: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height / 13),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        const Icon(CupertinoIcons.search, color: Colors.grey),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search "Tata"',
                              border: InputBorder.none,
                              // hintStyle:
                              //     TextStyle(color: Colors.grey[400]),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.mic, color: Colors.grey),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
                const Gap(9),
                CircledIcon(
                  ontap: () {
                    // log((orientation==Orientation.portrait).toString())''
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      builder: (context) => const PriceRangeBottomSheet(),
                    );
                  },
                  circleColor: AppColors.white,
                  iconColor: AppColors.iconGrey,
                  badgeValue: "1",
                  icon: Icons.filter_alt_outlined,
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 32,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
                color: AppColors.primary,
              ),
            ),
            // Date Selection Section
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        DateSectionWidget(
                            value: 'October 1, 2024',
                            title: "Start Date & Time"),
                        SizedBox(width: 16),
                        DateSectionWidget(
                            value: 'October 4, 2024', title: "End Date"),
                      ],
                    ),
                  ),

                  // Ride Options Section
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Ride options',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // padding: const EdgeInsets.symmetric(horizontal: 0),
                        // scrollDirection: Axis.horizontal,
                        children: [
                          buildRideOption(
                              'https://s3-alpha-sig.figma.com/img/e4d0/548c/989595565347690200de889fc3d9f2f4?Expires=1736726400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=VxX7v-ycet0sjT0ZNhLjf~ZUa~qvP~tyi8tQt~rF6Ye2dtvSKKlem16QqnGrRtsV2rQhwGS-C2Ns~N6J1AJM-oRhSCSMFga5e3PR5ZoSLh0nfUF1EjzwDp3haBgbCplK8hfSSC~ZIkNXXfwNjCkwDa9yn3bi6Ju2FUSS7VHjegBjTTEo47255uFlcTjA09WrExBikC5lto94qP2w1iTvVVrc600EqG0g68S8vOAhisvDc~vKgPyFzd9OomQ8IVXza9y5xFB92A3vbuLDxgC4AvS7XEOa0zni08FXyrUfebTm7xopz03j4T739zYZcRgDqWqT0WuKqzxahqKYqRlKNw__',
                              'Sedans'),
                          buildRideOption(
                              'https://s3-alpha-sig.figma.com/img/5769/bbeb/60e0f438b30252ec8c5d652a4298ab8b?Expires=1736726400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=mFDt55NoobPzswnt4lQWIXq6iG87wSG5CwRMOZWP64krdyAIzbnO4qCH8D2evuCNloTWZvb6kev44nZrKVcwvZIYxRT4a9jcH9uYg~cUO5~FAdgPIFNy49a4JgFcpqwiu1bv0spdv8iRx5dfih46NCDrVPyMGvViqcEGfx4TTOx6Sg6SR-3Docf-uH2P0EELMWcNn1MxzSiBWtd7AH3REAxavEjxuZ~Ah3prBnr8tDA2Cl-aRS~5WscW5Iom7uAy4zixwo3wEIFtQUZEnbaRwcfU7vokrFRignNGula2zmxjppEovIny1nYEanjQnpqGT1QcLz-YWXF9QVwGLPU-MQ__',
                              'SUV'),
                          buildRideOption(
                              'https://s3-alpha-sig.figma.com/img/010a/c95f/3d3365865a1f013fce8ae11a11b9e0a2?Expires=1736726400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=bBtNxMmbX~25C65yhQ2cCJ5RFvng6AqIY1dLIXUU0Z9c7L-oS4EpZROw0mr1YJPJOL356oUVxoPL0mT09N6RfrHCIv5DSVTJUY~k7R9Y63UkQaz7IaeplFyNBhwtWO2xrfVqHUCKyQHvxQHcoSpP0N2~kIQWYlXFETt7jO3S~WwpoYk5496DqfKQJHkmM45aiFUxozaMjNHr7NsT5zrk1AMLeQ-4rNoSind7DRL1glhvFHYIPP8Ir9Tk2avKWd-FaGumIk~GBizUDfibm0rvoohTb18qi5ZDYrS~V6m~sN8pBhId2tUAKGre-T91w-ZLEhLx4EJM9qhD8MqzgbNExQ__',
                              'Trucks'),
                          buildRideOption(
                              'https://s3-alpha-sig.figma.com/img/f8a4/f3c5/83e69979b57cfe7604815616bf3d6a7f?Expires=1736726400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=V51VY6WOQGzB7NbTe~9XmL5iva2wdZlwjSHSkZUNBmuPTkPD6pgNpopL2l3KIhqvfwRKium4zEUkwRMwphbcLDIWzvcyBRjwHpmQLSHSoSknvSpaC-8Si09IX49XVZnYDThXs0fS5mm-04XUwkqjM0hxMDYpUOafdWtzfSozSknq-~qKmBA9u1cbh-bn47Dhza~RNOFG39lP1JdDIR5RDwT-OLyn~2kRXOler91So9FOBw~SmSb-R7MEMpm63FaAeKfm1ZVVwoFCs5OS2P~hkUKM328Mo1i0BbCQPFsed8LduJVraqgcrxPDGWKexGpZ6UogVXMwxQ2ftX1cCOVieg__',
                              'Electric'),
                          buildRideOption('', 'View All'),
                        ],
                      ),
                    ),
                  ),

                  // Popular Cars Section
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Popular Cars',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'See All',
                          style: TextStyle(
                            color: Color(0xFF0B5D3A),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Car Cards
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: OrientationBuilder(
                      builder: (context, orientation) => Column(
                        children: [
                          buildCarCard(
                              'Toyota Corolla',
                              4.8,
                              'Sedans',
                              'Manual',
                              'Petrol',
                              '5 Seats',
                              '7,000',
                              'https://s3-alpha-sig.figma.com/img/ae74/a9e7/f68182d3f5fd6e910be717cb9f8591cb?Expires=1736726400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=K715cm5OI1fJp2z6U3vjW8ZaZKaNFcS7GPY9~L9hP1azK1FH4A7MOZ2eev45S2W3CpedLyJZOypyNlkDXeVc3EvuT2a8GRGzkLc0pcUe41xvBrB9F-ZFLnqzoyQiTdVJYJ9j-B~n6JrR5bzBZFbMCa5gATFUZP9CnNyQKeuj9MhBBsyjKoaPKBHyuxi2ePhS4m22uYirfWWsV9z-9NxPKdE7WAmgb-arXkgjnJHtTHq9-RJ3Z36~kCLcuC8TWfDbbonZZm7FyjD-KrerDgskbpfHRVueRN~DxGrwtG50vzvtHr02YN4pqpjuW3qnx24dGVs2JlYgseMIqUXLiidqdA__',
                              context,
                              orientation,
                              mediaQuery),
                          const SizedBox(height: 16),
                          buildCarCard(
                              'Tesla Model 3',
                              4.8,
                              'Electric',
                              'Automatic',
                              'Electric',
                              '5 Seats',
                              '9,000',
                              'https://s3-alpha-sig.figma.com/img/ae74/a9e7/f68182d3f5fd6e910be717cb9f8591cb?Expires=1736726400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=K715cm5OI1fJp2z6U3vjW8ZaZKaNFcS7GPY9~L9hP1azK1FH4A7MOZ2eev45S2W3CpedLyJZOypyNlkDXeVc3EvuT2a8GRGzkLc0pcUe41xvBrB9F-ZFLnqzoyQiTdVJYJ9j-B~n6JrR5bzBZFbMCa5gATFUZP9CnNyQKeuj9MhBBsyjKoaPKBHyuxi2ePhS4m22uYirfWWsV9z-9NxPKdE7WAmgb-arXkgjnJHtTHq9-RJ3Z36~kCLcuC8TWfDbbonZZm7FyjD-KrerDgskbpfHRVueRN~DxGrwtG50vzvtHr02YN4pqpjuW3qnx24dGVs2JlYgseMIqUXLiidqdA__',
                              context,
                              orientation,
                              mediaQuery),
                          const SizedBox(height: 16),
                          buildCarCard(
                              'Tesla Model 3',
                              4.8,
                              'Electric',
                              'Automatic',
                              'Electric',
                              '5 Seats',
                              '9,000',
                              'https://s3-alpha-sig.figma.com/img/ae74/a9e7/f68182d3f5fd6e910be717cb9f8591cb?Expires=1736726400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=K715cm5OI1fJp2z6U3vjW8ZaZKaNFcS7GPY9~L9hP1azK1FH4A7MOZ2eev45S2W3CpedLyJZOypyNlkDXeVc3EvuT2a8GRGzkLc0pcUe41xvBrB9F-ZFLnqzoyQiTdVJYJ9j-B~n6JrR5bzBZFbMCa5gATFUZP9CnNyQKeuj9MhBBsyjKoaPKBHyuxi2ePhS4m22uYirfWWsV9z-9NxPKdE7WAmgb-arXkgjnJHtTHq9-RJ3Z36~kCLcuC8TWfDbbonZZm7FyjD-KrerDgskbpfHRVueRN~DxGrwtG50vzvtHr02YN4pqpjuW3qnx24dGVs2JlYgseMIqUXLiidqdA__',
                              context,
                              orientation,
                              mediaQuery),
                        ],
                      ),
                    ),
                  ),
                  const Gap(24)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
