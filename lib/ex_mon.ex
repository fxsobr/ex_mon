defmodule ExMon do
  alias ExMon.Player
  def create_player(name, move_average, move_random, move_heal) do
    Player.build(name, move_average, move_random, move_heal)
  end
end
