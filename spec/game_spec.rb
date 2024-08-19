require "colorize"
require_relative "../lib/game"

describe Game do
  before do
    allow_any_instance_of(Player).to receive(:pick_token).and_return(RED_TOKEN)
  end
  describe "#initialize" do
    context "When Player 1 is Red" do
      it "Player 2 is yellow" do
        game = Game.new
        player2 = game.instance_variable_get(:@player2)
        expect(player2.token).to eq(YELLOW_TOKEN)
      end
    end

    context "When Player 1 is Yellow" do
      before do
        allow_any_instance_of(Player).to receive(:pick_token).and_return(YELLOW_TOKEN)
      end
      it "Player 2 is red" do
        game = Game.new
        player2_token = game.instance_variable_get(:@player2).token
        expect(player2_token).to eq(RED_TOKEN)
      end
    end
  end

  describe "#game_over?" do
    let(:player1) { instance_double(Player, token: RED_TOKEN) }
    context "When there is 4 continous token on one row" do
      subject(:new_game) do
        described_class.new(Grid.new([
                                       [" ", " ", " ", " ", " ", " ", " "], # Bottom row
                                       [" ", " ", " ", RED_TOKEN, " ", " ", " "],
                                       [RED_TOKEN, YELLOW_TOKEN, YELLOW_TOKEN, YELLOW_TOKEN, YELLOW_TOKEN, " ", " "],
                                       [" ", RED_TOKEN, " ", " ", YELLOW_TOKEN, " ", " "],
                                       [" ", " ", " ", RED_TOKEN, " ", " ", " "],
                                       [" ", " ", " ", " ", " ", " ", " "]
                                     ]), player1)
      end
      it "return true" do
        expect(new_game).to be_game_over
      end
    end

    context "When there is four continous token in a column" do
      subject(:new_game) do
        described_class.new(Grid.new([
                                       [RED_TOKEN, RED_TOKEN, RED_TOKEN, " ", " ", " ", " "], # Bottom row
                                       [RED_TOKEN, " ", RED_TOKEN, " ", " ", " ", " "],
                                       [YELLOW_TOKEN, " ", RED_TOKEN, " ", " ", " ", " "],
                                       [RED_TOKEN, " ", RED_TOKEN, " ", " ", " ", " "],
                                       [YELLOW_TOKEN, " ", " ", " ", " ", " ", " "],
                                       [" ", " ", " ", " ", " ", " ", " "]
                                     ]), player1)
      end
      it "return true" do
        expect(new_game).to be_game_over
      end
    end

    context "When there is four continous token in diagonal" do
      subject(:new_game) do
        described_class.new(Grid.new([
                                       [RED_TOKEN, " ", " ", " ", " ", " ", " "], # Bottom row
                                       [" ", YELLOW_TOKEN, " ", " ", " ", " ", " "],
                                       [" ", " ", YELLOW_TOKEN, RED_TOKEN, " ", " ", " "],
                                       [" ", " ", RED_TOKEN, YELLOW_TOKEN, " ", " ", " "],
                                       [" ", " ", " ", RED_TOKEN, YELLOW_TOKEN, " ", " "],
                                       [" ", " ", " ", " ", " ", " ", " "]
                                     ]), player1)
      end
      it "return true" do
        expect(new_game).to be_game_over
      end
    end

    context "When there is four continous token in the other diagonal way" do
      subject(:new_game) do
        described_class.new(Grid.new([
                                       [" ", " ", " ", " ", " ", " ", YELLOW_TOKEN], # Bottom row
                                       [" ", " ", " ", " ", " ", RED_TOKEN, " "],
                                       [" ", " ", " ", " ", RED_TOKEN, " ", " "],
                                       [" ", " ", YELLOW_TOKEN, RED_TOKEN, " ", " ", " "],
                                       [" ", " ", RED_TOKEN, YELLOW_TOKEN, " ", " ", " "],
                                       [" ", YELLOW_TOKEN, " ", " ", " ", " ", " "]
                                     ]), player1)
      end
      it "return true" do
        expect(new_game).to be_game_over
      end
    end

    context "When nobody has won" do
      subject(:new_game) do
        described_class.new(Grid.new([
                                       [" ", YELLOW_TOKEN, RED_TOKEN, RED_TOKEN, RED_TOKEN, " ", " "], # Bottom row
                                       [" ", YELLOW_TOKEN, " ", " ", " ", RED_TOKEN, YELLOW_TOKEN],
                                       [" ", YELLOW_TOKEN, YELLOW_TOKEN, " ", " ", " ", " "],
                                       [" ", " ", RED_TOKEN, RED_TOKEN, " ", " ", " "],
                                       [" ", " ", RED_TOKEN, YELLOW_TOKEN, RED_TOKEN, YELLOW_TOKEN, " "],
                                       [" ", " ", " ", YELLOW_TOKEN, " ", " ", " "]
                                     ]), player1)
      end
      it "return false" do
        expect(new_game).not_to be_game_over
      end
    end
  end
end
