using System;
using System.Collections.Generic;
using System.Text;
using System.Collections;
using PlayerIO.GameLibrary;
using System.Drawing;

namespace FunRun {
	
	// Each player that joins the game will have these attributes.
	public class Player : BasePlayer {
		public string id;
		//public float de;
		//public float du;
		public float x;
		public float y;
		public float z;
		public float vx;
		public float vy;
		public float vz;
		public Player() {
		}
	}

	[RoomType("Game")]
	public class GameCode : Game<Player> {

		private Dictionary<string, int> dictionary = new Dictionary<string, int>();

		private DateTime countdownStartTime;
		private bool isRunning = false;
		private int maxSeconds = 8;

		public override void GameStarted() {
			countdownStartTime = DateTime.UtcNow;
			// Update every 100 ms.
			AddTimer( delegate {
				double secondsRemaining = 0;
				if ( !isRunning ) {
					// Continue countdown if not running yet.
					double timeElapsed = ( DateTime.UtcNow - countdownStartTime ).TotalMilliseconds;
					secondsRemaining = Math.Ceiling( ( ( maxSeconds * 1000 ) - timeElapsed ) * .001 );
					if ( secondsRemaining <= 0 ) {
						// Start running!
						isRunning = true;
					}
				}

				// Create update message.
				Message updateMessage = Message.Create( "update" );
				updateMessage.Add( secondsRemaining );
				/*
				// Tell everyone about everyone else's state.
				foreach ( Player p in Players ) {
					updateMessage.Add( p.id, p.x, p.y, p.z, p.vx, p.vy, p.vz );
				}
*/
				// Broadcast message to all players.
				Broadcast( updateMessage );
			}, 100 );
		}

		public override bool AllowUserJoin( Player player ) {
			// TO-DO: Check if game has started already. If it has, return false.
			return true;
		}

		public override void UserJoined( Player player ) {
			// Create init message for the joining player.
			Message initMessage = Message.Create( "init" );

			// Tell player their own id
			initMessage.Add( player.Id );

			// Add the current state of all players to the init message.
			//foreach ( Player p in Players ) {
			//	init.Add( p.id, p.x, p.y, p.z, p.vx, p.vy, p.vz );
			//}

			// Send init message to player.
			player.Send( initMessage );
		}

		public override void UserLeft( Player player ) {
			//Inform all other players that user left.
			Broadcast( "left", player.id );
		}
		
		public override void GotMessage( Player player, Message message ) {
			switch ( message.Type ) {
				case "UPDATE":
					// Update internal representation of player.
					player.x = message.GetFloat( 0 );
					player.y = message.GetFloat( 1 );
					player.z = message.GetFloat( 2 );
					player.vx = message.GetFloat( 3 );
					player.vy = message.GetFloat( 4 );
					player.vz = message.GetFloat( 5 );
					break;
			}
		}
	}
}









/*
SNIPPPETS
 
 
		//Create array to store our letters
		private Letter[] letters = new Letter[230];
		
 
			// add a timer that sends out an update every 100th millisecond
			AddTimer(delegate {
				//Create update message
				Message update = Message.Create("update");

				//Add mouse cordinates for each player to the message
				foreach(Player p in Players) {
					update.Add(p.Id, p.X, p.Y);
				}

				//Broadcast message to all players
				Broadcast(update);
			}, 100);	
 
 

		// This method is called when the last player leaves the room, and it's closed down.
		public override void GameClosed() {
		}
 
 // This method is called when a player sends a message into the server code
		public override void GotMessage(Player player, Message message) {
			//Switch on message type
			switch(message.Type) {
				case "move": {
						//Move letter in internal representation
						Letter l = letters[message.GetInteger(0)];
						l.X = message.GetInteger(1);
						l.Y = message.GetInteger(2);

						//inform all players that the letter have been moved
						Broadcast("move", message.GetInteger(0), l.X, l.Y);
						break;
					}
				case "mouse": {
						//Set player mouse information
						player.X = message.GetInteger(0);
						player.Y = message.GetInteger(1);
						break;
					}
				case "activate": {
						Broadcast("activate", player.Id, message.GetInteger(0));
						break;
					}
			}
		}
 
 

			// Create init message for the joining player
			Message m = Message.Create("init");

			// Tell player their own id
			m.Add(player.Id);

			//Add the current position of all letters to the init message
			for(int a = 0; a < letters.Length; a++) {
				Letter l = letters[a];
				m.Add(l.X, l.Y);
			}

			// Send init message to player
			player.Send(m);
			
 
 
 
 
 */