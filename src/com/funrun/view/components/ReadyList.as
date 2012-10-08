package com.funrun.view.components
{
	import com.cenizal.ui.AbstractComponent;
	import com.cenizal.ui.AbstractLabel;
	
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;
	
	public class ReadyList extends AbstractComponent
	{
		
		// Data.
		private var _ids:Object;
		private var _pos:Number;
		
		public function ReadyList(parent:DisplayObjectContainer=null, x:Number=0, y:Number=0)
		{
			super(parent, x, y);
			_ids = {};
			_pos = 0;
		}
		
		public function clear():void {
			for ( var id:String in _ids ) {
				remove( int( id ) );
			}
			_ids = {};
			_pos = 0;
		}
		
		public function add( id:int, name:String, isReady:Boolean ):void {
			 var label:AbstractLabel = new AbstractLabel( this );
			 label.text = ( isReady ) ? name + " is ready!" : name;
			 _ids[ id ] = label;
			 addChild( label );
			 label.y = _pos;
			 _pos += 20;
		}
		
		public function remove( id:int ):void {
			removeChild( _ids[ id ] );
			delete _ids[ id ];
		}
	}
}