import 'package:flutter/material.dart';
import 'package:homework3/%E0%B8%B5utils/helpers.dart';
import 'package:homework3/Pages/game.dart';

class GuessPage extends StatefulWidget {
  const GuessPage({Key? key}) : super(key: key);

  @override
  State<GuessPage> createState() => _GuessPageState();
}

class _GuessPageState extends State<GuessPage> {
  var _input='';
  var _feedbackText ='ทายเลข 1 ถึง 100';
  final _game = Game();
  var guess;
  int count =0;
  void _handleClickGuess(){
    print( 'ButtonClick');
    count++;

    print(guess);
      if(guess == null){
        showMyDialog(context, 'ERROR', 'กรุณากรอกตัวเลข');
        count = count-1;
      }
      else {
        var result = _game.doGuess(guess);
        if (result == Result.tooHigh) {
          // ทายมากไป
          print('Too high');
          setState(() {
            _feedbackText = '$guess : มากเกินไป';
            _input = '';
            guess =null;
          });
        }else if (result == Result.tooLow) {
          // ทายน้อยไป
          print('Too low');
          setState(() {
            _feedbackText = '$guess : น้อยเกินไป';
            _input = '';
            guess =null;
          });
        } else {
          // ทายถูก
          print('Correct');
          setState(() {
            _feedbackText = '$guess : ถูกต้อง (ทาย $count ครั้ง)';
          });
      }
      }

  }
  void _NumberButton(int num){
    setState((){
      if(_input.length<3){
        if(num==-1){
          _input = _input.substring(0, _input.length-1);
        }else if (num==-2){
          _input = '';
        }
        else{
          _input = _input + num.toString();
        }
      }else{
        if(num==-1){
          _input = _input.substring(0, _input.length-1);
        }else if (num==-2){
          _input = '';
        }
      }
      guess = int.tryParse(_input);
    });
  }
  // override
  Widget _buildNumberButton(int num){
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: (){ //callback function
          _NumberButton(num);
        },
        child : Container(
          width: 60.0,
          height: 35.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(3.0)),
              border:  Border.all(
                color: Color(0xFF333333),
                width: 1.0,
              )

          ),
          child: num==-1 ? Icon(Icons.backspace_outlined) : num == -2 ?Icon(Icons.close):Text(
            num.toString(),
          ),
        ) ,
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GUESS THE NUMBER'),
      ),
      body: Container(
        margin: const EdgeInsets.all(15.0),
        padding: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: Color(0XFFE1BEE7),
        ),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/guess_logo.png',width: 90.0,),

                Column(
                  children: [
                    Text('GUESS',style: new TextStyle(fontSize: 35.0,fontWeight: FontWeight.bold),),
                    Text('THE NUMBER',style: new TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),

                  ],
                ),
              ],
            ),SizedBox(height: 80.0,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(_input,style: new TextStyle(fontSize: 50.0,fontWeight: FontWeight.bold),),
          ],
        ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(_feedbackText,style: new TextStyle(fontSize: 25.0,)),
              ],
            ),


          SizedBox(height: 16.0,),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildNumberButton(1),
                  _buildNumberButton(2),
                  _buildNumberButton(3),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildNumberButton(4),
                  _buildNumberButton(5),
                  _buildNumberButton(6),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildNumberButton(7),
                  _buildNumberButton(8),
                  _buildNumberButton(9),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildNumberButton(-2),
                  _buildNumberButton(0),
                  _buildNumberButton(-1),

                ],

              ),
              SizedBox(height: 16.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _handleClickGuess,
                    child: const Text('guess'),
                  ),
                ],

              ),
            ],
          ),

        ],
      ),

      ),
    );
  }
}
