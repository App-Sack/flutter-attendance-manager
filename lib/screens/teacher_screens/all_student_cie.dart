import 'package:attendance_manager/widgets/cie_tile.dart';
import 'package:attendance_manager/providers/cie.dart';
import 'package:attendance_manager/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CieScreen extends StatefulWidget {
  static const routeName = '/all-cie-screen';

  const CieScreen({Key? key}) : super(key: key);

  @override
  State<CieScreen> createState() => _CieScreenState();
}

class _CieScreenState extends State<CieScreen> {
  List<CIE> cieList = [];

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void initState() {
    cieList = [];
    Future.delayed(Duration.zero, () {
      List args = ModalRoute.of(context)!.settings.arguments as List;
      Provider.of<CieProvider>(context, listen: false)
          .fetchAndSetCieData(args[0], args[1])
          .then((value) {
        cieList = Provider.of<CieProvider>(context, listen: false).CieData;
        setState(() {
          cieList;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int numsub = 0;
    return Scaffold(
      appBar: AppBar(
        title: const Text("CIE"),
        backgroundColor: kBlueColor,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.refresh))
        ],
      ),
      body: cieList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  itemCount: cieList.length,
                  itemBuilder: ((context, index) {
                    return CieTile(
                        name: cieList[index].student_name,
                        usn: cieList[index].usn,
                        e1: cieList[index].e1 == null
                            ? "-"
                            : cieList[index].e1.toString(),
                        e2: cieList[index].e2 == null
                            ? "-"
                            : cieList[index].e2.toString(),
                        e3: cieList[index].e3 == null
                            ? "-"
                            : cieList[index].e3.toString(),
                        e4: cieList[index].e4 == null
                            ? "-"
                            : cieList[index].e4.toString(),
                        e5: cieList[index].e5 == null
                            ? "-"
                            : cieList[index].e5.toString(),
                        avg: (((cieList[index].e1 ?? 0) +
                                (cieList[index].e2 ?? 0) +
                                (cieList[index].e3 ?? 0) +
                                (cieList[index].e4 ?? 0) +
                                (cieList[index].e5 ?? 0)) ~/
                            2));
                  }))),
    );
  }
}




