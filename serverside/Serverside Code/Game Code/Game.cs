using System;
using System.Collections.Generic;
using System.Text;
using System.Collections;
using PlayerIO.GameLibrary;
using System.Drawing;

namespace FunRun {
	
	// Each player that joins the game will have these attributes.
	public class Player : BasePlayer {
		public string name = "Anonymous";
		public double x = 0;
		public double y = 0;
		public double z = 0;
		public bool isDucking = false;
		public bool isDead = false;
		public Player() {
		}
	}

	[RoomType("Matchmaking")]
	public class MatchmakingCode : Game<Player> {
		
		// Game state.
		enum State { WAITING_FOR_PLAYERS, COUNTING_DOWN };
		private int currentState = ( int ) State.WAITING_FOR_PLAYERS;
		
		// Requirements.
		private const int MIN_REQUIRED_NUM_PLAYERS = 2;

		// Countdown.
		private DateTime countdownStartTime;
		private int maxMs = 15 * 1000;
		private int minJoinMs = 5;
		private double remainingMs = 15 * 1000;

		// Obstacle generation.
		private int randomSeed = ( new Random() ).Next();

		// Game ID.
		private string gameId = System.Guid.NewGuid().ToString();

		public override void GameStarted() {
			remainingMs = maxMs;
			AddTimer( delegate {
				UpdateRemainingMs();
			}, 100 );
		}

		public override bool AllowUserJoin( Player player ) {
			return true;
		}

		public override void UserJoined( Player player ) {
			// Create start message for the joining player.
			Message joinGameMessage = Message.Create( "j" );

			// Give them the game ID to join.
			joinGameMessage.Add( gameId );

			// Random seed for obstacles.
			joinGameMessage.Add( randomSeed );

			// Send message to player.
			player.Send( joinGameMessage );

			// Start countdown if we have enough players.
			if ( PlayerCount == MIN_REQUIRED_NUM_PLAYERS ) {
				currentState = ( int ) State.COUNTING_DOWN;
				countdownStartTime = DateTime.UtcNow;
				// Tell everyone we can start the countdown.
				Message startCountdownMessage = Message.Create( "s" );
				startCountdownMessage.Add( remainingMs );
				Broadcast( startCountdownMessage );
			}
		}

		public override void UserLeft( Player player ) {
			// Restart countdown if we've started counting down,
			// but the number of players has dropped below minimum.
			if ( PlayerCount < MIN_REQUIRED_NUM_PLAYERS ) {
				currentState = ( int ) State.WAITING_FOR_PLAYERS;
				// Tell everybody.
				Message resetMessage = Message.Create( "r" );
				UpdateRemainingMs();
				resetMessage.Add( remainingMs );
				Broadcast( resetMessage );
			}
		}
		
		public override void GotMessage( Player player, Message message ) {
		}

		public override void GameClosed() {
		}

		private void UpdateRemainingMs() {
			remainingMs = maxMs;
			if ( currentState == ( int ) State.COUNTING_DOWN ) {
				double timeElapsed = ( DateTime.UtcNow - countdownStartTime ).TotalMilliseconds;
				remainingMs = maxMs - timeElapsed;
				if ( remainingMs <= minJoinMs ) {
					// Disconnect everybody.
					foreach ( Player p in Players ) {
						p.Disconnect();
					}
				}
			}
		}
	}

	[RoomType("Game")]
	public class GameCode : Game<Player> {

		public override void GameStarted() {
			AddTimer( delegate {
				UpdatePlayers();
			}, 100 );
		}

		public override bool AllowUserJoin( Player player ) {
			return true;
		}

		public override void UserJoined( Player player ) {
			// Assign user-provided data.
			player.name = player.JoinData[ "name" ];
			player.x = Convert.ToDouble( player.JoinData[ "x" ] );
			player.y = Convert.ToDouble( player.JoinData[ "y" ] );

			// Create init message for the joining player.
			Message initMessage = Message.Create( "i" );

			// Tell player their own id, and other initial values.
			initMessage.Add( player.Id );

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
				case "d": // Update death.
					player.isDead = true;
					Message deathMessage = Message.Create( "d" );
					deathMessage.Add( player.Id );
					Broadcast( deathMessage );
					break;
			}
		}

		public override void GameClosed() {
			// This method is called when the last player leaves the room, and it's closed down.
		}

		private void UpdatePlayers() {
			// Create update message.
			Message updateMessage = Message.Create( "u" );

			// Tell everyone about everyone else's state.
			foreach ( Player p in Players ) {
				updateMessage.Add( p.Id, p.x, p.y, p.z, p.isDucking );
			}

			// Broadcast message to all players.
			Broadcast( updateMessage );
		}

	}
}