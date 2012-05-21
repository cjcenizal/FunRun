package com.cenizal.ui {
	
	import flash.display.DisplayObjectContainer;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	public class AbstractLabel extends AbstractComponent {

		public static const DEFAULT_FONT:String = "ArialRound";
		[Embed( source = "Arial Rounded Bold.ttf", embedAsCFF = "false", fontName = "ArialRound", mimeType = "application/x-font" )]
		private var GenericFontClass:Class;

		protected var _wordWrap:Boolean = false;
		protected var _text:String = "";
		protected var _fontColor:uint;
		protected var _fontSize:Number;
		protected var _isInput:Boolean = false;
		protected var _alignment:String = TextFieldAutoSize.LEFT;
		protected var _tf:TextField;

		public function AbstractLabel( parent:DisplayObjectContainer = null, x:Number = 0, y:Number = 0, text:String = null, fontSize:Number = 12, fontColor:uint = 0 ) {
			super( parent, x, y );
			_fontSize = fontSize;
			_fontColor = fontColor;
			
			_tf = new TextField();
			_tf.height = height;
			_tf.multiline = true;
			_tf.embedFonts = true;
			_tf.mouseEnabled = enabled;
			_tf.defaultTextFormat = new TextFormat( DEFAULT_FONT, _fontSize, _fontColor );
			_tf.htmlText = _text;
			_tf.alwaysShowSelection = true;
			addChild( _tf );
			
			if ( text ) {
				this.text = text;
			}
		}

		override public function destroy():void {
			removeChild( _tf );
			_tf = null;
			super.destroy();
		}

		//===================================
		//		 Public.
		//===================================

		override public function draw():void {
			if ( _wordWrap ) {
				_tf.autoSize = _alignment;
				_tf.wordWrap = true;
				_tf.width = width;
				_tf.htmlText = _text;
				_height = _tf.height;
			} else {
				_tf.autoSize = _alignment;
				_tf.wordWrap = false;
				_tf.htmlText = _text;
				_width = _tf.width;
				_height = _tf.height;
			}
			if ( _alignment == TextFieldAutoSize.RIGHT ) {
				_tf.x = -_tf.width;
			} else {
				_tf.x = 0;
			}
			super.draw();
		}

		//===================================
		//		 Accessors.
		//===================================

		public function set defaultTextFormat( mFormat:TextFormat ):void {
			_tf.defaultTextFormat = mFormat;
		}

		public function set text( t:String ):void {
			_text = t;
			if ( _text == null ) {
				_text = "";
			}
			invalidate();
		}

		public function get text():String {
			return _tf.text;
		}

		public function set wordWrap( b:Boolean ):void {
			_wordWrap = b;
			invalidate();
		}

		public function get wordWrap():Boolean {
			return _wordWrap;
		}

		public function get textField():TextField {
			return _tf;
		}

		public function get length():uint {
			return _text.length;
		}

		public function set italics( mVal:Boolean ):void {
			if ( mVal ) {
				this.transform.matrix = new Matrix( 1, 0, -.2 );
			} else {
				this.transform.matrix.identity();
			}
		}
	}
}
