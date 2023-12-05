import 'package:flutter/material.dart';
import 'package:protos/protos.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'YourDailyRoutine'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ClientChannel? _channel;
  TodoServiceClient? _stub;
  dynamic _response;

  String text = '';
  final textController = TextEditingController();

  dynamic top3;
  dynamic time1;
  dynamic cost1;

  dynamic response;

  Future<void> connectToServer() async {
    _channel = ClientChannel('localhost',
        port: 8080,
        // using http instead of https options
        options:
            const ChannelOptions(credentials: ChannelCredentials.insecure()));

    _stub = TodoServiceClient(_channel!,
        //if 30seconds nothing from server => terminate request
        options: CallOptions(timeout: const Duration(seconds: 30)));
  }

  List todolists = [];

  @override
  void initState() {
    super.initState();
    connectToServer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 57, 57, 57),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 57, 57, 57),
        leading: TextButton(
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 76, 76, 76)),
            ),
            onPressed: () {
              num totalCost = 0;
              for (int i = 0; i < todolists.length; i++) {
                totalCost = totalCost + todolists[i].cost;
              }
              wrapUpFunctions();
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                        child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: const Color.fromARGB(255, 117, 209, 120),
                                width: 2),
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                "Wrap Up for Today?",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      final NumberFormat koreanCurrencyFormat =
                                          NumberFormat.simpleCurrency(
                                              locale: 'ko_KR');
                                      showDialog(
                                          barrierDismissible: true,
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Dialog(
                                                backgroundColor:
                                                    Colors.transparent,
                                                child: SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.8,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.8,
                                                  child: DecoratedBox(
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border: Border.all(
                                                            color: const Color
                                                                .fromARGB(255,
                                                                117, 209, 120),
                                                            width: 2),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15)),
                                                    child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          const Text(
                                                            "How Was Your Day?",
                                                            style: TextStyle(
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                height: 1.5,
                                                                shadows: [
                                                                  Shadow(
                                                                      color: Colors
                                                                          .black,
                                                                      offset:
                                                                          Offset(
                                                                              0,
                                                                              -10))
                                                                ],
                                                                color: Colors
                                                                    .transparent,
                                                                decoration:
                                                                    TextDecoration
                                                                        .underline,
                                                                decorationColor:
                                                                    Colors
                                                                        .black,
                                                                decorationStyle:
                                                                    TextDecorationStyle
                                                                        .double,
                                                                decorationThickness:
                                                                    1.5),
                                                          ),
                                                          Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .fromLTRB(
                                                                      10,
                                                                      10,
                                                                      10,
                                                                      10),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  const Text(
                                                                    'Your Word Today was...',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontStyle:
                                                                            FontStyle
                                                                                .italic,
                                                                        fontSize:
                                                                            13),
                                                                  ),
                                                                  DecoratedBox(
                                                                      decoration: BoxDecoration(
                                                                          color: const Color
                                                                              .fromARGB(
                                                                              255,
                                                                              203,
                                                                              203,
                                                                              203),
                                                                          borderRadius:
                                                                              BorderRadius.circular(25)),
                                                                      child: SizedBox(
                                                                          height: 40,
                                                                          width: MediaQuery.of(context).size.width * 0.6,
                                                                          child: Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              Flexible(
                                                                                  child: RichText(
                                                                                maxLines: 1,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                text: TextSpan(
                                                                                  text: text,
                                                                                  style: const TextStyle(
                                                                                    color: Color.fromARGB(255, 57, 57, 57),
                                                                                    fontWeight: FontWeight.bold,
                                                                                  ),
                                                                                ),
                                                                              )),
                                                                            ],
                                                                          ))),
                                                                ],
                                                              )),
                                                          Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .fromLTRB(
                                                                      10,
                                                                      10.0,
                                                                      10,
                                                                      10),
                                                              child: SizedBox(
                                                                  width: MediaQuery.of(context)
                                                                          .size
                                                                          .width *
                                                                      0.7,
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.5,
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceEvenly,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      const Text(
                                                                        'Your Top 3 Activities were...',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontStyle: FontStyle.italic,
                                                                            fontSize: 13),
                                                                      ),
                                                                      ListView.builder(
                                                                          shrinkWrap: true,
                                                                          primary: false,
                                                                          scrollDirection: Axis.vertical,
                                                                          itemCount: top3.todolists.length,
                                                                          itemBuilder: (BuildContext ctx, int idx) {
                                                                            dynamic
                                                                                itemList =
                                                                                top3.todolists[idx];
                                                                            return Padding(
                                                                                padding: const EdgeInsets.fromLTRB(40, 10, 40, 0),
                                                                                child: DecoratedBox(
                                                                                    decoration: BoxDecoration(color: const Color.fromARGB(255, 203, 203, 203), borderRadius: BorderRadius.circular(25)),
                                                                                    child: SizedBox(
                                                                                        height: 90,
                                                                                        width: MediaQuery.of(context).size.width * 0.3,
                                                                                        child: Padding(
                                                                                          padding: const EdgeInsets.all(10),
                                                                                          child: Column(
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                                                            children: [
                                                                                              Row(
                                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                children: [
                                                                                                  const SizedBox(
                                                                                                    width: 10,
                                                                                                  ),
                                                                                                  Flexible(
                                                                                                      child: RichText(
                                                                                                    maxLines: 1,
                                                                                                    overflow: TextOverflow.ellipsis,
                                                                                                    text: TextSpan(
                                                                                                      text: itemList.title,
                                                                                                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
                                                                                                    ),
                                                                                                  )),
                                                                                                  DecoratedBox(
                                                                                                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
                                                                                                      child: SizedBox(
                                                                                                        width: 22,
                                                                                                        height: 22,
                                                                                                        child: Text(
                                                                                                          itemList.count.toString(),
                                                                                                          textAlign: TextAlign.center,
                                                                                                        ),
                                                                                                      ))
                                                                                                ],
                                                                                              ),
                                                                                              Text(koreanCurrencyFormat.format(itemList.cost), style: const TextStyle(fontStyle: FontStyle.italic, color: Colors.red)),
                                                                                              Text("${itemList.time} min", style: const TextStyle(fontStyle: FontStyle.italic))
                                                                                            ],
                                                                                          ),
                                                                                        ))));
                                                                          }),
                                                                    ],
                                                                  ))),
                                                          SizedBox(
                                                              height: 25,
                                                              width: 110,
                                                              child:
                                                                  DecoratedBox(
                                                                decoration:
                                                                    BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                30.0),
                                                                        gradient:
                                                                            const LinearGradient(
                                                                          begin:
                                                                              Alignment.topRight,
                                                                          end: Alignment
                                                                              .bottomLeft,
                                                                          colors: [
                                                                            Color.fromARGB(
                                                                                255,
                                                                                178,
                                                                                246,
                                                                                180),
                                                                            Color.fromARGB(
                                                                                255,
                                                                                183,
                                                                                242,
                                                                                213)
                                                                          ],
                                                                        )),
                                                                child:
                                                                    FloatingActionButton(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                    showDialog(
                                                                        barrierDismissible:
                                                                            true,
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (BuildContext
                                                                                context) {
                                                                          return Dialog(
                                                                              backgroundColor: Colors.transparent,
                                                                              child: SizedBox(
                                                                                  height: MediaQuery.of(context).size.height * 0.8,
                                                                                  width: MediaQuery.of(context).size.width * 0.8,
                                                                                  child: DecoratedBox(
                                                                                      decoration: BoxDecoration(color: Colors.white, border: Border.all(color: const Color.fromARGB(255, 117, 209, 120), width: 2), borderRadius: BorderRadius.circular(15)),
                                                                                      child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                                                                                        const Text(
                                                                                          "How Was Your Day?",
                                                                                          style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20, fontWeight: FontWeight.bold, height: 1.5, shadows: [Shadow(color: Colors.black, offset: Offset(0, -10))], color: Colors.transparent, decoration: TextDecoration.underline, decorationColor: Colors.black, decorationStyle: TextDecorationStyle.double, decorationThickness: 1.5),
                                                                                        ),
                                                                                        Padding(
                                                                                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                                                                                            child: Column(
                                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                              children: [
                                                                                                const Text(
                                                                                                  "You spent time mostly on...",
                                                                                                  style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                                                                                                ),
                                                                                                DecoratedBox(
                                                                                                    decoration: BoxDecoration(color: const Color.fromARGB(255, 203, 203, 203), borderRadius: BorderRadius.circular(25)),
                                                                                                    child: SizedBox(
                                                                                                        height: 90,
                                                                                                        width: MediaQuery.of(context).size.width * 0.5,
                                                                                                        child: Padding(
                                                                                                          padding: const EdgeInsets.all(10),
                                                                                                          child: Column(
                                                                                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                            children: [
                                                                                                              RichText(
                                                                                                                maxLines: 1,
                                                                                                                overflow: TextOverflow.ellipsis,
                                                                                                                text: TextSpan(
                                                                                                                  text: time1 == null ? '' : time1.title,
                                                                                                                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
                                                                                                                ),
                                                                                                              ),
                                                                                                              Text(time1 == null ? '' : '${time1.time} min', style: const TextStyle(fontStyle: FontStyle.italic))
                                                                                                            ],
                                                                                                          ),
                                                                                                        ))),
                                                                                                const SizedBox(
                                                                                                  height: 10,
                                                                                                ),
                                                                                                const Text(
                                                                                                  "You spent your money mostly on...",
                                                                                                  style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                                                                                                ),
                                                                                                DecoratedBox(
                                                                                                    decoration: BoxDecoration(color: const Color.fromARGB(255, 203, 203, 203), borderRadius: BorderRadius.circular(25)),
                                                                                                    child: SizedBox(
                                                                                                        height: 90,
                                                                                                        width: MediaQuery.of(context).size.width * 0.5,
                                                                                                        child: Padding(
                                                                                                          padding: const EdgeInsets.all(10),
                                                                                                          child: Column(
                                                                                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                            children: [
                                                                                                              RichText(
                                                                                                                maxLines: 1,
                                                                                                                overflow: TextOverflow.ellipsis,
                                                                                                                text: TextSpan(
                                                                                                                  text: cost1 == null ? '' : cost1.title,
                                                                                                                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
                                                                                                                ),
                                                                                                              ),
                                                                                                              Text(cost1 == null ? '' : koreanCurrencyFormat.format(cost1.cost), style: const TextStyle(fontStyle: FontStyle.italic))
                                                                                                            ],
                                                                                                          ),
                                                                                                        ))),
                                                                                                const SizedBox(
                                                                                                  height: 10,
                                                                                                ),
                                                                                                const Text(
                                                                                                  "Total money you spent...",
                                                                                                  style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                                                                                                ),
                                                                                                DecoratedBox(
                                                                                                    decoration: BoxDecoration(color: const Color.fromARGB(255, 203, 203, 203), borderRadius: BorderRadius.circular(25)),
                                                                                                    child: SizedBox(
                                                                                                        height: 90,
                                                                                                        width: MediaQuery.of(context).size.width * 0.5,
                                                                                                        child: Padding(
                                                                                                          padding: const EdgeInsets.all(10),
                                                                                                          child: Center(child: Text(koreanCurrencyFormat.format(totalCost), style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20))),
                                                                                                        ))),
                                                                                              ],
                                                                                            )),
                                                                                        SizedBox(
                                                                                            height: 25,
                                                                                            width: 110,
                                                                                            child: DecoratedBox(
                                                                                              decoration: BoxDecoration(
                                                                                                  borderRadius: BorderRadius.circular(30.0),
                                                                                                  gradient: const LinearGradient(
                                                                                                    begin: Alignment.topRight,
                                                                                                    end: Alignment.bottomLeft,
                                                                                                    colors: [
                                                                                                      Color.fromARGB(255, 178, 246, 180),
                                                                                                      Color.fromARGB(255, 183, 242, 213)
                                                                                                    ],
                                                                                                  )),
                                                                                              child: FloatingActionButton(
                                                                                                backgroundColor: Colors.transparent,
                                                                                                onPressed: () {
                                                                                                  Navigator.pop(context);
                                                                                                  showDialog(
                                                                                                      context: context,
                                                                                                      builder: (BuildContext context) {
                                                                                                        return Dialog(
                                                                                                            child: DecoratedBox(
                                                                                                                decoration: BoxDecoration(color: Colors.white, border: Border.all(color: const Color.fromARGB(255, 117, 209, 120), width: 2), borderRadius: BorderRadius.circular(15)),
                                                                                                                child: SizedBox(
                                                                                                                    height: MediaQuery.of(context).size.height * 0.15,
                                                                                                                    width: MediaQuery.of(context).size.width * 0.2,
                                                                                                                    child: Column(
                                                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                      children: [
                                                                                                                        const Text(
                                                                                                                          "Good Luck!!",
                                                                                                                          style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 25, color: Color.fromARGB(255, 76, 76, 76)),
                                                                                                                        ),
                                                                                                                        SizedBox(
                                                                                                                            height: 35,
                                                                                                                            width: 110,
                                                                                                                            child: DecoratedBox(
                                                                                                                                decoration: BoxDecoration(
                                                                                                                                    borderRadius: BorderRadius.circular(30.0),
                                                                                                                                    gradient: const LinearGradient(
                                                                                                                                      begin: Alignment.topRight,
                                                                                                                                      end: Alignment.bottomLeft,
                                                                                                                                      colors: [
                                                                                                                                        Color.fromARGB(255, 178, 246, 180),
                                                                                                                                        Color.fromARGB(255, 183, 242, 213)
                                                                                                                                      ],
                                                                                                                                    )),
                                                                                                                                child: FloatingActionButton(
                                                                                                                                    backgroundColor: Colors.transparent,
                                                                                                                                    onPressed: () async {
                                                                                                                                      for (int i = 0; i < todolists.length; i++) {
                                                                                                                                        var tD = todolists[i];
                                                                                                                                        var tdList = await _findTodoListByTitle(tD.title);
                                                                                                                                        _stub!.deleteTodolist(tdList);
                                                                                                                                      }
                                                                                                                                      cost1 = null;
                                                                                                                                      time1 = null;

                                                                                                                                      setState(() {
                                                                                                                                        Navigator.pop(context);
                                                                                                                                      });
                                                                                                                                    },
                                                                                                                                    child: const Text("Ok", style: TextStyle(color: Colors.black)))))
                                                                                                                      ],
                                                                                                                    ))));
                                                                                                      });
                                                                                                  setState(() {
                                                                                                    textController.text = '';
                                                                                                    text = '';
                                                                                                  });
                                                                                                },
                                                                                                child: const Text("Done", style: TextStyle(fontStyle: FontStyle.italic, color: Color.fromARGB(255, 55, 55, 55))),
                                                                                              ),
                                                                                            ))
                                                                                      ]))));
                                                                        });
                                                                  },
                                                                  child: const Text(
                                                                      "Next",
                                                                      style: TextStyle(
                                                                          fontStyle: FontStyle
                                                                              .italic,
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              55,
                                                                              55,
                                                                              55))),
                                                                ),
                                                              ))
                                                        ]),
                                                  ),
                                                ));
                                          });
                                    },
                                    child: const Text("Yes",
                                        style: TextStyle(color: Colors.black)),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        Navigator.pop(context);
                                      });
                                    },
                                    child: const Text(
                                      "no",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 15),
                                    ),
                                  )
                                ],
                              )
                            ]),
                      ),
                    ));
                  });
            },
            child: const Icon(
              Icons.receipt_rounded,
              color: Colors.white,
              size: 25,
            )),
        actions: [
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 3, 18, 0),
              child: TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 76, 76, 76)),
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        final contactController = TextEditingController();
                        return Dialog(
                          backgroundColor: Colors.transparent,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                color: Colors.grey[850],
                                borderRadius: BorderRadius.circular(15)),
                            child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Menu",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontStyle: FontStyle.italic,
                                          fontSize: 20),
                                    ),
                                    const SizedBox(height: 20),
                                    DecoratedBox(
                                        decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 210, 210, 210),
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.09,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          child: FloatingActionButton(
                                            onPressed: () async {
                                              for (int i = 0;
                                                  i < todolists.length;
                                                  i++) {
                                                var tD = todolists[i];
                                                var tdList =
                                                    await _findTodoListByTitle(
                                                        tD.title);
                                                _stub!.deleteTodolist(tdList);
                                              }
                                              setState(() {
                                                textController.text = '';
                                                text = '';
                                                Navigator.pop(context);
                                              });
                                            },
                                            backgroundColor: Colors.transparent,
                                            child: const Text(
                                              "Reset",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                        )),
                                    const SizedBox(height: 30),
                                    DecoratedBox(
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 210, 210, 210),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.09,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        child: FloatingActionButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return Dialog(
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      insetPadding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      child: SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.8,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.3,
                                                        child: DecoratedBox(
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                border: Border.all(
                                                                    color: const Color
                                                                        .fromARGB(
                                                                        255,
                                                                        117,
                                                                        209,
                                                                        120),
                                                                    width: 2),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15)),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  const Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        "What would you like to tell us?",
                                                                        style: TextStyle(
                                                                            fontStyle: FontStyle
                                                                                .italic,
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  DecoratedBox(
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .transparent,
                                                                        borderRadius:
                                                                            BorderRadius.circular(25)),
                                                                    child:
                                                                        SizedBox(
                                                                      height: MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                          0.2,
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.7,
                                                                      child: TextFormField(
                                                                          minLines: 1,
                                                                          maxLines: 5,
                                                                          cursorWidth: 1,
                                                                          cursorColor: Colors.black,
                                                                          cursorHeight: 25,
                                                                          textAlign: TextAlign.center,
                                                                          controller: contactController,
                                                                          decoration: InputDecoration(
                                                                            labelText:
                                                                                "Type...",
                                                                            labelStyle:
                                                                                const TextStyle(color: Colors.grey),
                                                                            floatingLabelBehavior:
                                                                                FloatingLabelBehavior.never,
                                                                            border:
                                                                                OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(25.0)),
                                                                          )),
                                                                    ),
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            print('Customor : ${contactController.text}');
                                                                            Navigator.of(context, rootNavigator: true).pop();
                                                                          });
                                                                          showDialog(
                                                                              context: context,
                                                                              builder: (BuildContext context) {
                                                                                return AlertDialog(
                                                                                  // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
                                                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                                                                                  backgroundColor: Colors.yellow[50],
                                                                                  title: const Column(
                                                                                    children: <Widget>[
                                                                                      Text("Sent!"),
                                                                                    ],
                                                                                  ),
                                                                                  actions: <Widget>[
                                                                                    TextButton(
                                                                                      child: const Text("Ok", style: TextStyle(color: Colors.black)),
                                                                                      onPressed: () {
                                                                                        Navigator.pop(context);
                                                                                      },
                                                                                    ),
                                                                                  ],
                                                                                );
                                                                              });
                                                                        },
                                                                        child:
                                                                            const Text(
                                                                          "Send",
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontStyle: FontStyle.italic,
                                                                              fontSize: 15),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            )),
                                                      ));
                                                });
                                          },
                                          backgroundColor: Colors.transparent,
                                          child: const Text(
                                            "Contact Us",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        );
                      });
                },
                child: const Icon(
                  Icons.menu_rounded,
                  color: Colors.white,
                  size: 30,
                ),
              )),
        ],
        centerTitle: true,
        title: Text(
          widget.title,
          style:
              const TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
        ),
      ),
      body: FutureBuilder(
          future: fetchDataFromServer(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData == false) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              todolists = snapshot.data.todolists;
              response = wrapUpFunctions();

              return DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 57, 57, 57),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(8.5, 8.5, 8.5, 8.5),
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 255, 250, 250),
                                    borderRadius: BorderRadius.circular(5.0),
                                    gradient: const RadialGradient(
                                      center: Alignment.center,
                                      radius: 4,
                                      colors: [
                                        Colors.white,
                                        Color.fromARGB(255, 168, 237, 168),
                                      ],
                                    )),
                                child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: 95,
                                    child: FloatingActionButton(
                                        backgroundColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Dialog(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    insetPadding:
                                                        const EdgeInsets.all(5),
                                                    child: SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.8,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.3,
                                                      child: DecoratedBox(
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              border: Border.all(
                                                                  color: const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      117,
                                                                      209,
                                                                      120),
                                                                  width: 2),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15)),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                const Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      "Today's word for you",
                                                                      style: TextStyle(
                                                                          fontStyle: FontStyle
                                                                              .italic,
                                                                          fontSize:
                                                                              10,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ],
                                                                ),
                                                                DecoratedBox(
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .transparent,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              25)),
                                                                  child:
                                                                      SizedBox(
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        0.2,
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.7,
                                                                    child: TextFormField(
                                                                        minLines: 1,
                                                                        maxLines: 5,
                                                                        cursorWidth: 1,
                                                                        cursorColor: Colors.black,
                                                                        cursorHeight: 25,
                                                                        textAlign: TextAlign.center,
                                                                        controller: textController,
                                                                        decoration: InputDecoration(
                                                                          labelText:
                                                                              "Type...",
                                                                          labelStyle:
                                                                              const TextStyle(color: Colors.grey),
                                                                          floatingLabelBehavior:
                                                                              FloatingLabelBehavior.never,
                                                                          border: OutlineInputBorder(
                                                                              borderSide: BorderSide.none,
                                                                              borderRadius: BorderRadius.circular(25.0)),
                                                                        )),
                                                                  ),
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          text =
                                                                              textController.text;
                                                                          Navigator.of(context, rootNavigator: true)
                                                                              .pop();
                                                                        });
                                                                      },
                                                                      child:
                                                                          const Text(
                                                                        "Done",
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontStyle: FontStyle.italic,
                                                                            fontSize: 15),
                                                                      ),
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          )),
                                                    ));
                                              });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              15, 0, 15, 0),
                                          child: RichText(
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            text: TextSpan(
                                              text: text == ''
                                                  ? 'Click Here!'
                                                  : text,
                                              style: TextStyle(
                                                color: text == ''
                                                    ? Colors.grey
                                                    : const Color.fromARGB(
                                                        255, 57, 57, 57),
                                                fontWeight: text == ''
                                                    ? null
                                                    : FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ))),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.all(8.5),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: FloatingActionButton(
                                      backgroundColor: const Color.fromARGB(
                                          31, 226, 226, 226),
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              final titleController =
                                                  TextEditingController();
                                              final costController =
                                                  TextEditingController();
                                              costController.text = '0';
                                              final timeController =
                                                  TextEditingController();
                                              costController.text = '0';
                                              timeController.text = '0';
                                              final NumberFormat
                                                  koreanCurrencyFormat =
                                                  NumberFormat.simpleCurrency(
                                                      locale: 'ko_KR');
                                              final formKey =
                                                  GlobalKey<FormState>();
                                              return Dialog(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  insetPadding:
                                                      const EdgeInsets.all(10),
                                                  child: SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.8,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.8,
                                                      child: DecoratedBox(
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            border: Border.all(
                                                                color: const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    117,
                                                                    209,
                                                                    120),
                                                                width: 2),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                        child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(15.0),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    const Text(
                                                                      "Create Action",
                                                                      style: TextStyle(
                                                                          fontStyle: FontStyle
                                                                              .italic,
                                                                          fontSize:
                                                                              18,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    DecoratedBox(
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(30.0),
                                                                          gradient: const LinearGradient(
                                                                            begin:
                                                                                Alignment.topRight,
                                                                            end:
                                                                                Alignment.bottomLeft,
                                                                            colors: [
                                                                              Color.fromARGB(255, 213, 213, 213),
                                                                              Color.fromARGB(255, 234, 231, 231),
                                                                            ],
                                                                          )),
                                                                      child: FloatingActionButton
                                                                          .small(
                                                                        shape:
                                                                            const CircleBorder(),
                                                                        backgroundColor:
                                                                            Colors.transparent,
                                                                        onPressed:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            Navigator.of(context, rootNavigator: true).pop();
                                                                          });
                                                                        },
                                                                        child: const Text(
                                                                            "X",
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.7,
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        0.6,
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Padding(
                                                                            padding: const EdgeInsets.fromLTRB(
                                                                                10,
                                                                                25.0,
                                                                                10,
                                                                                10),
                                                                            child:
                                                                                Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                const Text(
                                                                                  "Name of Action",
                                                                                  style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 12),
                                                                                ),
                                                                                DecoratedBox(
                                                                                    decoration: BoxDecoration(color: const Color.fromARGB(255, 203, 203, 203), borderRadius: BorderRadius.circular(25)),
                                                                                    child: Form(
                                                                                      key: formKey,
                                                                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                                                                      child: TextFormField(
                                                                                          validator: (value) {
                                                                                            if (value!.isEmpty) {
                                                                                              return 'Need more than 1 character';
                                                                                            } else {
                                                                                              return null;
                                                                                            }
                                                                                          },
                                                                                          cursorWidth: 1,
                                                                                          cursorColor: Colors.black,
                                                                                          cursorHeight: 25,
                                                                                          textAlign: TextAlign.center,
                                                                                          controller: titleController,
                                                                                          decoration: InputDecoration(
                                                                                            border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(25.0)),
                                                                                          )),
                                                                                    )),
                                                                              ],
                                                                            )),
                                                                        Padding(
                                                                          padding: const EdgeInsets
                                                                              .fromLTRB(
                                                                              10,
                                                                              25.0,
                                                                              10,
                                                                              15),
                                                                          child: Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                const Text(
                                                                                  "Cost of Action",
                                                                                  style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 12),
                                                                                ),
                                                                                DecoratedBox(
                                                                                    decoration: BoxDecoration(color: const Color.fromARGB(255, 203, 203, 203), borderRadius: BorderRadius.circular(25)),
                                                                                    child: TextFormField(
                                                                                      keyboardType: TextInputType.number,
                                                                                      onChanged: (value) {
                                                                                        if (value.isEmpty) {
                                                                                          return;
                                                                                        }
                                                                                        // Remove non-numeric characters
                                                                                        String text = value.replaceAll(RegExp(r'[^0-9]'), '');

                                                                                        // Format the text as Korean currency
                                                                                        double amount = text == '' ? 0 : double.parse(text);
                                                                                        String formattedText = koreanCurrencyFormat.format(amount);

                                                                                        setState(() {
                                                                                          costController.text = formattedText;
                                                                                        });
                                                                                      },
                                                                                      cursorWidth: 1,
                                                                                      cursorColor: Colors.black,
                                                                                      cursorHeight: 25,
                                                                                      textAlign: TextAlign.center,
                                                                                      controller: costController,
                                                                                      decoration: InputDecoration(border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(25.0))),
                                                                                    ))
                                                                              ]),
                                                                        ),
                                                                        Padding(
                                                                            padding: const EdgeInsets.fromLTRB(
                                                                                10,
                                                                                25.0,
                                                                                10,
                                                                                0),
                                                                            child:
                                                                                Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                const Text(
                                                                                  "Estimated Time of Duration (Min)",
                                                                                  style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 12),
                                                                                ),
                                                                                DecoratedBox(
                                                                                    decoration: BoxDecoration(color: const Color.fromARGB(255, 203, 203, 203), borderRadius: BorderRadius.circular(25)),
                                                                                    child: TextField(
                                                                                      keyboardType: TextInputType.number,
                                                                                      onChanged: (value) {
                                                                                        if (value.isEmpty) {
                                                                                          return;
                                                                                        }
                                                                                        // Remove non-numeric characters
                                                                                        String text = value.replaceAll(RegExp(r'[^0-9]'), '');

                                                                                        // Format the text as Korean currency
                                                                                        int amount = text == '' ? 0 : int.parse(text);
                                                                                        String formattedText = amount.toString();

                                                                                        setState(() {
                                                                                          timeController.text = formattedText;
                                                                                        });
                                                                                      },
                                                                                      cursorWidth: 1,
                                                                                      cursorColor: Colors.black,
                                                                                      cursorHeight: 25,
                                                                                      textAlign: TextAlign.center,
                                                                                      controller: timeController,
                                                                                      decoration: InputDecoration(border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(25.0))),
                                                                                    ))
                                                                              ],
                                                                            )),
                                                                      ],
                                                                    )),
                                                                SizedBox(
                                                                    height: 25,
                                                                    width: 110,
                                                                    child:
                                                                        DecoratedBox(
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(30.0),
                                                                          gradient: const LinearGradient(
                                                                            begin:
                                                                                Alignment.topRight,
                                                                            end:
                                                                                Alignment.bottomLeft,
                                                                            colors: [
                                                                              Color.fromARGB(255, 178, 246, 180),
                                                                              Color.fromARGB(255, 183, 242, 213)
                                                                            ],
                                                                          )),
                                                                      child:
                                                                          FloatingActionButton(
                                                                        backgroundColor:
                                                                            Colors.transparent,
                                                                        onPressed:
                                                                            () {
                                                                          final formKeyState =
                                                                              formKey.currentState!;
                                                                          if (formKeyState
                                                                              .validate()) {
                                                                            String
                                                                                oCost =
                                                                                costController.text;
                                                                            String
                                                                                cost;
                                                                            oCost.length < 3
                                                                                ? oCost.substring(0, 1) == '₩'
                                                                                    ? cost = oCost.substring(1)
                                                                                    : cost = oCost
                                                                                : oCost.length > 4
                                                                                    ? cost = oCost.substring(1).split(',').join()
                                                                                    : cost = oCost.substring(1);
                                                                            setState(() {
                                                                              if (todolists.indexWhere((element) => element.title == titleController.text) == -1) {
                                                                                todoList = TodoList()
                                                                                  ..title = titleController.text
                                                                                  ..id = todolists.length + 1
                                                                                  ..count = 1
                                                                                  ..cost = int.parse(cost)
                                                                                  ..time = int.parse(timeController.text);

                                                                                _stub!.createTodoList(todoList);

                                                                                Navigator.of(context, rootNavigator: true).pop();
                                                                              } else {
                                                                                showDialog(
                                                                                    context: context,
                                                                                    barrierDismissible: false,
                                                                                    builder: (BuildContext context) {
                                                                                      return AlertDialog(
                                                                                        backgroundColor: const Color.fromARGB(255, 255, 253, 238),
                                                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                                                                        title: const Column(
                                                                                          children: [
                                                                                            Text("Existing List"),
                                                                                          ],
                                                                                        ),
                                                                                        contentPadding: const EdgeInsets.fromLTRB(55, 20, 0, 0),
                                                                                        content: const SizedBox(
                                                                                          height: 40,
                                                                                          width: 50,
                                                                                          child: Text("이미 존재하는 이름입니다"),
                                                                                        ),
                                                                                        actions: <Widget>[
                                                                                          TextButton(
                                                                                            child: const Text(
                                                                                              "Ok",
                                                                                              style: TextStyle(color: Colors.black),
                                                                                            ),
                                                                                            onPressed: () {
                                                                                              Navigator.pop(context);
                                                                                            },
                                                                                          )
                                                                                        ],
                                                                                      );
                                                                                    });
                                                                              }
                                                                            });
                                                                          }
                                                                        },
                                                                        child: const Text(
                                                                            "confirm",
                                                                            style:
                                                                                TextStyle(fontStyle: FontStyle.italic, color: Color.fromARGB(255, 55, 55, 55))),
                                                                      ),
                                                                    ))
                                                              ],
                                                            )),
                                                      )));
                                            });
                                      },
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      )),
                                )),
                            ListView.builder(
                                shrinkWrap: true,
                                primary: false,
                                scrollDirection: Axis.vertical,
                                itemCount: todolists.length,
                                itemBuilder: (BuildContext ctx, int idx) {
                                  dynamic todolist = todolists[idx];
                                  return Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          8, 8, 8, 10),
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: const Color.fromARGB(
                                                    255, 117, 209, 120),
                                                width: 1.5),
                                            borderRadius:
                                                BorderRadius.circular(15.0)),
                                        child: ListTile(
                                          title: GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return Dialog(
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        insetPadding:
                                                            const EdgeInsets.all(
                                                                10),
                                                        child: SizedBox(
                                                            width: MediaQuery.of(context)
                                                                    .size
                                                                    .width *
                                                                0.8,
                                                            height:
                                                                MediaQuery.of(context)
                                                                        .size
                                                                        .height *
                                                                    0.4,
                                                            child: DecoratedBox(
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    border: Border.all(
                                                                        color: const Color.fromARGB(
                                                                            255,
                                                                            117,
                                                                            209,
                                                                            120),
                                                                        width:
                                                                            2),
                                                                    borderRadius:
                                                                        BorderRadius.circular(15)),
                                                                child: Padding(
                                                                    padding: const EdgeInsets.all(20.0),
                                                                    child: Column(children: [
                                                                      const Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            "Current Status",
                                                                            style: TextStyle(
                                                                                fontWeight: FontWeight.bold,
                                                                                fontStyle: FontStyle.italic,
                                                                                fontSize: 16),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Padding(
                                                                          padding: const EdgeInsets
                                                                              .fromLTRB(
                                                                              0,
                                                                              30,
                                                                              0,
                                                                              0),
                                                                          child: SizedBox(
                                                                              width: MediaQuery.of(context).size.width * 0.8,
                                                                              child: Padding(
                                                                                  padding: const EdgeInsets.only(left: 20),
                                                                                  child: Column(
                                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                                    children: [
                                                                                      Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                                                        children: [
                                                                                          const Text(
                                                                                            "Item: ",
                                                                                            style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 13),
                                                                                          ),
                                                                                          SizedBox(
                                                                                              width: MediaQuery.of(context).size.width * 0.5,
                                                                                              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                                                                                                Flexible(
                                                                                                    child: RichText(
                                                                                                  maxLines: 3,
                                                                                                  overflow: TextOverflow.ellipsis,
                                                                                                  text: TextSpan(
                                                                                                    text: todolist.title,
                                                                                                    style: const TextStyle(color: Colors.black),
                                                                                                  ),
                                                                                                )),
                                                                                              ])),
                                                                                        ],
                                                                                      ),
                                                                                      const SizedBox(
                                                                                        height: 15,
                                                                                      ),
                                                                                      Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                                        children: [
                                                                                          const Text(
                                                                                            "Time Spent (Min):  ",
                                                                                            style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 13),
                                                                                          ),
                                                                                          Text(todolist.time.toString())
                                                                                        ],
                                                                                      ),
                                                                                      const SizedBox(
                                                                                        height: 15,
                                                                                      ),
                                                                                      Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                                        children: [
                                                                                          const Text(
                                                                                            "Costs :  ",
                                                                                            style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 13),
                                                                                          ),
                                                                                          Text('${todolist.cost.toString()} ₩'),
                                                                                        ],
                                                                                      ),
                                                                                      const SizedBox(
                                                                                        height: 15,
                                                                                      ),
                                                                                      Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                                        children: [
                                                                                          const Text(
                                                                                            "Count :  ",
                                                                                            style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 13),
                                                                                          ),
                                                                                          Text(todolist.count.toString()),
                                                                                        ],
                                                                                      ),
                                                                                    ],
                                                                                  ))))
                                                                    ])))));
                                                  });
                                            },
                                            child: Center(
                                                child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                GestureDetector(
                                                    child: SizedBox(
                                                        width: 45,
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              var todo =
                                                                  TodoList()
                                                                    ..id =
                                                                        todolist
                                                                            .id
                                                                    ..title =
                                                                        todolist
                                                                            .title
                                                                    ..cost =
                                                                        todolist
                                                                            .cost
                                                                    ..time =
                                                                        todolist
                                                                            .time
                                                                    ..action =
                                                                        todolist
                                                                            .action
                                                                    ..count =
                                                                        todolist
                                                                            .count;
                                                              _stub!
                                                                  .deleteTodolist(
                                                                      todo);
                                                            });
                                                          },
                                                          child: const Text(
                                                            'X',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ))),
                                                SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.5,
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Flexible(
                                                              child: RichText(
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            text: TextSpan(
                                                              text: todolist
                                                                  .title,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 17),
                                                            ),
                                                          )),
                                                        ])),
                                                DecoratedBox(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30.0),
                                                      gradient:
                                                          const LinearGradient(
                                                        begin:
                                                            Alignment.topRight,
                                                        end: Alignment
                                                            .bottomLeft,
                                                        colors: [
                                                          Color.fromARGB(255,
                                                              213, 213, 213),
                                                          Color.fromARGB(255,
                                                              234, 231, 231),
                                                        ],
                                                      )),
                                                  child: FloatingActionButton
                                                      .small(
                                                    shape: const CircleBorder(),
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    onPressed: () {
                                                      setState(() {
                                                        showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              final costController =
                                                                  TextEditingController();
                                                              costController
                                                                  .text = '0';
                                                              final timeController =
                                                                  TextEditingController();
                                                              costController
                                                                  .text = '0';
                                                              timeController
                                                                  .text = '0';
                                                              final NumberFormat
                                                                  koreanCurrencyFormat =
                                                                  NumberFormat
                                                                      .simpleCurrency(
                                                                          locale:
                                                                              'ko_KR');

                                                              return Dialog(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                  insetPadding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          10),
                                                                  child: SizedBox(
                                                                      width: MediaQuery.of(context).size.width * 0.8,
                                                                      height: MediaQuery.of(context).size.height * 0.8,
                                                                      child: DecoratedBox(
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                Colors.white,
                                                                            border: Border.all(color: const Color.fromARGB(255, 117, 209, 120), width: 2),
                                                                            borderRadius: BorderRadius.circular(15)),
                                                                        child: Padding(
                                                                            padding: const EdgeInsets.all(20.0),
                                                                            child: Column(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    const Text(
                                                                                      "Add Count",
                                                                                      style: TextStyle(fontStyle: FontStyle.italic, fontSize: 18, fontWeight: FontWeight.bold),
                                                                                    ),
                                                                                    DecoratedBox(
                                                                                      decoration: BoxDecoration(
                                                                                          borderRadius: BorderRadius.circular(30.0),
                                                                                          gradient: const LinearGradient(
                                                                                            begin: Alignment.topRight,
                                                                                            end: Alignment.bottomLeft,
                                                                                            colors: [
                                                                                              Color.fromARGB(255, 213, 213, 213),
                                                                                              Color.fromARGB(255, 234, 231, 231),
                                                                                            ],
                                                                                          )),
                                                                                      child: FloatingActionButton.small(
                                                                                        shape: const CircleBorder(),
                                                                                        backgroundColor: Colors.transparent,
                                                                                        onPressed: () {
                                                                                          setState(() {
                                                                                            Navigator.of(context, rootNavigator: true).pop();
                                                                                          });
                                                                                        },
                                                                                        child: const Text("X", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                                                                                      ),
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                                SizedBox(
                                                                                    width: MediaQuery.of(context).size.width * 0.7,
                                                                                    height: MediaQuery.of(context).size.height * 0.63,
                                                                                    child: Column(
                                                                                      children: [
                                                                                        Padding(
                                                                                            padding: const EdgeInsets.fromLTRB(10, 50.0, 10, 10),
                                                                                            child: Column(
                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                              children: [
                                                                                                const Text(
                                                                                                  'Title Name',
                                                                                                  style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 12),
                                                                                                ),
                                                                                                DecoratedBox(
                                                                                                    decoration: BoxDecoration(color: const Color.fromARGB(255, 203, 203, 203), borderRadius: BorderRadius.circular(25)),
                                                                                                    child: SizedBox(
                                                                                                        height: 55,
                                                                                                        width: MediaQuery.of(context).size.width * 0.8,
                                                                                                        child: Row(
                                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                          children: [
                                                                                                            Text(
                                                                                                              todolist.title,
                                                                                                            ),
                                                                                                          ],
                                                                                                        ))),
                                                                                              ],
                                                                                            )),
                                                                                        Padding(
                                                                                          padding: const EdgeInsets.fromLTRB(10, 25.0, 10, 15),
                                                                                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                                                            const Text(
                                                                                              "Cost of Action",
                                                                                              style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 12),
                                                                                            ),
                                                                                            DecoratedBox(
                                                                                                decoration: BoxDecoration(color: const Color.fromARGB(255, 203, 203, 203), borderRadius: BorderRadius.circular(25)),
                                                                                                child: TextFormField(
                                                                                                  keyboardType: TextInputType.number,
                                                                                                  onChanged: (value) {
                                                                                                    if (value.isEmpty) {
                                                                                                      return;
                                                                                                    }
                                                                                                    // Remove non-numeric characters
                                                                                                    String text = value.replaceAll(RegExp(r'[^0-9]'), '');

                                                                                                    // Format the text as Korean currency
                                                                                                    double amount = text == '' ? 0 : double.parse(text);
                                                                                                    String formattedText = koreanCurrencyFormat.format(amount);

                                                                                                    setState(() {
                                                                                                      costController.text = formattedText;
                                                                                                    });
                                                                                                  },
                                                                                                  cursorWidth: 1,
                                                                                                  cursorColor: Colors.black,
                                                                                                  cursorHeight: 25,
                                                                                                  textAlign: TextAlign.center,
                                                                                                  controller: costController,
                                                                                                  decoration: InputDecoration(border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(25.0))),
                                                                                                ))
                                                                                          ]),
                                                                                        ),
                                                                                        Padding(
                                                                                            padding: const EdgeInsets.fromLTRB(10, 25.0, 10, 0),
                                                                                            child: Column(
                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                              children: [
                                                                                                const Text(
                                                                                                  "Estimated Time of Duration (Min)",
                                                                                                  style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 12),
                                                                                                ),
                                                                                                DecoratedBox(
                                                                                                    decoration: BoxDecoration(color: const Color.fromARGB(255, 203, 203, 203), borderRadius: BorderRadius.circular(25)),
                                                                                                    child: TextField(
                                                                                                      keyboardType: TextInputType.number,
                                                                                                      onChanged: (value) {
                                                                                                        if (value.isEmpty) {
                                                                                                          return;
                                                                                                        }
                                                                                                        // Remove non-numeric characters
                                                                                                        String text = value.replaceAll(RegExp(r'[^0-9]'), '');

                                                                                                        // Format the text as Korean currency
                                                                                                        int amount = text == '' ? 0 : int.parse(text);
                                                                                                        String formattedText = amount.toString();

                                                                                                        setState(() {
                                                                                                          timeController.text = formattedText;
                                                                                                        });
                                                                                                      },
                                                                                                      cursorWidth: 1,
                                                                                                      cursorColor: Colors.black,
                                                                                                      cursorHeight: 25,
                                                                                                      textAlign: TextAlign.center,
                                                                                                      controller: timeController,
                                                                                                      decoration: InputDecoration(border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(25.0))),
                                                                                                    ))
                                                                                              ],
                                                                                            )),
                                                                                      ],
                                                                                    )),
                                                                                SizedBox(
                                                                                    height: 25,
                                                                                    width: 110,
                                                                                    child: DecoratedBox(
                                                                                      decoration: BoxDecoration(
                                                                                          borderRadius: BorderRadius.circular(30.0),
                                                                                          gradient: const LinearGradient(
                                                                                            begin: Alignment.topRight,
                                                                                            end: Alignment.bottomLeft,
                                                                                            colors: [
                                                                                              Color.fromARGB(255, 178, 246, 180),
                                                                                              Color.fromARGB(255, 183, 242, 213)
                                                                                            ],
                                                                                          )),
                                                                                      child: FloatingActionButton(
                                                                                        backgroundColor: Colors.transparent,
                                                                                        onPressed: () {
                                                                                          String oCost = costController.text;
                                                                                          String cost;
                                                                                          oCost.length < 3
                                                                                              ? oCost.substring(0, 1) == '₩'
                                                                                                  ? cost = oCost.substring(1)
                                                                                                  : cost = oCost
                                                                                              : oCost.length > 4
                                                                                                  ? cost = oCost.substring(1).split(',').join()
                                                                                                  : cost = oCost.substring(1);
                                                                                          setState(() {
                                                                                            todoList = TodoList()
                                                                                              ..title = todolist.title
                                                                                              ..id = todolist.id
                                                                                              ..count = 1
                                                                                              ..cost = int.parse(cost)
                                                                                              ..time = int.parse(timeController.text);

                                                                                            _stub!.addTodolistCount(todoList);
                                                                                            Navigator.of(context, rootNavigator: true).pop();
                                                                                          });
                                                                                        },
                                                                                        child: const Text("confirm", style: TextStyle(fontStyle: FontStyle.italic, color: Color.fromARGB(255, 55, 55, 55))),
                                                                                      ),
                                                                                    ))
                                                                              ],
                                                                            )),
                                                                      )));
                                                            });
                                                      });
                                                    },
                                                    child: Text(
                                                      todolist.count.toString(),
                                                      style: const TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )),
                                          ),
                                        ),
                                      ));
                                }),
                          ],
                        ),
                      )));
            }
          }),
    );
  }

  Future<List<TodoList>> wrapUpFunctions() async {
    try {
      top3 = await _stub!.getTopThreeList(Empty());
      time1 = await _stub!.getTopTimeList(Empty());
      cost1 = await _stub!.getTopCostList(Empty());
      return [top3, time1, cost1];
    } catch (e) {
      return [];
    }
  }

  Future<dynamic> fetchDataFromServer() async {
    try {
      _response = await _stub!.getAllTodoLists(Empty());
      return _response;
    } catch (e) {
      return null;
    }
  }

  Future<TodoList> _findTodoListByTitle(String title) async {
    var todoList = TodoList()..title = title;
    todoList = await _stub!.getTodolist(todoList);
    return todoList;
  }

  @override
  void dispose() {
    _channel?.shutdown();
    super.dispose();
  }
}
