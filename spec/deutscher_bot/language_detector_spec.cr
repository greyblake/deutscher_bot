require "../spec_helper"

describe DeutscherBot::LanguageDetector do
  describe "detect" do
    it "detects russian" do
      DeutscherBot::LanguageDetector.new("Круто!").detect.should eq "ru"
    end

    it "detects german" do
      DeutscherBot::LanguageDetector.new("Schön!").detect.should eq "de"
    end
  end
end
