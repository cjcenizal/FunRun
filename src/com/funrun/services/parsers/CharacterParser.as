package com.funrun.services.parsers
{
	public class CharacterParser extends AbstractParser
	{
		
		private const ID:String = "id";
		private const FOLDER:String = "folder";
		private const MODEL:String = "model";
		private const ANIMATIONS:String = "animations";
		
		public function CharacterParser( data:Object )
		{
			super( data );	
		}
		
		public function get id():String {
			return data[ ID ];
		}
		
		public function get folder():String {
			return data[ FOLDER ];
		}
		
		public function get model():String {
			return data[ MODEL ];
		}
		
		public function getAnimationWithId( id:String ):String {
			return data[ ANIMATIONS ][ id ];
		}
	}
}