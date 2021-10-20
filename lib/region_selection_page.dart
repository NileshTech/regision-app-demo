import 'package:flutter/material.dart';
import 'package:region_app_demo/country_list_page.dart';

class RegionSelectionPage extends StatefulWidget {
  const RegionSelectionPage({Key? key}) : super(key: key);

  @override
  _RegionSelectionPageState createState() => _RegionSelectionPageState();
}

class _RegionSelectionPageState extends State<RegionSelectionPage> {
  bool? isAsiaSelected = false;
  bool? isEuropSelected = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: MaterialButton(
                  child: Text(
                    "Asia",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: isAsiaSelected == true ? Colors.indigo : Colors.blue,
                  onPressed: () {
                    setState(() {
                      isAsiaSelected = true;
                      isEuropSelected = false;
                    });
                    showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        isDismissible: false,
                        context: context,
                        builder: (context) {
                          return CountryListPage(
                            regionName: "asia",
                          );
                        });
                  },
                ),
              ),
              Container(
                child: MaterialButton(
                  child: Text(
                    "Europ",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: isEuropSelected == true ? Colors.indigo : Colors.blue,
                  onPressed: () {
                    setState(() {
                      isEuropSelected = true;
                      isAsiaSelected = false;
                    });
                    showModalBottomSheet(
                        isDismissible: false,
                        context: context,
                        builder: (context) {
                          return CountryListPage(
                            regionName: "europ",
                          );
                        });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
