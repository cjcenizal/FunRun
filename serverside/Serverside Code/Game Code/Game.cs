using System;
using System.Collections.Generic;
using System.Text;
using System.Collections;
using PlayerIO.GameLibrary;
using System.Drawing;

namespace FunRun {
	
	// Each player that joins the game will have these attributes.
	public class Player : BasePlayer {
		//public bool isDead = false;
		public bool isDucking = false;
		public string name = "Anonymous";
		public double x = 0;
		public double y = 0;
		public double z = 0;
		public Player() {
		}
	}

	[RoomType("Game")]
	public class GameCode : Game<Player> {

		// Game state.
		enum GameState { WAITING_FOR_PLAYERS, COUNTING_DOWN, FINAL_COUNTDOWN, PLAYING };
		private int currentGameState = ( int ) GameState.WAITING_FOR_PLAYERS;

		// Requirements.
		private const int MIN_REQUIRED_NUM_PLAYERS = 2;

		// Countdown.
		private DateTime countdownStartTime;
		private int maxSeconds = 15;
		private double secondsRemaining = 0;
		private int minJoinTime = 5;

		// Obstacle generation.
		private int randomSeed = ( new Random() ).Next();

		public override void GameStarted() {
			AddTimer( delegate {
				Update();
			}, 100 );
		}

		public override bool AllowUserJoin( Player player ) {
			// Return true if we are still counting down, but not in the final countdown.
			return ( currentGameState == ( int ) GameState.WAITING_FOR_PLAYERS
			        || currentGameState == ( int ) GameState.COUNTING_DOWN );
			//return ( PlayerCount == 0 ); // For testing only.
		}

		public override void UserJoined( Player player ) {
			if ( PlayerCount == MIN_REQUIRED_NUM_PLAYERS ) {
				currentGameState = ( int ) GameState.COUNTING_DOWN;
				countdownStartTime = DateTime.UtcNow;
			}

			// Assign user-provided data.
			player.name = player.JoinData[ "name" ];

			// Create init message for the joining player.
			Message initMessage = Message.Create( "i" );

			// Tell player their own id
			initMessage.Add( player.Id );

			// Random seed for obstacles.
			initMessage.Add( randomSeed );
			
			// Update and add time remaining.
			UpdateSecondsRemaining();
			initMessage.Add( secondsRemaining );

			// Add the current state of all players to the init message.
			foreach ( Player p in Players ) {
				initMessage.Add( p.Id, p.name, p.x, p.y, p.z, p.isDucking );
			}
			
			// Send init message to player.
			player.Send( initMessage );

			// Let everyone know who's here.
			Message newPlayerMessage = Message.Create( "n" );
			newPlayerMessage.Add( player.Id, player.name, player.x, player.y, player.z, player.isDucking );
			Broadcast( newPlayerMessage );
		}

		public override void UserLeft( Player player ) {
			// Restart countdown if necessary.
			if ( currentGameState == ( int ) GameState.COUNTING_DOWN
			    || currentGameState == ( int ) GameState.FINAL_COUNTDOWN
			    ) {
				if ( PlayerCount < MIN_REQUIRED_NUM_PLAYERS ) {
					currentGameState = ( int ) GameState.WAITING_FOR_PLAYERS;
				}
			}
			// Inform all other players that user left.
			Broadcast( "l", player.Id );
		}
		
		public override void GotMessage( Player player, Message message ) {
			switch ( message.Type ) {
				case "u": // Update state.
					// Update internal representation of player.
					player.x = message.GetDouble( 0 );
					player.y = message.GetDouble( 1 );
					player.z = message.GetDouble( 2 );
					player.isDucking = message.GetBoolean( 3 );
					break;
			}
		}

		// This method is called when the last player leaves the room, and it's closed down.
		public override void GameClosed() {
		}

		private void Update() {
			// Create update message.
			Message updateMessage = Message.Create( "u" );

			// Add time left in countdown.
			UpdateSecondsRemaining();
			updateMessage.Add( secondsRemaining );

			// Tell everyone about everyone else's state.
			foreach ( Player p in Players ) {
				updateMessage.Add( p.Id, p.x, p.y, p.z, p.isDucking );
			}

			// Broadcast message to all players.
			Broadcast( updateMessage );
		}

		private void UpdateSecondsRemaining() {
			secondsRemaining = 1000; // Default seconds remaining to 1000.
			if ( currentGameState == ( int ) GameState.COUNTING_DOWN
			    || currentGameState == ( int ) GameState.FINAL_COUNTDOWN
			    ) {
				double timeElapsed = ( DateTime.UtcNow - countdownStartTime ).TotalMilliseconds;
				secondsRemaining = Math.Ceiling( ( ( maxSeconds * 1000 ) - timeElapsed ) * .001 );
				if ( secondsRemaining <= 0 ) {
					currentGameState = ( int ) GameState.PLAYING;
				} else if ( secondsRemaining <= minJoinTime ) {
					currentGameState = ( int ) GameState.FINAL_COUNTDOWN;
				}
			}
		}
	}
}