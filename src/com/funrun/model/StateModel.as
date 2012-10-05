package com.funrun.model
{
	import org.robotlegs.mvcs.Actor;

	public class StateModel extends Actor
	{
		
	//	private static const MAIN_MENU:String = "MAIN_MENU";
	//	private static const WAITING_FOR_PLAYERS:String = "WAITING_FOR_PLAYERS";
	//	private static const RUNNING:String = "RUNNING";
	//	private static const SHOWING_RESULTS:String = "SHOWING_RESULTS";
		
	//	private var _gameState:String;

		public var canDie:Boolean = false;
		public var canMoveForward:Boolean = false;
		
		public function StateModel() {
			super();
		}
		
		
	/*	public function waitForPlayers():void {
			_gameState = WAITING_FOR_PLAYERS;
		}
		
		public function showMainMenu():void {
			_gameState = MAIN_MENU;
		}
		
		public function startRunning():void {
			_gameState = RUNNING;
		}
		
		public function showResults():void {
			_gameState = SHOWING_RESULTS;
		}
		
		public function isInGame():Boolean {
			return (
				isWaitingForPlayers()
				|| isRunning() 
				|| isShowingResults() );
		}
		
		public function isWaitingForPlayers():Boolean {
			return _gameState == WAITING_FOR_PLAYERS;
		}
		
		public function isRunning():Boolean {
			return _gameState == RUNNING;
		}
		
		public function isShowingResults():Boolean {
			return _gameState == SHOWING_RESULTS;
		}*/
	}
}