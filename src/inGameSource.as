package  {
	import flash.display.MovieClip;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class inGameSource extends MovieClip
	{
		var inputFocus:Number;	//입력할 박스
		var gameLevel:Number; 	//게임레벨
		var valueRange:Number;	//랜덤 숫자범위
		var quizAnswer; 			//퀴즈정답

		public function inGameSource() {}//생성자
		
		public function gamaStart()
		{
			gameLevel  = 1;
			valueRange = 10;
			quizObjectCreate();
			trace("start");
		}
		
		private function quizObjectCreate()
		{
			var quizboxValue = new Array();
			var operator;	 //오퍼레이터(1-더하기, 2-빼기, 3-곱하기, 4-나누기)
			
			if(gameLevel<5) {
				inputFocus = 3;
				operator	  = 1;
				quizboxValue = quizCreate(operator);
			}else{
				inputFocus 	 = Math.floor((Math.random()*4)+1);
				operator		 = Math.floor((Math.random()*2)+1);
				quizboxValue = quizCreate(operator);
			}
			trace(quizboxValue);
			
			for(var i=0; i<3; i++){
				(root as MovieClip).quizObject["inputBox"+(i+1)].text = quizboxValue[i];
				trace(quizboxValue[i]);
			}
			
			var inputBox = (root as MovieClip).quizObject["inputBox"+inputFocus];
			inputBox.text = ' ';
			quizAnswer  = quizboxValue[inputFocus];
			
			stage.addEventListener(KeyboardEvent.KEY_UP, quizKeyEvent);
		}//문제 객체 생성(박스들)
		
		private function quizCreate(operator):Array
		{
			var quizboxValue = new Array(3);
			
			quizboxValue[0] = Math.floor((Math.random()*valueRange)+1);
			quizboxValue[1] = Math.floor((Math.random()*valueRange)+1);
			switch(operator){
				case 1:
					quizboxValue[2] = quizboxValue[0] + quizboxValue[1];
					break;
				case 2:
					quizboxValue[2] = quizboxValue[0] - quizboxValue[1];
					break;
				case 3:
					quizboxValue[2] = quizboxValue[0] * quizboxValue[1];
					break;
				case 4:
					quizboxValue[2] = quizboxValue[0] / quizboxValue[1];
					break;
			}
			
			return quizboxValue;
			
		}//문제 생성
		
		private function quizKeyEvent(e:KeyboardEvent):void
		{
			var keyCode = e.keyCode;
			var inputBox = (root as MovieClip).quizObject["inputBox"+inputFocus];
			trace(keyCode);
			if(keyCode>=48 && keyCode<=57 ){
				inputBox.text += keyCode-48;
			}else if(keyCode>=96 && keyCode<=105){
				inputBox.text += keyCode-96;
			}
			
			if( keyCode == Keyboard.BACKSPACE){inputBox.text = inputBox.text/10;}
			
			if ( keyCode == Keyboard.SPACE || keyCode == Keyboard.ENTER){
				var userAnswer = inputBox.text;
				if(userAnswer == quizAnswer) trace('정답!');
				else								  trace('땡');
			}
		}
		
	}
}