package com.funrun.mainmenu {
	
	import com.cenizal.ui.AbstractLabel;
	import com.cenizal.ui.DummyButton;
	import com.cenizal.util.Center;
	import com.funrun.game.view.components.TrackView;
	
	import flash.display.Bitmap;
	import flash.display.Graphics;
	import flash.display.StageQuality;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.robotlegs.utilities.modular.mvcs.ModuleContextView;
	
	public class MainMenuModule extends ModuleContextView {
		
		[Embed (source="embed/logo.jpg" )]
		private var Logo:Class;
		
		private var _isRunning:Boolean = false;
		private var _track:TrackView;
		private var _startGameButton:DummyButton;
		
		public function MainMenuModule() {
			super();
			context = new MainMenuContext( this );
			visible = false;
		}
		
		public function build():void {
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		private function onAddedToStage( e:Event ):void {
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			var g:Graphics = this.graphics;
			g.beginFill( 0xffffff );
			g.drawRect( 0, 0, stage.stageWidth, stage.stageHeight );
			g.endFill();
			var logo:Bitmap = new Logo();
			addChild( logo );
			Center.horizontal( logo, this );
			logo.y = 20;
			_startGameButton = new DummyButton( this, 0, logo.y + logo.height + 40, onClick, "Start game", 0xaaaaaa );
			_startGameButton.draw();
			Center.horizontal( _startGameButton, this );
		}
		
		private function onClick( e:MouseEvent ):void {
			dispatchEvent( new Event( "CLICK" ) );
		}
		
		public function startRunning():void {
			if ( !_isRunning ) {
				this.visible = true;
				_isRunning = true;
				stage.quality = StageQuality.BEST;
			}
		}
		
		public function stopRunning():void {
			this.visible = false;
			_isRunning = false;
		}
		
		public function get isRunning():Boolean {
			return _isRunning;
		}
	}
}
