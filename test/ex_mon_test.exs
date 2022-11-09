defmodule ExMonTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias ExMon.Player

  describe "create_player/4" do
    test "returns a created player" do
      expected_response = %Player{life: 100, moves: %{move_average: :chute, move_heal: :cura, move_random: :soco}, name: "Marcelo"}
      assert expected_response == ExMon.create_player("Marcelo", :chute, :soco, :cura)
    end
  end

  describe "start_game/1" do
    test "when the game is started, return a message" do
      player = Player.build("Marcelo", :chute, :soco, :cura)

      messages = capture_io(fn ->
        assert ExMon.start_game(player) == :ok
      end)

      assert messages =~ "The game is started"
    end
  end
end
