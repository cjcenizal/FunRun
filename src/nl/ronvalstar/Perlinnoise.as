package nl.ronvalstar {

	import flash.text.*;
	import flash.display.*;
	import flash.events.*;
	import flash.utils.getTimer;
	//import nl.ronvalstar.Time;
	import nl.ronvalstar.math.Perlin;

	public class Perlinnoise extends Sprite {
		//
		private static var mNode:node;
		private static var iW:int;
		private static var iH:int;
		//
		public function Perlinnoise() {
			//
			iW = this.stage.stageWidth;
			iH = this.stage.stageHeight;
			//
			var iPrts:int = 4;
			var iCSize:Number = iW/iPrts;
			for (var k:uint;k<iPrts*iPrts;k++) {
				var iX:Number = (k%iPrts);
				var iY:Number = Math.floor(k/iPrts);
				Perlin.octaves = iX+2;
				Perlin.falloff = iY==0?.75: (iPrts-iY)*.25;//(1/((iY)*2)) ;
				if (k<=iPrts) Perlin.seed = Math.round(Math.random()*123);
				//
				//
				var dCanvas:BitmapData = new BitmapData(iCSize,iCSize,false,0x000000);
				//
				//
				var iTime:Number = getTimer();
				dCanvas.perlinNoise(30, 30, iX+2, Perlin.seed, true, true, 7, true, null);
				var iSpeed:Number = getTimer()-iTime;
				trace("bmd noise: "+iSpeed);
				//
				//
				iTime = getTimer();
				for (var i:uint=0;i<dCanvas.width;i++) {
					for (var j:uint=0;j<dCanvas.height;j++) {
						var fNoise:Number = Perlin.noise( i/iCSize*2, j/iCSize*2, 1 );
						var iNoise:int = int( (.5+1.*(fNoise-.5))*255 );
						var iColor:uint = iNoise << 16 | iNoise << 8 | iNoise;
						dCanvas.setPixel(i,j,iColor)
					}
				}
				var iSpied:Number = getTimer()-iTime;
				trace("own noise: "+iSpied);
				trace("comp: "+iSpied/iSpeed);
				trace("");
				//
				var oCanvas:Bitmap = new Bitmap(dCanvas,"auto",false);
				var mCanvas:Sprite = new Sprite();
				mCanvas.addChild(oCanvas);
				mCanvas.x = iX*iCSize;
				mCanvas.y = iY*iCSize;
				this.addChild(mCanvas);
				//
				mLabel = new TextField();
				mLabel.text = "";
				mLabel.text += "octaves: "+Perlin.octaves+"\n";
				mLabel.text += "falloff: "+Perlin.falloff+"\n";
				mLabel.text += "seed: "+Perlin.seed+"\n";
				mLabel.multiline = true;
				mLabel.textColor = 0xFFFFFF;
				mLabel.width = iCSize;
				oFrm = new TextFormat();
				oFrm.font = "Verdana";
				oFrm.color = 0xffffff;
				oFrm.size = 8;
				mLabel.setTextFormat(oFrm);
				mCanvas.addChild(mLabel);
				//
			}
			//
			//Time.init(this);
			//Time.fpsCount(true);
			//
			mNode = new node();
			mNode.scaleX = .1;
			mNode.scaleY = .1;
			this.addChild(mNode);
			//
			Perlin.octaves = 2;
			Perlin.falloff = .5;
			this.addEventListener( Event.ENTER_FRAME, run);
		}
		private function run(e:Event) {
			var iTimeX:Number = getTimer()*.00021;
			var iTimeY:Number = iTimeX+123.123;
			mNode.x = iW*.5 + 3*iW*(Perlin.noise(iTimeX)-.5);
			mNode.y = iH*.5 + 3*iH*(Perlin.noise(iTimeY)-.5);
		}
	}
}