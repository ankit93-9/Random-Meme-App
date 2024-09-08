import 'package:flutter/material.dart';
import 'package:meme_app/controller/fetchmeme.dart';
import 'package:meme_app/controller/save_mydata.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String imgUrl = "";
  int? memeNo;
  int targetMeme = 100;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    GetInitMemeNo();
    UpdateImg();
  }

  Future<void> GetInitMemeNo() async {
    memeNo = await SaveMyData.fetchData() ?? 0;

    if (memeNo! < 100) {
      targetMeme = 500;
    } else if (memeNo! < 500) {
      targetMeme = 1000;
    }
    setState(() {});
  }

  Future<void> UpdateImg() async {
    try {
      String getImgUrl = await FetchMeme.fetchNewMeme();
      if (getImgUrl.isNotEmpty) {
        setState(() {
          imgUrl = getImgUrl;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
             debugPrint("Failed to fetch new meme: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 120,),
            Text(
              "Meme #${memeNo.toString()}",
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10,),
            Text(
              "Target $targetMeme Memes",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 30,),
            isLoading
                ? const SizedBox(
                    height: 60, // Adjust the height as needed
                    width: 60,  // Adjust the width as needed
                    child: CircularProgressIndicator(),
                  )
                : imgUrl.isNotEmpty
                  ? Image.network(
                      imgUrl,
                      height: 400,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fitHeight,
                    )
                  : const Text('Failed to load meme'),
            const SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });

                await SaveMyData.saveData(memeNo! + 1);
                await GetInitMemeNo();
                await UpdateImg();
              },
              child: Container(
                height: 50,
                width: 150,
                child: const Center(
                  child: Text(
                    "One More !!",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const Spacer(),
            const Text(
              "APP CREATED BY",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
            ),
            const Text(
              "ANKIT",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}
