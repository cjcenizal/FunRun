package com.funrun.controller.commands {
	
	import com.funrun.controller.signals.AddCompetitorRequest;
	import com.funrun.controller.signals.DrawReadyListRequest;
	import com.funrun.controller.signals.StartGameLoopRequest;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.vo.CompetitorVo;
	
	import org.robotlegs.mvcs.Command;
	
	import playerio.Message;

	public class HandleGameInitCommand extends Command {
		
		// Arguments.
		
		[Inject]
		public var message:Message;
		
		// Models.
		
		[Inject]
		public var playerModel:PlayerModel;
		
		// Commands.
		
		[Inject]
		public var addCompetitorRequest:AddCompetitorRequest;
		
		[Inject]
		public var startGameLoopRequest:StartGameLoopRequest;
		
		[Inject]
		public var drawReadyListRequest:DrawReadyListRequest;
		
		override public function execute():void {
			// Add pre-existing competitors.
			for ( var i:int = 0; i < message.length; i += 7 ) {
				var inGameId:int = message.getInt( i );
				if ( inGameId != playerModel.inGameId ) {
					var name:String = message.getString( i + 1 );
					var x:Number = message.getNumber( i + 2 );
					var y:Number = message.getNumber( i + 3 );
					var z:Number = message.getNumber( i + 4 );
					var isDucking:Boolean = message.getBoolean( i + 5 );
					var isReady:Boolean = message.getBoolean( i + 6 );
					var competitor:CompetitorVo = new CompetitorVo( inGameId, name );
					competitor.updatePosition( x, y, z );
					competitor.isDucking = isDucking;
					competitor.isReady = isReady;
					addCompetitorRequest.dispatch( competitor );
				}
			}
			drawReadyListRequest.dispatch();
			startGameLoopRequest.dispatch();
		}
	}
}
