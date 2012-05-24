package com.funrun.view.components {
	
	import com.cenizal.ui.AbstractComponent;
	import com.cenizal.ui.AbstractLabel;
	import com.cenizal.util.Center;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	public class LoginStatusView extends AbstractComponent {
		
		private var _label:AbstractLabel;
		
		public function LoginStatusView( parent:DisplayObjectContainer = null, x:Number = 0, y:Number = 0 ) {
			super( parent, x, y );
			_label = new AbstractLabel( this, 0, 0, "Log in status", 24, 0x5555FF );
		}
		
		override public function draw():void {
			super.draw();
			_label.draw();
			_height = _label.height;
			_width = _label.width;
		}
		
		public function set status( val:String ):void {
			_label.text = val;
			_label.draw();
			Center.horizontal( _label, stage );
			_label.y = stage.stageHeight - _label.height - 20;
		}
	}
}
