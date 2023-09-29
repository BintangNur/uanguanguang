import 'package:uanguanguang/constant/route_constants.dart';
import 'package:uanguanguang/helper/dbhelper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}

class _HomePageState extends State<HomePage> {
  int totalIncome = 0;
  int totalExpense = 0;

  @override
  void initState() {
    super.initState();
    _fetchTotalIncomeAndExpense();
  }

  Future<void> _fetchTotalIncomeAndExpense() async {
    // Initialize your DBHelper
    final dbHelper = DbHelper();

    // Fetch the total income and total expense
    final income = await dbHelper.getTotalIncome();
    final expense = await dbHelper.getTotalExpense();

    setState(() {
      totalIncome = income;
      totalExpense = expense;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchTotalIncomeAndExpense(); // Refresh data when navigating back
  }

  @override
  Widget build(BuildContext context) {
    // final userProvider = Provider.of<UserProvider>(context);
    // final user = userProvider.user;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Center(
              child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 80,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Rangkuman Bulan Ini",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(color: Colors.indigo.shade900),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: SfCartesianChart(
                    // Initialize category axis
                    primaryXAxis: CategoryAxis(),
                    series: <LineSeries<SalesData, String>>[
                      LineSeries<SalesData, String>(
                          // Bind data source
                          dataSource: <SalesData>[
                            SalesData('Jan', 35),
                            SalesData('Feb', 28),
                            SalesData('Mar', 34),
                            SalesData('Apr', 32),
                            SalesData('May', 10)
                          ],
                          color: Colors.red,
                          xValueMapper: (SalesData sales, _) => sales.year,
                          yValueMapper: (SalesData sales, _) => sales.sales),
                      LineSeries<SalesData, String>(
                          // Bind data source
                          dataSource: <SalesData>[
                            SalesData('Jan', 10),
                            SalesData('Feb', 34),
                            SalesData('Mar', 21),
                            SalesData('Apr', 15),
                            SalesData('May', 40)
                          ],
                          color: Colors.green,
                          xValueMapper: (SalesData sales, _) => sales.year,
                          yValueMapper: (SalesData sales, _) => sales.sales)
                    ]),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:
                                    Icon(Icons.download, color: Colors.green),
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.indigo.shade900,
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Pemasukan',
                                  style: GoogleFonts.montserrat(
                                      color: Colors.white, fontSize: 12),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Rp. $totalIncome',
                                  style: GoogleFonts.montserrat(
                                      color: Colors.white, fontSize: 14),
                                )
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.upload, color: Colors.red),
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.indigo.shade900,
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Pengeluaran',
                                  style: GoogleFonts.montserrat(
                                      color: Colors.white, fontSize: 12),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Rp. $totalExpense',
                                  style: GoogleFonts.montserrat(
                                      color: Colors.white, fontSize: 14),
                                )
                              ],
                            )
                          ],
                        )
                      ]),
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 218, 101, 238),
                      borderRadius: BorderRadius.circular(16)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 140,
                              height: 140,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 10, right: 10),
                                child: NavButton(
                                    imagePath: 'assets/images/profit.png',
                                    label: "",
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, addIncomeRoute);
                                    }),
                              ),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.indigo.shade800),
                                  borderRadius: BorderRadius.circular(16.0)),
                            ),
                            SizedBox(height: 5),
                            Text("Tambah Pemasukan",
                                style: GoogleFonts.exo(
                                    color: const Color.fromARGB(255, 34, 5, 5),
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              width: 140,
                              height: 140,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 10, right: 10),
                                child: NavButton(
                                    imagePath: 'assets/images/loss.png',
                                    label: "",
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, addExpenseRoute);
                                    }),
                              ),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.indigo.shade800),
                                  borderRadius: BorderRadius.circular(16.0)),
                            ),
                            SizedBox(height: 5),
                            Text("Tambah Pengeluaran",
                                style: GoogleFonts.exo(
                                    color: const Color.fromARGB(255, 34, 5, 5),
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 140,
                              height: 140,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 10, right: 10),
                                child: NavButton(
                                    imagePath: 'assets/images/bank.png',
                                    label: "",
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, detailCashFlowRoute);
                                    }),
                              ),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.indigo.shade800),
                                  borderRadius: BorderRadius.circular(16.0)),
                            ),
                            SizedBox(height: 5),
                            Text("Detail Cash Flow",
                                style: GoogleFonts.exo(
                                    color: const Color.fromARGB(255, 34, 5, 5),
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              width: 140,
                              height: 140,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 10, right: 10),
                                child: NavButton(
                                    imagePath: 'assets/images/settings.png',
                                    label: "",
                                    onTap: () {
                                      Navigator.pushNamed(context, '/settings');
                                    }),
                              ),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.indigo.shade800),
                                  borderRadius: BorderRadius.circular(16.0)),
                            ),
                            SizedBox(height: 5),
                            Text("Pengaturan",
                                style: GoogleFonts.exo(
                                    color: const Color.fromARGB(255, 34, 5, 5),
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          )),
        ),
      ),
    );
  }
}

class NavButton extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback onTap;

  const NavButton(
      {required this.imagePath, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(
            imagePath,
            width: 90,
            height: 90,
          ),
          SizedBox(height: 10),
          Text(label),
        ],
      ),
    );
  }
}
