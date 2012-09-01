package nl.ronvalstar {

	import flash.text.*;
	import flash.display.*;
	import flash.events.*;
	import flash.utils.getTimer;

	public class Time {
		//
		private static var bInit:Boolean = false;
		//
		private static var mParent:DisplayObject;
		//
		private static var mLabel:TextField;
		private static var oFrm:TextFormat;
		//
		private static var iOldMs:Number;
		private static var fDeltaT:Number;
		//
		private static var bShow:Boolean;
		//
		///////////
		// init //
		public static function init(oDisplay:DisplayObject):void {
			trace("Time init "+oDisplay); // trace init
			if (!bInit) {
				mParent = oDisplay;
				mParent.addEventListener( Event.ENTER_FRAME, run);
				//
				mLabel = new TextField();
				mLabel.text = "fps: ";
				mLabel.background = true;
				mLabel.textColor = 0xFFFFFF;
				mLabel.backgroundColor = 0x800000;
				mLabel.backgroundColor = 0x800000;
				mLabel.height = 17;
				mLabel.width = mParent.stage.stageWidth;
				oFrm = new TextFormat();
				oFrm.font = "Verdana";
				oFrm.color = 0xffffff;
				oFrm.size = 10;
				mLabel.setTextFormat(oFrm);
				bShow = false;
				//
				bInit = true;
			}
		}
		//
		//////////
		// run //
		public static function run(e:Event=null):void {
			var iDeltaTms:Number = getTimer() - Time.iOldMs;
			iOldMs = getTimer();
			fDeltaT = iDeltaTms/1000.0;
			if (bShow) {
				mLabel.text = "fps: "+String(Math.round(1/fDeltaT));
				mLabel.setTextFormat(oFrm);
			}
		}
		//
		////////////////
		// getDeltaT //
		public static function get deltaT():Number {
			return fDeltaT?fDeltaT:1;
		}
		//
		///////////////
		// fpsCount //
		public static function fpsCount(bSet:Boolean=false):void {
			if (bSet!=bShow) {
				if (bSet!=bShow)	mParent.addChild(mLabel);
				else				mParent.removeChild(mLabel);
				bShow = bSet;
			}
		}
	}
}