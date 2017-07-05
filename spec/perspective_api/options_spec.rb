require "spec_helper"

RSpec.describe PerspectiveAPI::Options do
  before :each do
    PerspectiveAPI::Options.reset
  end

  it "defaults to requesting the toxicity attribute without limits" do
    expect(PerspectiveAPI::Options.get).to eq(
      :attributes => {"TOXICITY" => {}}
    )
  end

  it "can set new defaults" do
    PerspectiveAPI::Options.set :do_not_store => true

    expect(PerspectiveAPI::Options.get).to eq(
      :attributes   => {"TOXICITY" => {}},
      :do_not_store => true
    )
  end

  it "can reset defaults" do
    PerspectiveAPI::Options.set :do_not_store => true
    PerspectiveAPI::Options.reset

    expect(PerspectiveAPI::Options.get).to eq(
      :attributes => {"TOXICITY" => {}}
    )
  end

  it "can merge defaults to a working set" do
    options = PerspectiveAPI::Options.apply :do_not_store => true

    expect(PerspectiveAPI::Options.get).to eq(
      :attributes => {"TOXICITY" => {}}
    )
    expect(options).to eq(
      :attributes   => {"TOXICITY" => {}},
      :do_not_store => true
    )
  end

  it "does not allow unknown keys when setting" do
    expect do
      PerspectiveAPI::Options.set :foo => "bar"
    end.to raise_error(PerspectiveAPI::Options::UnexpectedOptionsError)
  end

  it "does not allow unknown keys when applying" do
    expect do
      PerspectiveAPI::Options.apply :foo => "bar"
    end.to raise_error(PerspectiveAPI::Options::UnexpectedOptionsError)
  end
end
