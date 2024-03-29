﻿using System;
using System.Collections.Generic;
using System.Text;
using System.Collections;
using PlayerIO.GameLibrary;
using System.Drawing;

namespace FunRun {
	
	// Each player that joins the game will have these attributes.
	public class Player : BasePlayer {
		public string name = "Anonymous";
		public string id = "id";
		public double x = 0;
		public double y = 0;
		public double z = 0;
		public bool isDucking = false;
		public bool isDead = false;
		public bool isReady = false;
		public string character = "0";
		public Player() {
		}
	}
	
	[RoomType("Lobby")]
	public class Lobby : Game<Player> {

		public override void GameStarted() {

		}
		
		public override bool AllowUserJoin( Player player ) {
			return true;
		}
		
		public override void UserJoined( Player player ) {
			// Assign user-provided data.
			player.name = player.JoinData[ "name" ];
			player.id = player.JoinData[ "id" ];
			
			// Tell the new guy who's already here.
			Message welcomeMessage = Message.Create( "w" );
			foreach ( Player p in Players ) {
				welcomeMessage.Add( p.name, p.Id );
			}
			player.Send( welcomeMessage );

			// Tell everyone the new guy is here.
			Message joinMessage = Message.Create( "j" );
			joinMessage.Add( player.name );
			joinMessage.Add( player.Id );
			Broadcast( joinMessage );
		}
		
		public override void UserLeft( Player player ) {
			// Create leave message.
			Message leaveMessage = Message.Create( "l" );
			leaveMessage.Add( player.name );
			leaveMessage.Add( player.id );
			Broadcast( leaveMessage );
		}
		
		public override void GotMessage( Player player, Message message ) {
			switch ( message.Type ) {
				case "c": // Chat.
					// Create chat message.
					Message chatMessage = Message.Create( "c" );
					string name = message.GetString( 0 );
					string msg = message.GetString( 1 );
					chatMessage.Add( name, msg );
					Broadcast( chatMessage );
					break;
			}
		}
		
		public override void GameClosed() {
		}
	}

	[RoomType("Matchmaking")]
	public class MatchmakingCode : Game<BasePlayer> {

		/**
		 * When you join a Matchmaking room, you are assigned
		 * to join a specific game room.
		 * 
		 * The Matchmaking room keeps track of people joining
		 * and leaving.
		 * 
		 * When the game is ready to begin, it tells everyone
		 * to begin the game, and disconnects everyone
		 * from the Matchmaking room.
		 */
		
		// Limits.
		private const int REQUIRED_NUM_PLAYERS = 4;

		// Game state.
		private int numPlayers = 0;
		private Dictionary<int, Boolean> readyPlayers = new Dictionary<int, Boolean>();

		// Game ID.
		private string gameId = System.Guid.NewGuid().ToString();

		public override void UserJoined( BasePlayer player ) {
			numPlayers++;
			readyPlayers.Add( player.Id, false );

			// Create start message for the joining player.
			Message joinGameMessage = Message.Create( "j" );
			joinGameMessage.Add( gameId );
			player.Send( joinGameMessage );

			if ( numPlayers == REQUIRED_NUM_PLAYERS ) {
				StartGame();
			}
		}
		
		public override void UserLeft( BasePlayer player ) {
			numPlayers--;
			readyPlayers.Remove( player.Id );
		}
		
		public override void GotMessage( BasePlayer player, Message message ) {
			switch ( message.Type ) {
				case "r": // Ready.
					readyPlayers[ player.Id ] = true;
					if ( numPlayers > 1 && AllPlayersAreReady() ) {
						StartGame();
					}
					break;
			}
		}

		private Boolean AllPlayersAreReady() {
			foreach ( KeyValuePair<int, Boolean> player in readyPlayers ) {
				if ( !player.Value ) {
					return false;
				}
			}
			return true;
		}

		private void StartGame() {
			// Tell everyone we can start the countdown.
			Message startCountdownMessage = Message.Create( "s" );
			Broadcast( startCountdownMessage );

			// Disconnect everybody.
			foreach ( BasePlayer p in Players ) {
				p.Disconnect();
			}

			// Reset.
			numPlayers = 0;
			readyPlayers.Clear();
			gameId = System.Guid.NewGuid().ToString();
		}
		
		public override bool AllowUserJoin( BasePlayer player ) {
			return true;
		}
	}

	[RoomType("Game")]
	public class GameCode : Game<Player> {
		
		// Obstacle generation.
		private int randomObstacleSeed = ( new Random() ).Next();

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
			player.id = player.JoinData[ "id" ];
			player.x = Convert.ToDouble( player.JoinData[ "x" ] );
			player.y = Convert.ToDouble( player.JoinData[ "y" ] );
			player.character = player.JoinData[ "char" ];

			// Create init message for the joining player.
			Message initMessage = Message.Create( "i" );
			initMessage.Add( player.Id );
			initMessage.Add( randomObstacleSeed );

			// Add the current state of all players to the init message.
			foreach ( Player p in Players ) {
				initMessage.Add( p.Id, p.name, p.x, p.y, p.z, p.isDucking, p.isReady, p.character );
			}
			
			// Send init message to player.
			player.Send( initMessage );

			// Let everyone know who's here.
			Message newPlayerMessage = Message.Create( "n" );
			newPlayerMessage.Add( player.Id, player.name, player.x, player.y, player.z, player.isDucking, player.isReady, player.character );
			Broadcast( newPlayerMessage );
		}

		public override void UserLeft( Player player ) {
			// Inform all other players that user left.
			Broadcast( "l", player.Id );
		}
		
		public override void GotMessage( Player player, Message message ) {
			switch ( message.Type ) {
				case "r": // Ready.
					player.isReady = true;
					Message readyMessage = Message.Create( "r" );
					readyMessage.Add( player.Id );
					Broadcast( readyMessage );
					break;
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