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
  @override
  Widget build(BuildContext context) {
    List args = ModalRoute.of(context)!.settings.arguments as List;
    Provider.of<CieProvider>(context, listen: false)
        .fetchAndSetCieData(args[0], args[1]);
    return Scaffold(
      appBar: AppBar(
        title: const Text("CIE"),
        backgroundColor: kBlueColor,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.refresh))
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<CieProvider>(
            builder: (context, cieObj, child) => cieObj.cieData.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: cieObj.cieData.length,
                    itemBuilder: ((context, index) {
                      return ChangeNotifierProvider.value(
                        value: cieObj.cieData[index],
                        child: Consumer<CIE>(
                          builder: (context, cie, child) => CieTile(
                              name: cie.student_name,
                              usn: cie.usn,
                              e1: cie.e1 == null ? "-" : cie.e1.toString(),
                              e2: cie.e2 == null ? "-" : cie.e2.toString(),
                              e3: cie.e3 == null ? "-" : cie.e3.toString(),
                              e4: cie.e4 == null ? "-" : cie.e4.toString(),
                              e5: cie.e5 == null ? "-" : cie.e5.toString(),
                              avg: (((cie.e1 ?? 0) +
                                      (cie.e2 ?? 0) +
                                      (cie.e3 ?? 0) +
                                      (cie.e4 ?? 0) +
                                      (cie.e5 ?? 0)) ~/
                                  2)),
                        ),
                      );
                    })),
          )),
    );
  }
}
