import 'package:flutter/material.dart';
import 'package:tic_toc_toe/constants.dart';
import 'package:flutter_launcher_icons/android.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:audioplayers/audioplayers.dart';

import 'package:tic_toc_toe/dialogWinner.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List XorOList = [
    'images/box.png', 
    'images/box.png', 
    'images/box.png', 
    'images/box.png', 
    'images/box.png', 
    'images/box.png', 
    'images/box.png', 
    'images/box.png', 
    'images/box.png', 
    'images/box.png', 
    'images/box.png', 
    'images/box.png', 
    'images/box.png', 
    'images/box.png', 
    'images/box.png', 
    'images/box.png', 
  ];

  final txtPlayerO = 'images/o.png';
  final txtPlayerX = 'images/x.png';

  int playerO = 0;
  int playerX = 0;
  int equal = 0;
  int filledBoxes = 0;
  int boardSize = 3;

  bool winnerO = false;
  bool winnerX = false;
  bool isTurnO = true;
  bool isMuted = false; 

  AudioPlayer audioPlayer = AudioPlayer();

  void toggleSound() {
    setState(() {
      isMuted = !isMuted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 80,
        elevation: 0,
        backgroundColor: Color(0xFF132332),
        title: Center(
          child: Image.asset(
            'images/appBar_icon.png', 
            width: 90,
            height: 90,
          ),
        )
      ),
      backgroundColor: Color(0xFF132332),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(15, 9, 0, 9),
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: kAmber,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: IconButton(
                      icon: Icon(
                        isMuted ? Icons.volume_off  : Icons.volume_up,
                        size: 24,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        toggleSound();
                      },
                    ),
                  ),
                dropDownButton(),
                GestureDetector(
                  onTap: () {
                    clearGame();
                    playSound('reset.mp3');
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 9, 15, 9),
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: kAmber,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        Icons.refresh_rounded,
                        size: 24,
                        color: Colors.black,
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 20,),
            getTurn(),
            SizedBox(height: 20,),
            getScoreBoard(),
            getGridView(),
          ],
        ),
      ),
    );
  }


  Widget dropDownButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: kBlue, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<String>(
        items: [
          DropdownMenuItem(
            child: Text(
              '3 x 3', 
              style: TextStyle(
                color: kWhite,
                fontSize: 30,
                fontWeight: FontWeight.bold
              ),
            ),
            value: '3',
          ),
          DropdownMenuItem(
            child: Text(
              '4 x 4', 
              style: TextStyle(
                color: kWhite,
                fontSize: 30,
                fontWeight: FontWeight.bold
              ),
            ),
            value: '4',
          ),
        ],
          onChanged: (value) {
            setState(() {
              boardSize = int.parse(value!);
            });
          },
    
        dropdownColor: kDarkBlue,
        isExpanded: false,
        value: boardSize.toString(),
        iconSize: 30,
        iconEnabledColor: kWhite,
        focusColor: kWhite,
        borderRadius: BorderRadius.circular(10),
        underline: Container(
          height: 0,
        ),
      ),
    );
  }


  Widget getTurn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          isTurnO ? 'images/o.png' : 'images/x.png',
          height: 30,
          width: 30,
        ),
        SizedBox(height: 5,),
        Text(
          isTurnO ? 'نوبت بازیکن' : 'نوبت بازیکن',
          style: TextStyle(
            fontSize: 25, 
            color: kWhite
          ),
        ),
      ],
      
    );
  }


  Widget getGridView() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.fromLTRB(5, 15, 5, 0),
        child: GridView.builder(
          // shrinkWrap: true,
          itemCount: boardSize * boardSize,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: boardSize),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    if(XorOList[index] != 'images/box.png') {
                      return;
                    }
                    if(isTurnO) {
                      XorOList[index] = 'images/o.png';
                      playSound('o.mp3');
                      filledBoxes = filledBoxes + 1;
                    } else{
                      XorOList[index] = 'images/x.png';
                      playSound('x.mp3');
                      filledBoxes = filledBoxes + 1;
                    }
                    isTurnO =! isTurnO;

                    checkWinner();

                    if(winnerO == true) {
                      playSound('winner.mp3');
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CongratulationsDialogO(
                            onPressed: () {}
                          );
                        },
                      );
                    }

                    if(winnerX == true) {
                      playSound('winner.mp3');
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CongratulationsDialogX(
                            onPressed: () {} 
                          );
                        },
                      );
                    } 

                    if(boardSize == 3) {
                      if(filledBoxes == 9 && 
                          winnerO == false && 
                          winnerX == false) {
                        playSound('equal.wav');
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CongratulationsDialogEqual(
                              onPressed: () {} 
                            );
                          },
                        );
                      }
                    }

                    if(boardSize == 4) {
                      if(filledBoxes == 16 && 
                          winnerO == false && 
                          winnerX == false) {
                        playSound('equal.wav');
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CongratulationsDialogEqual(
                              onPressed: () {} 
                            );
                          },
                        );
                      }
                    }
                  });
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: kBoxColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image(
                      image: AssetImage(XorOList[index]),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }


  void checkWinner() {
    if(boardSize == 3) {
      if(XorOList[0] == XorOList[1] &&
          XorOList[0] == XorOList[2] &&
          XorOList[0] != 'images/box.png'
      ) {
        if(XorOList[0] == txtPlayerO) {
          playerO++;
          winnerO = true;
          finishGame();
        }else {
          playerX++;
          winnerX = true;
          finishGame();
          return;
        }
      }

      if(XorOList[3] == XorOList[4] &&
          XorOList[3] == XorOList[5] &&
          XorOList[3] != 'images/box.png'
      ) {
        if(XorOList[3] == txtPlayerO) {
          playerO++;
          winnerO = true;
          finishGame();
        }else {
          playerX++;
          winnerX = true;
          finishGame();
          return;
        }
      }

      if(XorOList[6] == XorOList[7] &&
          XorOList[6] == XorOList[8] &&
          XorOList[6] != 'images/box.png'
      ) {
        if(XorOList[6] == txtPlayerO) {
          playerO++;
          winnerO = true;
          finishGame();
        }else {
          playerX++;
          winnerX = true;
          finishGame();
          return;
        }
      }

      if(XorOList[0] == XorOList[3] &&
          XorOList[0] == XorOList[6] &&
          XorOList[0] != 'images/box.png'
      ) {
        if(XorOList[0] == txtPlayerO) {
          playerO++;
          winnerO = true;
          finishGame();
        }else {
          playerX++;
          winnerX = true;
          finishGame();
          return;
        }
      }
      
      if(XorOList[1] == XorOList[4] &&
          XorOList[1] == XorOList[7] &&
          XorOList[1]!= 'images/box.png'
      ) {
        if(XorOList[1] == txtPlayerO) {
          playerO++;
          winnerO = true;
          finishGame();
        }else {
          playerX++;
          winnerX = true;
          finishGame();
          return;
        }
      }

      if(XorOList[2] == XorOList[5] &&
          XorOList[8] == XorOList[2] &&
          XorOList[2] != 'images/box.png'
      ) {
        if(XorOList[2] == txtPlayerO) {
          playerO++;
          winnerO = true;
          finishGame();
        }else {
          playerX++;
          winnerX = true;
          finishGame();
          return;
        }
      }

      if(XorOList[0] == XorOList[4] &&
          XorOList[0] == XorOList[8] &&
          XorOList[0] != 'images/box.png'
      ) {
        if(XorOList[0] == txtPlayerO) {
          playerO++;
          winnerO = true;
          finishGame();
        }else {
          playerX++;
          winnerX = true;
          finishGame();
          return;
        }
      }

      if(XorOList[2] == XorOList[4] &&
          XorOList[2] == XorOList[6] &&
          XorOList[2] != 'images/box.png'
      ) {
        if(XorOList[2] == txtPlayerO) {
          playerO++;
          winnerO = true;
          finishGame();
        }else {
          playerX++;
          winnerX = true;
          finishGame();
          return;
        }
      }

      if(filledBoxes == 9) {
        equal = equal + 1;
        finishGame();
        return; 
      } 
    }
    if(boardSize == 4) {
      if(XorOList[0] == XorOList[4] &&
          XorOList[0] == XorOList[8] &&
          XorOList[0] == XorOList[12] &&
          XorOList[0] != 'images/box.png'
      ) {
        if(XorOList[0] == txtPlayerO) {
          playerO++;
          winnerO = true;
          finishGame();
        }else {
          playerX++;
          winnerX = true;
          finishGame();
          return;
        }
      }

      if(XorOList[1] == XorOList[5] &&
          XorOList[1] == XorOList[9] &&
          XorOList[1] == XorOList[13] &&
          XorOList[1] != 'images/box.png'
      ) {
        if(XorOList[1] == txtPlayerO) {
          playerO++;
          winnerO = true;
          finishGame();
        }else {
          playerX++;
          winnerX = true;
          finishGame();
          return;
        }
      }
      
      if(XorOList[2] == XorOList[6] &&
          XorOList[2] == XorOList[10] &&
          XorOList[2] == XorOList[14] &&
          XorOList[2] != 'images/box.png'
      ) {
        if(XorOList[2] == txtPlayerO) {
          playerO++;
          winnerO = true;
          finishGame();
        }else {
          playerX++;
          winnerX = true;
          finishGame();
          return;
        }
      }

      if(XorOList[3] == XorOList[7] &&
          XorOList[3] == XorOList[11] &&
          XorOList[3] == XorOList[15] &&
          XorOList[3] != 'images/box.png'
      ) {
        if(XorOList[3] == txtPlayerO) {
          playerO++;
          winnerO = true;
          finishGame();
        }else {
          playerX++;
          winnerX = true;
          finishGame();
          return;
        }
      }

      if(XorOList[0] == XorOList[1] &&
          XorOList[0] == XorOList[2] &&
          XorOList[0] == XorOList[3] &&
          XorOList[0] != 'images/box.png'
      ) {
        if(XorOList[0] == txtPlayerO) {
          playerO++;
          winnerO = true;
          finishGame();
        }else {
          playerX++;
          winnerX = true;
          finishGame();
          return;
        }
      }

      if(XorOList[4] == XorOList[5] &&
          XorOList[4] == XorOList[6] &&
          XorOList[4] == XorOList[7] &&
          XorOList[4] != 'images/box.png'
      ) {
        if(XorOList[4] == txtPlayerO) {
          playerO++;
          winnerO = true;
          finishGame();
        }else {
          playerX++;
          winnerX = true;
          finishGame();
          return;
        }
      }
      
      if(XorOList[8] == XorOList[9] &&
          XorOList[8] == XorOList[10] &&
          XorOList[8] == XorOList[11] &&
          XorOList[8] != 'images/box.png'
      ) {
        if(XorOList[8] == txtPlayerO) {
          playerO++;
          winnerO = true;
          finishGame();
        }else {
          playerX++;
          winnerX = true;
          finishGame();
          return;
        }
      }

      if(XorOList[12] == XorOList[13] &&
          XorOList[12] == XorOList[14] &&
          XorOList[12] == XorOList[15] &&
          XorOList[12] != 'images/box.png'
      ) {
        if(XorOList[12] == txtPlayerO) {
          playerO++;
          winnerO = true;
          finishGame();
        }else {
          playerX++;
          winnerX = true;
          finishGame();
          return;
        }
      }

      if(XorOList[0] == XorOList[5] &&
          XorOList[0] == XorOList[10] &&
          XorOList[0] == XorOList[15] &&
          XorOList[0] != 'images/box.png'
      ) {
        if(XorOList[0] == txtPlayerO) {
          playerO++;
          winnerO = true;
          finishGame();
        }else {
          playerX++;
          winnerX = true;
          finishGame();
          return;
        }
      }

      if(XorOList[3] == XorOList[6] &&
          XorOList[3] == XorOList[9] &&
          XorOList[3] == XorOList[12] &&
          XorOList[3] != 'images/box.png'
      ) {
        if(XorOList[3] == txtPlayerO) {
          playerO++;
          winnerO = true;
          finishGame();
        }else {
          playerX++;
          winnerX = true;
          finishGame();
          return;
        }
      }

      if(filledBoxes == 16) {
        equal = equal + 1;
        finishGame();
        return; 
      } 
    }
  }

  void finishGame() {
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        for(int i = 0; i < XorOList.length; i++) {
          XorOList[i] = 'images/box.png';
          filledBoxes = 0;
          winnerO = false;
          winnerX = false;
        }
      });
    });
  }

  void clearGame() {
    setState(() {
      for(int i = 0; i < XorOList.length; i++) {
        XorOList[i] = 'images/box.png';
      }
      playerO = 0;
      playerX = 0;
      filledBoxes = 0;
      equal = 0;
      winnerO = false;
      winnerX = false;
    });
  }


  playSound(sound) {
    final player = AudioPlayer();
    if(isMuted) {
      Null;
    } else {
      player.play(AssetSource(sound));
    }
  }

  Widget getScoreBoard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            height: 90,
            width: 110,
            decoration: BoxDecoration(
              color: kScoreBoardBox,
              borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'images/black-X.png',
                        height: 30,
                        width: 30,
                      ),
                      Text(
                        'بازیکن',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: kTextColor
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '$playerX',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: kNumberColor
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Container(
          height: 90,
          width: 110,
            decoration: BoxDecoration(
              color: kScoreBoardBox,
              borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'مساوی',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: kTextColor
                  ),
                ),
                Text(
                  '$equal',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: kNumberColor
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            height: 90,
            width: 110,
            decoration: BoxDecoration(
              color: kScoreBoardBox,
              borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'images/black-O.png',
                        height: 30,
                        width: 30,
                        ),
                      Text(
                        'بازیکن',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: kTextColor
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '$playerO',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: kNumberColor
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}