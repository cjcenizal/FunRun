package com.funrun.game.model.parsers
{
	import away3d.primitives.PrimitiveBase;

	public class BlockParser extends AbstractParser
	{
		
		private const FACES:String = "faces";
		private const TOP:String = "t";
		private const BOTTOM:String = "b";
		private const LEFT:String = "l";
		private const RIGHT:String = "r";
		private const FRONT:String = "f";
		private const BACK:String = "a"; // a is for ass... or aft.
		private const ALL:String = "all";
		
		private var _id:String;
		private var _filename:String;
		private var _faces:Object;
		private var _numFaces:int = 0;
		
		public var geo:PrimitiveBase;
		
		public function BlockParser( data:Object )
		{
			super( data );
			_id = new IdParser( data ).id;
			_filename = new FilenameParser( data ).filename;
			_faces = data[ FACES ] || {};
			for ( var key:String in _faces ) {
				_numFaces++;
			}
		}
		
		public function get id():String {
			return _id;
		}
		
		public function get filename():String {
			return _filename;
		}
		
		public function get numFaces():int {
			return _numFaces;
		}
		
		public function get hasFrontFace():Boolean {
			return frontFace;
		}
		
		public function get frontFace():String {
			return _faces[ ALL ] || _faces[ FRONT ];
		}
		
		public function get hasBackFace():Boolean {
			return backFace;
		}
		
		public function get backFace():String {
			return _faces[ ALL ] || _faces[ BACK ];
		}

		public function get hasTopFace():Boolean {
			return topFace;
		}
		
		public function get topFace():String {
			return _faces[ ALL ] || _faces[ TOP ];
		}
		
		public function get hasBottomFace():Boolean {
			return bottomFace;
		}
		
		public function get bottomFace():String {
			return _faces[ ALL ] || _faces[ BOTTOM ];
		}
		
		public function get hasLeftFace():Boolean {
			return leftFace;
		}
		
		public function get leftFace():String {
			return _faces[ ALL ] || _faces[ LEFT ];
		}
		
		public function get hasRightFace():Boolean {
			return rightFace;
		}
		
		public function get rightFace():String {
			return _faces[ ALL ] || _faces[ RIGHT ];
		}
		
		private function get allFaces():String {
			return _faces[ ALL ];
		}
	}
}