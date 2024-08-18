require "colorize"
require_relative "../lib/player"

describe Player do
  describe "#pick_token" do
    subject(:new_player) { described_class.new("0") }
    context "when input correctly" do
      before do
        allow(new_player).to receive(:gets).and_return("1")
        allow(new_player).to receive(:print)
      end

      it "return symble equivlent to the input value" do
        expect(new_player.pick_token).to eq("O".colorize(:red))
      end
    end

    context "when inputs 3 incorrect value and a correct one" do
      before do
        allow(new_player).to receive(:gets).and_return("@", "3", "asad", "1")
        allow(new_player).to receive(:print)
      end

      it "End loop and receive error message thrice" do
        error_message = "Please choose between 1 and 2"
        expect(new_player).to receive(:puts).with(error_message).exactly(3).times
        new_player.pick_token
      end
    end
  end

  describe "#make_move" do
    subject(:new_player) { described_class.new("X") }
    context "when input correctly" do
      before do
        allow(new_player).to receive(:gets).and_return("3")
      end
      it "return the input value" do
        expect(new_player.make_move).to eq(3)
      end
    end
  end
end
