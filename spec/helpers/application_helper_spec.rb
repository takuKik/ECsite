require 'rails_helper'

RSpec.describe ApplicationHelper do
  describe "#full_title" do
    context "when the argument has a value" do
      it "shows a full title" do
        expect(helper.full_title("test")).to eq("test | BIGBAG Store")
      end
    end

    context "when the argument doesn't have a value" do
      it "shows a base title" do
        expect(helper.full_title("")).to eq("BIGBAG Store")
      end
    end
  end
end
