defmodule ExMonGameTest do
  use ExUnit.Case

  alias ExMon.{Game, Player}

  describe "start/2" do
    test "starts the game state" do
      player = Player.build("Marcelo", :chute, :soco, :cura)
      computer = Player.build("Computador", :chute, :soco, :cura)

      assert {:ok, _pid} = Game.start(computer, player)
    end
  end

  describe "info/0" do
    test "return the current game state" do
      player = Player.build("Marcelo", :chute, :soco, :cura)
      computer = Player.build("Computador", :chute, :soco, :cura)

      Game.start(computer, player)

      expected_response = %{
        computer: %Player{
          life: 100,
          moves: %{move_average: :chute, move_heal: :cura, move_random: :soco},
          name: "Computador"
        },
        player: %Player{
          life: 100,
          moves: %{move_average: :chute, move_heal: :cura, move_random: :soco},
          name: "Marcelo"
        },
        status: :started,
        turn: :player
      }

      assert expected_response == Game.info()
    end
  end

  describe "update/1" do
    test "returns the game state updated" do
      player = Player.build("Marcelo", :chute, :soco, :cura)
      computer = Player.build("Computador", :chute, :soco, :cura)

      Game.start(computer, player)

      expected_response = %{
        computer: %Player{
          life: 100,
          moves: %{move_average: :chute, move_heal: :cura, move_random: :soco},
          name: "Computador"
        },
        player: %Player{
          life: 100,
          moves: %{move_average: :chute, move_heal: :cura, move_random: :soco},
          name: "Marcelo"
        },
        status: :started,
        turn: :player
      }

      assert expected_response == Game.info()

      new_state = %{
        computer: %Player{
          life: 75,
          moves: %{move_average: :chute, move_heal: :cura, move_random: :soco},
          name: "Computador"
        },
        player: %Player{
          life: 37,
          moves: %{move_average: :chute, move_heal: :cura, move_random: :soco},
          name: "Marcelo"
        },
        status: :started,
        turn: :player
      }

      Game.update(new_state)

      expected_response = %{new_state | turn: :computer, status: :continue}

      assert expected_response == Game.info()
    end
  end

  describe "player/0" do
    test "returns the player info" do
      player = Player.build("Marcelo", :chute, :soco, :cura)
      computer = Player.build("Computador", :chute, :soco, :cura)

      Game.start(computer, player)

      expected_response = %ExMon.Player{
        life: 100,
        moves: %{move_average: :chute, move_heal: :cura, move_random: :soco},
        name: "Marcelo"
      }

      assert expected_response == Game.player()
    end
  end

  describe "turn/0" do
    test "returns the players turn" do
      player = Player.build("Marcelo", :chute, :soco, :cura)
      computer = Player.build("Computador", :chute, :soco, :cura)

      Game.start(computer, player)

      expected_response = :player

      assert expected_response == Game.turn()
    end
  end

  describe "fetch_player/1" do
    test "returns the player" do
      player = Player.build("Marcelo", :chute, :soco, :cura)
      computer = Player.build("Computador", :chute, :soco, :cura)

      Game.start(computer, player)

      expected_response = player

      assert expected_response == Game.fetch_player(:player)
    end
  end
end
