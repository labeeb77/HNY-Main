import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/data/providers/home_controller.dart';
import 'package:hny_main/view/widgets/app_text_widget.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final homeController = Provider.of<HomeController>(context, listen: false);
      homeController.getCarDataList(context: context);
      homeController.getCarTypeList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        toolbarHeight: 120,
        backgroundColor: AppColors.primary,
        title: Consumer<HomeController>(
          builder: (context, value, child) => TextField(
            onChanged: (query) {
              value.searchFeilds(query);
              value.getCarDataList(
                  context: context, search: query.toLowerCase());
            },
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: 'Search...',
              filled: true,
              fillColor: AppColors.background,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 65,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: rowForDate(date: '12/12/2022', text: 'Start Date'),
                  ),
                ),
                const Gap(20),
                Expanded(
                  child: Container(
                    height: 65,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: rowForDate(date: '12/12/2022', text: 'End Date'),
                  ),
                ),
              ],
            ),
            const Gap(10),
            Expanded(
              child: Consumer<HomeController>(
                builder: (context, value, child) => ListView.builder(
                  itemCount: value.carListData.length,
                  itemBuilder: (context, index) {
                    final data = value.carListData[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SizedBox(
                          height: 165,
                          width: double.infinity,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: double.infinity,
                                  width: 100,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: CachedNetworkImage(
                                          imageUrl: data.strImgUrl ?? '',
                                          placeholder: (context, url) =>
                                              CircularProgressIndicator(), // Optional: Add a loading indicator
                                          errorWidget: (context, url, error) =>
                                              Image(
                                                image: NetworkImage(
                                                    'https://rukminim2.flixcart.com/image/850/1000/xif0q/poster/5/l/b/medium-set-of-3-jdm-cars-wallpaper-printed-on-80-gsm-paper-jdm2-original-imahfeqsqhx2evag.jpeg?q=20&crop=false'),
                                              ))),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Gap(10),
                                      AppText(
                                        data.strModel ?? 'no name',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const Gap(10),
                                      Row(
                                        children: [
                                          AppText(
                                            '${data.intPricePerDay} AED',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.orange,
                                            fontSize: 16,
                                          ),
                                          AppText(
                                            ' / day',
                                            color: Colors.grey,
                                          ),
                                        ],
                                      ),
                                      const Gap(10),
                                      Container(
                                        height: 20,
                                        width: double.infinity, // Dynamic width
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: const Color.fromARGB(
                                              255, 199, 225, 247),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            AppText(
                                              'October 1, 2024',
                                              fontSize: 10,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                            const Icon(Icons.arrow_right_alt),
                                            AppText(
                                              'October 1, 2024',
                                              fontSize: 10,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Gap(5),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        AppColors.primary),
                                                onPressed: () {},
                                                child: AppText(
                                                  'Book Now',
                                                  color: AppColors.background,
                                                )),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget rowForDate({required String text, required String date}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Icon(Icons.calendar_month),
      const Gap(10),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text),
          AppText(
            date,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    ],
  );
}
