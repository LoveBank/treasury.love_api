require "rails_helper"

RSpec.describe WelcomeMailer, type: :mailer do
  describe "welcome" do
    let(:user) { FactoryGirl.create :user }
    let(:mail) { WelcomeMailer.welcome(user) }

    it "renders the headers" do
      expect(mail.subject).to eq("Welcome to Treasury.Love - Begin your Love-Journaling Journey")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["noreply@mg.treasury.love"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
