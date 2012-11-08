package com.funrun.services.parsers
{
	public class CharacterParser extends AbstractParser
	{
		
		private const ID:String = "id";
		private const FOLDER:String = "folder";
		private const MODEL:String = "model";
		private const SCALE:String = "scale";
		private const MAPS:String = "maps";
		private const ANIMATIONS:String = "animations";
		private const FILE:String = "file";
		private const SPEED:String = "speed";
		
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
		
		public function get scale():Number {
			return data[ SCALE ] || 1;
		}
		
		public function getAnimationFileWithId( id:String ):String {
			return data[ ANIMATIONS ][ id ][ FILE ];
		}
		
		public function getAnimationSpeedWithId( id:String ):Number {
			return data[ ANIMATIONS ][ id ][ SPEED ];
		}
		
		public function getMapWithId( id:String ):String {
			return data[ MAPS ][ id ];
		}
	}
}