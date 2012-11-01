package com.funrun.model
{
	import away3d.entities.Mesh;
	
	import com.funrun.model.vo.BlockStyleVo;
	
	import org.robotlegs.mvcs.Actor;
	
	public class BlockStylesModel extends Actor
	{
		private var _currentStyle:BlockStyleVo;
		private var _styles:Object;
		private var _stylesArr:Array;
		
		public function BlockStylesModel()
		{
			super();
			_styles = {};
			_stylesArr = [];
		}
		
		public function add( style:BlockStyleVo ):void {
			style.index = _stylesArr.length;
			_styles[ style.id ] = style;
			_stylesArr.push( style );
		}
		
		public function getStyle( id:String ):BlockStyleVo {
			return _styles[ id ];
		}
		
		public function getStyleAt( index:int ):BlockStyleVo {
			return _stylesArr[ index ];
		}
		
		public function getMeshCloneForBlock( id:String ):Mesh {
			return _currentStyle.getRandomMesh( id ).clone() as Mesh;
		}
		
		public function set currentStyle( style:BlockStyleVo ):void {
			_currentStyle = style;
		}
		
		public function get currentStyle():BlockStyleVo {
			return _currentStyle;
		}
		
		public function get numStyles():int {
			return _stylesArr.length;
		}
	}
}