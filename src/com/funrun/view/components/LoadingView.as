package com.funrun.view.components
{
	import com.cenizal.ui.AbstractComponent;
	import com.cenizal.ui.AbstractLabel;
	import com.cenizal.ui.Image;
	import com.funrun.view.components.ui.TextNote;
	import com.greensock.TweenMax;
	import com.greensock.easing.*;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;

	public class LoadingView extends AbstractComponent
	{
		
		[Embed (source="embed/loading_blackout.png" )]
		private var Blackout:Class;
		
		[Embed (source="embed/loading_arrows.png" )]
		private var Spinner:Class;
		
		private var _blackout:Bitmap;
		private var _spinner:Image;
		private var _message:TextNote;
		
		public function LoadingView( parent:DisplayObjectContainer )
		{
			super( parent );
		}
		
		public function init():void {
			_blackout = new Blackout();
			addChild( _blackout );
			var spinner:Bitmap = new Spinner();
			spinner.smoothing = true;
			_spinner = new Image( this, 0, 0, spinner, true );
			_spinner.x = stage.stageWidth * .5;
			_message = new TextNote( this );
			_blackout.visible = true;
			_blackout.alpha = 0;
			_spinner.y = _message.y = -200;
		}
		
		public function show():void {
			_blackout.visible = true;
			TweenMax.to( _blackout, 1, { alpha: 1 } );
			TweenMax.to( _spinner, .8, { y: stage.stageHeight * .5, ease: Back.easeOut } );
			TweenMax.to( _message, .8, { y: stage.stageHeight * .5, ease: Back.easeOut, delay: .1 } );
			stage.addEventListener( Event.ENTER_FRAME, onEnterFrame );
			mouseEnabled = true;
		}
		
		public function hide():void {
			TweenMax.to( _blackout, 1, { alpha: 0, onComplete: function():void { _blackout.visible = false; stage.removeEventListener( Event.ENTER_FRAME, onEnterFrame ); } } );
			TweenMax.to( _spinner, .8, { y: -200, ease: Back.easeIn } );
			TweenMax.to( _message, .8, { y: -200, ease: Back.easeIn, delay: .1 } );
			mouseEnabled = false;
		}
		
		private function onEnterFrame( e:Event ):void {
			_spinner.rotation += 10;
		}
		
		public function set message( val:String ):void {
			_message.text = val;
			_message.x = ( stage.stageWidth - _message.width ) * .5;
		}
	}
}