require_relative "../lib/grid"

describe Grid do
  describe "#drop_token" do
    context "when the column is empty" do
      subject(:game_grid) { described_class.new }
      it "drop to the bottom" do
        game_grid.drop_token(3, "O")
        expect(game_grid.grid[0][2]).to eq("O")
      end
    end

    context "when the column is not empty" do
      subject(:game_grid) do
        described_class.new([
                              ["X", " ", " ", " ", " ", " ", " "], # Bottom row
                              ["X", " ", " ", " ", " ", " ", " "],
                              ["X", " ", " ", " ", " ", " ", " "],
                              ["X", " ", " ", " ", " ", " ", " "],
                              [" ", " ", " ", " ", " ", " ", " "],
                              [" ", " ", " ", " ", " ", " ", " "]
                            ])
      end
      it "drop to the bottom" do
        game_grid.drop_token(1, "O")
        expect(game_grid.grid[4][0]).to eq("O")
      end
    end
  end

  describe "#valid_move?" do
    context "when the column is full"
    subject(:game_valid) do
      described_class.new([
                            ["X", "X", " ", " ", " ", " ", " "], # Bottom row
                            ["X", " ", " ", " ", " ", " ", " "],
                            ["X", " ", " ", " ", " ", " ", " "],
                            ["X", " ", " ", " ", " ", " ", " "],
                            ["X", " ", " ", " ", " ", " ", " "],
                            ["X", " ", " ", " ", " ", " ", " "]
                          ])
    end
    it "return true" do
      expect(game_valid.valid_move?(2)).to be true
    end

    it "return true" do
      expect(game_valid.valid_move?(5)).to be true
    end

    it "return false" do
      expect(game_valid.valid_move?(1)).to be false
    end

    it "return false when column doesn't exist" do
      expect(game_valid.valid_move?(33)).to be false
    end
  end
end
