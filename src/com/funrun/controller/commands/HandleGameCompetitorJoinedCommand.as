package com.funrun.controller.commands {

	import com.funrun.controller.signals.AddCompetitorRequest;
	import com.funrun.controller.signals.DrawGameMessageRequest;
	import com.funrun.controller.signals.DrawReadyListRequest;
	import com.funrun.controller.signals.LogMessageRequest;
	import com.funrun.controller.signals.vo.LogMessageVo;
	import com.funrun.model.CompetitorsModel;
	import com.funrun.model.PlayerModel;
	import com.funrun.model.vo.CompetitorVo;
	
	import org.robotlegs.mvcs.Command;
	
	import playerio.Message;

	public class HandleGameCompetitorJoinedCommand extends Command {
		
		// Arguments.
		
		[Inject]
		public var message:Message;
		
		// Models.
		
		[Inject]
		public var playerModel:PlayerModel;
		
		[Inject]
		public var competitorsModel:CompetitorsModel;
		
		// Commands.
		
		[Inject]
		public var addCompetitorRequest:AddCompetitorRequest;
		
		[Inject]
		public var displayMessageRequest:DrawGameMessageRequest;
		
		[Inject]
		public var logMessageRequest:LogMessageRequest;
		
		[Inject]
		public var drawReadyListRequest:DrawReadyListRequest;
		
		override public function execute():void {
			var inGameId:int = message.getInt( 0 );
			var name:String = message.getString( 1 );
			// We receive ourselves as new players, so screen ourselves out.
			if ( inGameId != playerModel.inGameId ) {
				var x:Number = message.getNumber( 2 );
				var y:Number = message.getNumber( 3 );
				var z:Number = message.getNumber( 4 );
				var isDucking:Boolean = message.getBoolean( 5 );
				var isReady:Boolean = message.getBoolean( 6 );
				var competitor:CompetitorVo = new CompetitorVo( inGameId, name );
				competitor.updatePosition( x, y, z );
				competitor.isDucking = isDucking;
				competitor.isReady = isReady;
				addCompetitorRequest.dispatch( competitor );
				displayMessageRequest.dispatch( competitor.name + " has joined the game." );
				logMessageRequest.dispatch( new LogMessageVo( this, "Competitor " + competitor.id + " (" + competitor.name + ") joined the game." ) );
				drawReadyListRequest.dispatch();
			}
		}
	}
}
