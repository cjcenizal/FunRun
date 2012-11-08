package com.funrun.model
{
	import com.funrun.model.vo.CharacterVo;
	
	import org.robotlegs.mvcs.Actor;
	
	public class CharactersModel extends Actor
	{
		
		private var characters:Object;
		
		public function CharactersModel()
		{
			super();
			characters = {};
		}
		
		public function add( vo:CharacterVo ):void {
			characters[ vo.id ] = vo;
		}
		
		public function getWithId( id:String ):CharacterVo {
			return characters[ id ];
		}
	}
}