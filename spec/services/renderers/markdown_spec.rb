require "rails_helper"

describe Renderers::Markdown do
  describe ".run" do
    let(:processed) { described_class.run(input) }

    context "with safe input" do
      let(:input) do
        <<~EOS
          - First
          - Second
        EOS
      end

      it "converts to html" do
        expect(processed).to eq(<<~EOS)
          <ul>
          <li>First</li>
          <li>Second</li>
          </ul>
        EOS
      end
    end

    context "with unsafe input" do
      let(:input) { '<script>alert("Hacked!")</script>' }

      it "escapes the input" do
        expect(processed).to eq("<p>alert(&quot;Hacked!&quot;)</p>\n")
      end
    end
  end
end
