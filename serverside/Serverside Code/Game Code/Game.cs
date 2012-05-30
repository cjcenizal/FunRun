﻿using System;
using System.Collections.Generic;
using System.Text;
using System.Collections;
using PlayerIO.GameLibrary;
using System.Drawing;

namespace FunRun {
	
	// Each player that joins the game will have these attributes.
	public class Player : BasePlayer {
		//public float de;
		//public float du;
		public double x = 0;
		public double y = 0;
		public double z = 0;
		public double vx = 0;
		public double vy = 0;
		public double vz = 0;
		public Player() {
		}
	}

	[RoomType("Game")]
	public class GameCode : Game<Player> {

		private DateTime countdownStartTime;
		private bool isRunning = false;
		private int maxSeconds = 15;
		private double secondsRemaining = 0;
		private int minJoinTime = 5;
		private int currentFillPosition = -1;
		private int randomSeed = ( new Random() ).Next();

		public override void GameStarted() {
			// Update every 100 ms.
			AddTimer( delegate {
				if ( !isRunning ) {
					updateSecondsRemaining();
					if ( secondsRemaining <= 0 ) {
						// Start running!
						isRunning = true;
					}
				}
				broadcastUpdate();
			}, 100 );
		}

		public override bool AllowUserJoin( Player player ) {
			// This is called before GameStarted, so we will set up our countdown here, when the first player joins.
			if ( PlayerCount == 0 ) {
				countdownStartTime = DateTime.UtcNow;
			}
			updateSecondsRemaining();
			// Return whether or not game has already started.
			return true;//( secondsRemaining > minJoinTime );
		}

		public override void UserJoined( Player player ) {
			// Create init message for the joining player.
			Message initMessage = Message.Create( "i" );

			// Tell player their own id
			initMessage.Add( player.Id );

			// Random seed.
			initMessage.Add( randomSeed );
			
			// Update and add time remaining.
			updateSecondsRemaining();
			initMessage.Add( secondsRemaining );

			// Add obstacles.

			// Add the current state of all players to the init message.
			foreach ( Player p in Players ) {
				initMessage.Add( p.Id, p.x, p.y, p.z, p.vx, p.vy, p.vz );
			}
			
			// Send init message to player.
			player.Send( initMessage );

			// Let everyone know who's here.
			Message newPlayerMessage = Message.Create( "n" );
			newPlayerMessage.Add( player.Id, player.x, player.y, player.z, player.vx, player.vy, player.vz );
			Broadcast( newPlayerMessage );
		}

		public override void UserLeft( Player player ) {
			//Inform all other players that user left.
			Broadcast( "l", player.Id );
		}
		
		public override void GotMessage( Player player, Message message ) {
			switch ( message.Type ) {
				case "u": // Update state.
					// Update internal representation of player.
					player.x = message.GetDouble( 0 );
					player.y = message.GetDouble( 1 );
					player.z = message.GetDouble( 2 );
					player.vx = message.GetDouble( 3 );
					player.vy = message.GetDouble( 4 );
					player.vz = message.GetDouble( 5 );
					break;
			}
		}

		// This method is called when the last player leaves the room, and it's closed down.
		public override void GameClosed() {
		}

		private void broadcastUpdate() {
			// Create update message.
			Message updateMessage = Message.Create( "u" );
			updateMessage.Add( secondsRemaining );

			// Tell everyone about everyone else's state.
			foreach ( Player p in Players ) {
				updateMessage.Add( p.Id, p.x, p.y, p.z, p.vx, p.vy, p.vz );
			}

			// Broadcast message to all players.
			Broadcast( updateMessage );
		}

		private void updateSecondsRemaining() {
			double timeElapsed = ( DateTime.UtcNow - countdownStartTime ).TotalMilliseconds;
			secondsRemaining = Math.Ceiling( ( ( maxSeconds * 1000 ) - timeElapsed ) * .001 );
		}
	}
}