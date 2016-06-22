require "rails_helper"

RSpec.describe RenderMessage do
  describe "#call" do
    def render(nickname, created_at, content, announcement: false)
      RenderMessage.new(nickname, created_at, content, announcement: announcement).call
    end

    before { travel_to Time.new(2016, 1, 1, 0, 0, 0) }
    after { travel_back }

    it "renders correct HTML" do
      result = render("realDonaldTrump", Time.current, "Make America Great Again")

      expect(result).to eq %(<div class=\"message-body\"><strong>realDonaldTrump </strong><span class=\"text-muted\"><time datetime=\"2015-12-31T16:00:00Z\" data-local=\"time-ago\">December 31, 2015  4:00pm</time></span><p class=\"message-body \">Make America Great Again</p></div>)
    end

    context "announcement" do
      it "renders correct HTML with announcement class on content" do
        result = render("RedDotRubyConf2016", Time.current, "Lunch time!", announcement: true)

        expect(result).to include %(<p class=\"message-body announcement\">Lunch time!</p>)
      end
    end
  end
end
