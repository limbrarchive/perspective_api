require "spec_helper"

RSpec.describe PerspectiveAPI do
  before :each do
    allow(PerspectiveAPI::AnalyseToxicity).to receive(:call).and_return(
      "attributeScores" => {
        "TOXICITY" => {
          "summaryScore" => {
            "value" => 0.546
          }
        }
      }
    )
  end

  describe "#analyse_toxicity" do
    it "passes request through to AnalyseToxicity" do
      expect(PerspectiveAPI::AnalyseToxicity).to receive(:call).
        with("foo", :plain_text, :do_not_store => true)

      PerspectiveAPI.analyse_toxicity("foo", :plain_text, :do_not_store => true)
    end

    it "accepts just text and options" do
      expect(PerspectiveAPI::AnalyseToxicity).to receive(:call).
        with("foo", nil, :do_not_store => true)

      PerspectiveAPI.analyse_toxicity("foo", :do_not_store => true)
    end
  end

  describe "#toxicity_score" do
    it "returns the summary toxicity score" do
      expect(
        PerspectiveAPI.toxicity_score("foo", :plain_text)
      ).to eq(0.546)
    end

    it "accepts just text and options" do
      expect(PerspectiveAPI::AnalyseToxicity).to receive(:call).
        with("foo", nil, :do_not_store => true)

      PerspectiveAPI.toxicity_score("foo", :do_not_store => true)
    end
  end
end
