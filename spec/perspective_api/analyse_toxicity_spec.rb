require "spec_helper"

API_URI = %r{https://commentanalyzer\.googleapis\.com/v1alpha1/comments:analyze}

RSpec.describe PerspectiveAPI::AnalyseToxicity do
  def response_body(score)
    MultiJson.dump(
      "attributeScores" => {
        "TOXICITY" => {
          "spanScores"   => [
            {
              "begin" => 0,
              "end"   => 31,
              "score" => {
                "value" => score,
                "type"  => "PROBABILITY"
              }
            }
          ],
          "summaryScore" => {
            "value" => score,
            "type"  => "PROBABILITY"
          }
        }
      },
      "languages"       => ["en"]
    )
  end

  def request_body(text)
    MultiJson.dump(
      "comment"             => {
        "text" => text,
        "type" => "PLAIN_TEXT"
      },
      "requestedAttributes" => {"TOXICITY" => {}}
    )
  end

  before :each do
    PerspectiveAPI::Options.reset

    stub_request(:post, API_URI).to_return(
      :status => 200, :body => response_body(0.9967299)
    )
  end

  it "makes a request" do
    PerspectiveAPI::AnalyseToxicity.call("hello", :plain_text, {})

    expect(
      a_request(:post, API_URI).
      with(:body => request_body("hello"))
    ).to have_been_made.once
  end

  it "returns the JSON response" do
    response = PerspectiveAPI::AnalyseToxicity.call("hello", :plain_text, {})

    expect(response.keys).to eq(%w[ attributeScores languages ])
  end

  it "handles exceptions" do
    WebMock.reset!

    stub_request(:post, API_URI).to_return(
      :status => 400, :body => MultiJson.dump(
        "error" => {
          "code"    => 400,
          "message" => "No requested attributes specified.",
          "status"  => "INVALID_ARGUMENT"
        }
      )
    )

    expect do
      PerspectiveAPI::AnalyseToxicity.call("hello", :plain_text, {})
    end.to raise_error(PerspectiveAPI::RequestError)
  end

  it "respects default options" do
    PerspectiveAPI::AnalyseToxicity.call("hello", :plain_text, {})

    expect(
      a_request(:post, API_URI).
      with do |request|
        json = MultiJson.load(request.body)
        json["requestedAttributes"] == {"TOXICITY" => {}}
      end
    ).to have_been_made.once
  end

  it "respects provided options" do
    PerspectiveAPI::AnalyseToxicity.call "hello", :plain_text,
      :do_not_store => true

    expect(
      a_request(:post, API_URI).
      with do |request|
        json = MultiJson.load(request.body)
        json["doNotStore"] == true
      end
    ).to have_been_made.once
  end
end
